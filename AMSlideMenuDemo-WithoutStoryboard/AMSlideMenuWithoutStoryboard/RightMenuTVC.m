//
//  RightMenuTVC.m
//  testProject
//
//  Created by artur on 2/14/14.
//  Copyright (c) 2014 artur. All rights reserved.
//

#import "RightMenuTVC.h"
#import "ForthVC.h"
#import "FiveVC.h"

@interface RightMenuTVC ()

@end

@implementation RightMenuTVC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    // Initilizing data souce
    self.tableData = [@[@"VC 4",@"VC 5"] mutableCopy];
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
    UIViewController *rootVC;
    switch (indexPath.row) {
        case 0:
        {
            rootVC = [[ForthVC alloc] initWithNibName:@"ForthVC" bundle:nil];
        }
            break;
        case 1:
        {
            rootVC = [[FiveVC alloc] initWithNibName:@"FiveVC" bundle:nil];
        }
            break;
        default:
            break;
    }
    nvc = [[UINavigationController alloc] initWithRootViewController:rootVC];
    [self openContentNavigationController:nvc];
}


@end
