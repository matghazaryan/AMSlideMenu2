//
//  Slide1VC.m
//  AMSlideMenu
//
//  Created by Artur Mkrtchyan on 1/27/14.
//  Copyright (c) 2014 SocialObjects Software. All rights reserved.
//

#import "Slide1VC.h"
#import "UIViewController+AMSlideMenu.h"
#import "UIColor+CreateMethods.h"

@interface Slide1VC () <UITableViewDataSource, UIAccelerometerDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation Slide1VC

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    // Setting navigation's bar tint color
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithHex:@"#365491" alpha:1];
}

#pragma mark - TableView Deletage and Datasouce methods
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
    }
    cell.textLabel.text = @"Test swipe to delete functionality";
    
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {

    }
}

@end
