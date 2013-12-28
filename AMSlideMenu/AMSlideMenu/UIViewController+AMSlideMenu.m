//
//  UIViewController+AMSlideMenu.m
//  AMSlideMenu
//
//  Created by Artur Mkrtchyan on 12/24/13.
//  Copyright (c) 2013 Artur Mkrtchyan. All rights reserved.
//

#import "UIViewController+AMSlideMenu.h"

@implementation UIViewController (AMSlideMenu)

/*----------------------------------------------------*/
#pragma mark - Public Actions -
/*----------------------------------------------------*/

- (void)addLeftMenuButton
{
    AMSlideMenuMainViewController *mainVC = [AMSlideMenuMainViewController getInstanceForVC:self];
    
    UINavigationItem *navItem = self.navigationItem;

    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [mainVC configureLeftMenuButton:leftBtn];
    [leftBtn addTarget:mainVC action:@selector(openLeftMenu) forControlEvents:UIControlEventTouchUpInside];
    
    navItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftBtn];
}

- (void)addRightMenuButton
{
    AMSlideMenuMainViewController *mainVC = [AMSlideMenuMainViewController getInstanceForVC:self];
    
    UINavigationItem *navItem = self.navigationItem;
    
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [mainVC configureRightMenuButton:rightBtn];
    [rightBtn addTarget:mainVC action:@selector(openRightMenu) forControlEvents:UIControlEventTouchUpInside];
    
    navItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
}

- (void)removeLeftMenuButton
{
    UINavigationItem *navItem = self.navigationItem;
    
    navItem.leftBarButtonItem = nil;
}

- (void)removeRightMenuButton
{
    UINavigationItem *navItem = self.navigationItem;

    navItem.rightBarButtonItem = nil;
}

- (void)enableSlidePanGestureForLeftMenu
{
    AMSlideMenuMainViewController *mainVC = [AMSlideMenuMainViewController getInstanceForVC:self];

    mainVC.rightPanDisabled = NO;
}

- (void)enableSlidePanGestureForRightMenu
{
    AMSlideMenuMainViewController *mainVC = [AMSlideMenuMainViewController getInstanceForVC:self];
    mainVC.leftPanDisabled = NO;
}

- (void)disableSlidePanGestureForLeftMenu
{
    AMSlideMenuMainViewController *mainVC = [AMSlideMenuMainViewController getInstanceForVC:self];
    mainVC.rightPanDisabled = YES;
}

- (void)disableSlidePanGestureForRightMenu
{
    AMSlideMenuMainViewController *mainVC = [AMSlideMenuMainViewController getInstanceForVC:self];
    mainVC.leftPanDisabled = YES;
}

- (AMSlideMenuMainViewController *)mainSlideMenu
{
    AMSlideMenuMainViewController *mainVC = [AMSlideMenuMainViewController getInstanceForVC:self];
    return mainVC;
}
/*----------------------------------------------------*/
#pragma mark - Lifecycle -
/*----------------------------------------------------*/

- (void)dealloc
{
    AMSlideMenuMainViewController *mainVC = [AMSlideMenuMainViewController getInstanceForVC:self];
    mainVC.leftPanDisabled = NO;
    mainVC.rightPanDisabled = NO;
}
@end
