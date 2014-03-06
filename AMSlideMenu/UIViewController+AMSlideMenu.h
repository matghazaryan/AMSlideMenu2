//
//  UIViewController+AMSlideMenu.h
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
