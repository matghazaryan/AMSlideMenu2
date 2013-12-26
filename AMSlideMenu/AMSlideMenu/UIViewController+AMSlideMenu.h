//
//  UIViewController+AMSlideMenu.h
//  AMSlideMenu
//
//  Created by Artur Mkrtchyan on 12/24/13.
//  Copyright (c) 2013 Artur Mkrtchyan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (AMSlideMenu)

- (void)addLeftMenuButton;
- (void)addRightMenuButton;

/**
 * User this methods in  viewWillAppear:
 */
- (void)disableSlidePanGestureForLeftMenu;
- (void)disableSlidePanGestureForRightMenu;
- (void)enableSlidePanGestureForLeftMenu;
- (void)enableSlidePanGestureForRightMenu;

@end
