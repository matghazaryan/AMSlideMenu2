//
//  AMSlideMenuLeftMenuSegue.m
//  AMSlideMenu
//
//  Created by Artur Mkrtchyan on 12/24/13.
//  Copyright (c) 2013 Artur Mkrtchyan. All rights reserved.
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
    
    NSIndexPath *initialIndexPath = [mainVC initialIndexPathForLeftMenu];
    
    NSString *segueIdentifier = [mainVC segueIdentifierForIndexPathInLeftMenu:initialIndexPath];
    
    [leftMenu.navigationController setNavigationBarHidden:YES];    
    
    [leftMenu performSegueWithIdentifier:segueIdentifier sender:self];
}


@end
