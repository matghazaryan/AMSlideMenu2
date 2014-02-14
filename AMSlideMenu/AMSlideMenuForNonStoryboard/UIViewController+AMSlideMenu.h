//
//  UIViewController+AMSlideMenu.h
//  AMSlideMenu
//
//  Created by Artur Mkrtchyan on 12/24/13.
//  Copyright (c) 2013 Artur Mkrtchyan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AMSlideMenuMainViewController.h"

@interface UIViewController (AMSlideMenu)

/** 
 * Adds left menu top button
 */
- (void)addLeftMenuButton;

/**
 * Adds right menu top button
 */
- (void)addRightMenuButton;

/**
 * Removes left menu top button
 */
- (void)removeLeftMenuButton;

/**
 * Removes right menu top button
 */
- (void)removeRightMenuButton;


//
// ABOVE METHODS MUST BE USED in viewWillAppear:
//

/**
 * Disables Left menu open functional
 * by Pan gesture recognizer
 */
- (void)disableSlidePanGestureForLeftMenu;

/**
 * Disables Right menu open functional
 * by Pan gesture recognizer
 */
- (void)disableSlidePanGestureForRightMenu;

/**
 * Enables Left menu open functional
 * by Pan gesture recognizer
 */
- (void)enableSlidePanGestureForLeftMenu;

/**
 * Disables Right menu open functional
 * by Pan gesture recognizer
 */
- (void)enableSlidePanGestureForRightMenu;


/**
 * Getting current vc's  Main Slideing View Controller
 */
- (AMSlideMenuMainViewController *)mainSlideMenu;

@end
