//
//  LeftMenuTVC.m
//  testProject
//
//  Created by artur on 2/14/14.
//  Copyright (c) 2014 artur. All rights reserved.
//

#import "LeftMenuTVC.h"
#import "FirstVC.h"
#import "SecondVC.h"
#import "ThirdVC.h"

@interface LeftMenuTVC ()

@end

@implementation LeftMenuTVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    // Initilizing data souce
    self.tableData = [@[@"VC 1",@"VC 2",@"VC 3"] mutableCopy];
}

#pragma mark - TableView Datasource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.tableData count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (!cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
    }
    
    cell.textLabel.text = self.tableData[indexPath.row];
    
    return cell;
}
#pragma mark - TableView Delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UINavigationController *nvc;
    switch (indexPath.row) {
        case 0:
        {
            FirstVC *firstVC = [[FirstVC alloc] initWithNibName:@"FirstVC" bundle:nil];
            nvc = [[UINavigationController alloc] initWithRootViewController:firstVC];
        }
            break;
        case 1:
        {
            SecondVC *secondVC = [[SecondVC alloc] initWithNibName:@"SecondVC" bundle:nil];
            nvc = [[UINavigationController alloc] initWithRootViewController:secondVC];
        }
            break;
        case 2:
        {
            ThirdVC *thirdVC = [[ThirdVC alloc] initWithNibName:@"ThirdVC" bundle:nil];
            nvc = [[UINavigationController alloc] initWithRootViewController:thirdVC];
        }
            break;
        
        default:
            break;
    }
    
    [self openContentNavigationController:nvc];
}

@end
