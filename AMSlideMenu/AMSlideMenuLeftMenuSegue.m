//
//  AMSlideMenuLeftMenuSegue.m
//  AMSlideMenu
//
//  Created by Artur Mkrtchyan on 12/24/13.
//  Copyright (c) 2013 SocialObjects Software. All rights reserved.
//

#import "AMSlideMenuLeftMenuSegue.h"

#import "AMSlideMenuMainViewController.h"
#import "AMSlideMenuLeftTableViewController.h"

@implementation AMSlideMenuLeftMenuSegue

/*----------------------------------------------------*/
#pragma mark - Actions -
/*----------------------------------------------------*/

- (void)perform
{
    AMSlideMenuMainViewController* mainVC = self.sourceViewController;
    AMSlideMenuLeftTableViewController* leftMenu = self.destinationViewController;
    
    mainVC.leftMenu = leftMenu;
    leftMenu.mainVC = mainVC;
    
    [mainVC addChildViewController:leftMenu];
    
    double delayInSeconds = 0.0;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        CGRect bounds = mainVC.view.bounds;
        leftMenu.view.frame = CGRectMake(0,0,bounds.size.width,bounds.size.height);
    });

    [mainVC.view addSubview:leftMenu.view];
    
    [leftMenu.navigationController setNavigationBarHidden:YES];
    
    NSIndexPath *initialIndexPath = [mainVC initialIndexPathForLeftMenu];
    
#ifndef AMSlideMenuWithoutStoryboards
    NSString *segueIdentifier = [mainVC segueIdentifierForIndexPathInLeftMenu:initialIndexPath];
    [leftMenu performSegueWithIdentifier:segueIdentifier sender:self];
#else
    [leftMenu tableView:leftMenu.tableView didSelectRowAtIndexPath:initialIndexPath];
#endif
}


@end
