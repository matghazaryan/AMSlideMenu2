//
//  AMSlideMenuRightTableViewController.m
//  AMSlideMenu
//
//  Created by Artur Mkrtchyan on 12/24/13.
//  Copyright (c) 2013 Artur Mkrtchyan. All rights reserved.
//

#import "AMSlideMenuRightTableViewController.h"

#import "AMSlideMenuMainViewController.h"

@interface AMSlideMenuRightTableViewController ()

@end

@implementation AMSlideMenuRightTableViewController

/*----------------------------------------------------*/
#pragma mark - Lifecycle -
/*----------------------------------------------------*/

- (void)viewDidLoad
{
    [super viewDidLoad];
}

#ifdef AMSlideMenuWithoutStoryboards
- (void)openContentNavigationController:(UINavigationController *)nvc
{
    AMSlideMenuContentSegue *contentSegue = [[AMSlideMenuContentSegue alloc] initWithIdentifier:@"contentSegue" source:self destination:nvc];
    [contentSegue perform];
}
#endif

/*----------------------------------------------------*/
#pragma mark - TableView delegate -
/*----------------------------------------------------*/

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *segueIdentifier = [self.mainVC segueIdentifierForIndexPathInRightMenu:indexPath];
    if (segueIdentifier && segueIdentifier.length > 0)
    {
        [self performSegueWithIdentifier:segueIdentifier sender:self];
    }
}


@end
