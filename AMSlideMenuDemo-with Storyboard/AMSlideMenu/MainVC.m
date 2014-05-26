//
//  MainVC.m
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

#import "MainVC.h"
#import "UIColor+CreateMethods.h"

@interface MainVC ()

@end

@implementation MainVC

- (void)viewDidLoad
{
    [super viewDidLoad];
}

/*----------------------------------------------------*/
#pragma mark - Overriden Methods -
/*----------------------------------------------------*/

- (NSString *)segueIdentifierForIndexPathInLeftMenu:(NSIndexPath *)indexPath
{
    NSString *identifier = @"";
    switch (indexPath.row) {
        case 0:
            identifier = @"firstRow";
            break;
        case 1:
            identifier = @"secondRow";
            break;
    }
    
    return identifier;
}

/**
 * NOTE! If you override this method, then segueIdentifierForIndexPathInLeftMenu will be ignored
 * Return instantiated navigation controller that will opened
 * when cell at indexPath will be selected from left menu
 * @param indexPath of left menu table
 * @return UINavigationController instance for input indexPath
 */
/*
- (UINavigationController *)navigationControllerForIndexPathInLeftMenu:(NSIndexPath *)indexPath
{
    NSString *storyboardId = @"";
    
    switch (indexPath.row) {
        case 0:
            storyboardId = @"FirstNC";
            break;
        case 1:
            storyboardId = @"SecondNC";
            break;
    }
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    UINavigationController *nc = [storyboard instantiateViewControllerWithIdentifier:storyboardId];
    return nc;
}
*/

- (NSString *)segueIdentifierForIndexPathInRightMenu:(NSIndexPath *)indexPath
{
    NSString *identifier = @"";
    switch (indexPath.row) {
        case 0:
            identifier = @"firstRow";
            break;
        case 1:
            identifier = @"secondRow";
            break;
    }
    
    return identifier;
}


- (CGFloat)leftMenuWidth
{
    return 250;
}

- (CGFloat)rightMenuWidth
{
    return 180;
}

- (void)configureLeftMenuButton:(UIButton *)button
{
    CGRect frame = button.frame;
    frame = CGRectMake(0, 0, 25, 13);
    button.frame = frame;
    button.backgroundColor = [UIColor clearColor];
    [button setImage:[UIImage imageNamed:@"simpleMenuButton"] forState:UIControlStateNormal];
}

- (void)configureRightMenuButton:(UIButton *)button
{
    CGRect frame = button.frame;
    frame = CGRectMake(0, 0, 25, 13);
    button.frame = frame;
    button.backgroundColor = [UIColor clearColor];
    [button setImage:[UIImage imageNamed:@"simpleMenuButton"] forState:UIControlStateNormal];
}

- (void) configureSlideLayer:(CALayer *)layer
{
    layer.shadowColor = [UIColor blackColor].CGColor;
    layer.shadowOpacity = 1;
    layer.shadowOffset = CGSizeMake(0, 0);
    layer.shadowRadius = 5;
    layer.masksToBounds = NO;
    layer.shadowPath =[UIBezierPath bezierPathWithRect:self.view.layer.bounds].CGPath;
}

- (AMPrimaryMenu)primaryMenu
{
    return AMPrimaryMenuLeft;
}


// Enabling Deepnes on left menu
- (BOOL)deepnessForLeftMenu
{
    return YES;
}

// Enabling Deepnes on left menu
- (BOOL)deepnessForRightMenu
{
    return YES;
}

// Enabling darkness while left menu is opening
- (CGFloat)maxDarknessWhileLeftMenu
{
    return 0.5;
}

// Enabling darkness while right menu is opening
- (CGFloat)maxDarknessWhileRightMenu
{
    return 0.5;
}

@end
