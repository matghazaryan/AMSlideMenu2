//
//  PushedVC.m
//  AMSlideMenu
//
//  Created by Artur Mkrtchyan on 12/25/13.
//  Copyright (c) 2013 SocialObjects Software. All rights reserved.
//

#import "PushedVC.h"
#import "AMSlideMenuMainViewController.h"
#import "UIViewController+AMSlideMenu.h"

@interface PushedVC ()

@end

@implementation PushedVC

/*----------------------------------------------------*/
#pragma mark - Lifecycle -
/*----------------------------------------------------*/

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    //If this vc can be poped , then
    if (self.navigationController.viewControllers.count > 1)
    {
        // Disabling pan gesture for left menu
        [self disableSlidePanGestureForLeftMenu];
    }
    
    AMSlideMenuMainViewController *mainVC = [AMSlideMenuMainViewController getInstanceForVC:self];
    if (mainVC.rightMenu)
    {
        // Adding right menu button to navigation bar
        [self addRightMenuButton];
    }
}

/*----------------------------------------------------*/
#pragma mark - IBActions -
/*----------------------------------------------------*/

- (IBAction)exitToRoot:(id)sender
{
    AMSlideMenuMainViewController *mainVC = [AMSlideMenuMainViewController getInstanceForVC:self];
    
    [mainVC.navigationController popToRootViewControllerAnimated:YES];
}

@end
