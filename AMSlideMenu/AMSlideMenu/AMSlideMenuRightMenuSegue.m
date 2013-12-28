//
//  AMSlideMenuRightMenuSegue.m
//  AMSlideMenu
//
//  Created by Artur Mkrtchyan on 12/24/13.
//  Copyright (c) 2013 Artur Mkrtchyan. All rights reserved.
//

#import "AMSlideMenuRightMenuSegue.h"

#import "AMSlideMenuMainViewController.h"
#import "AMSlideMenuRightTableViewController.h"

@implementation AMSlideMenuRightMenuSegue

- (void)perform
{
    AMSlideMenuMainViewController* mainVC = self.sourceViewController;
    AMSlideMenuRightTableViewController* rightMenu = self.destinationViewController;
    
    mainVC.rightMenu = rightMenu;
    rightMenu.mainVC = mainVC;
    
    [mainVC addChildViewController:rightMenu];
    
    double delayInSeconds = 0.0;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        CGRect bounds = mainVC.view.bounds;
        rightMenu.view.frame = CGRectMake(0,0,bounds.size.width,bounds.size.height);
    });
    [mainVC.view addSubview:rightMenu.view];
    NSIndexPath *initialIndexPath = [mainVC initialIndexPathForRightMenu];
    NSString *segueIdentifier = [mainVC segueIdentifierForIndexPathInRightMenu:initialIndexPath];
    
    [rightMenu.navigationController setNavigationBarHidden:YES];
    
    [rightMenu performSegueWithIdentifier:segueIdentifier sender:self];
}

@end
