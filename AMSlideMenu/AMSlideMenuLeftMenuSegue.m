//
//  AMSlideMenuLeftMenuSegue.m
//  AMSlideMenu
//
// The MIT License (MIT)
//
// Created by : arturdev
// Copyright (c) 2014 SocialObjects Software. All rights reserved.
//
// Permission is hereby granted, free of charge, to any person obtaining a copy of
// this software and associated documentation files (the "Software"), to deal in
// the Software without restriction, including without limitation the rights to
// use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of
// the Software, and to permit persons to whom the Software is furnished to do so,
// subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in all
// copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS
// FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR
// COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER
// IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
// CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE

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
    
#ifndef AMSlideMenuWithoutStoryboards
    [self initialTransition];
#else
    [leftMenu tableView:leftMenu.tableView didSelectRowAtIndexPath:initialIndexPath];
#endif
}

- (void)initialTransition
{
    // this code is kinda messy, its basically a copy-paste from the [AMSlideMenuContentSegue perform] function
    // this relies on the initial mainvc to have its own storyboard
    
    UITableViewController *sourceVC = [self sourceViewController];
    
    AMSlideMenuMainViewController *mainVC = (AMSlideMenuMainViewController *)sourceVC;
    NSIndexPath *initialIndexPath = [mainVC initialIndexPathForLeftMenu];
    NSString *segueIdentifier = [mainVC segueIdentifierForIndexPathInLeftMenu:initialIndexPath];
    NSString *storyboard = [mainVC storyboardIdentifierForIndexPathInLeftMenu:initialIndexPath];
    
    
    UINavigationController *destinationNVC = [[UIStoryboard storyboardWithName:storyboard bundle:nil] instantiateViewControllerWithIdentifier:segueIdentifier];
    UINavigationItem *navItem = mainVC.currentActiveNVC.navigationBar.topItem;
    
    if (!navItem)
        navItem = destinationNVC.navigationBar.topItem;
    
    if (!mainVC.isInitialStart)
    {
        CGRect openedFrame = mainVC.currentActiveNVC.view.frame;
        [mainVC.currentActiveNVC.view removeFromSuperview];
        mainVC.currentActiveNVC.viewControllers = nil;
        mainVC.currentActiveNVC = nil;
        
        mainVC.currentActiveNVC = destinationNVC;
        mainVC.currentActiveNVC.view.frame = openedFrame;
        navItem = destinationNVC.navigationBar.topItem;
        
    }
    
    if (mainVC.leftMenu)
    {
        UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [mainVC configureLeftMenuButton:leftBtn];
        [leftBtn addTarget:mainVC action:@selector(openLeftMenu) forControlEvents:UIControlEventTouchUpInside];
        
        navItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftBtn];
    }
    
    if (mainVC.rightMenu)
    {
        UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [mainVC configureRightMenuButton:rightBtn];
        [rightBtn addTarget:mainVC action:@selector(openRightMenu) forControlEvents:UIControlEventTouchUpInside];
        
        navItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
    }
    
    
    //Waiting for calling viewWillApear in nvc
    double delayInSeconds = 0;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        [mainVC configureSlideLayer:destinationNVC.view.layer];
    });
    
    
    [mainVC switchCurrentActiveControllerToController:destinationNVC fromMenu:sourceVC];
}



@end
