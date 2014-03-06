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
    
    NSIndexPath *initialIndexPath = [mainVC initialIndexPathForLeftMenu];
    
#ifndef AMSlideMenuWithoutStoryboards
    NSString *segueIdentifier = [mainVC segueIdentifierForIndexPathInLeftMenu:initialIndexPath];
    [leftMenu performSegueWithIdentifier:segueIdentifier sender:self];
#else
    [leftMenu tableView:leftMenu.tableView didSelectRowAtIndexPath:initialIndexPath];
#endif
}


@end
