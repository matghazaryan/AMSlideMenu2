//
//  LeftMenuTVC.h
//  testProject
//
//  Created by artur on 2/14/14.
//  Copyright (c) 2014 artur. All rights reserved.
//

#import "AMSlideMenuLeftTableViewController.h"

@interface LeftMenuTVC : AMSlideMenuLeftTableViewController


#pragma mark - Outlets
@property (strong, nonatomic) IBOutlet UITableView *view;

#pragma mark - Properties
@property (strong, nonatomic) NSMutableArray *tableData;

@end
