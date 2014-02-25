//
//  AMSlideMenuRightMenuSegue.m
//  AMSlideMenu
//
//  Created by Artur Mkrtchyan on 12/24/13.
//  Copyright (c) 2013 SocialObjects Software. All rights reserved.
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
        rightMenu.view.frame = CGRectMake(bounds.size.width - [mainVC rightMenuWidth],0,[mainVC rightMenuWidth],bounds.size.height);
    });
    [mainVC.view addSubview:rightMenu.view];
    NSIndexPath *initialIndexPath = [mainVC initialIndexPathForRightMenu];
    
    [rightMenu.navigationController setNavigationBarHidden:YES];
    
    
#ifndef AMSlideMenuWithoutStoryboards
    NSString *segueIdentifier = [mainVC segueIdentifierForIndexPathInRightMenu:initialIndexPath];
    [rightMenu performSegueWithIdentifier:segueIdentifier sender:self];
#else
    [rightMenu tableView:rightMenu.tableView didSelectRowAtIndexPath:initialIndexPath];
#endif

}

@end
