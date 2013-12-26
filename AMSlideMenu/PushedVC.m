//
//  PushedVC.m
//  AMSlideMenu
//
//  Created by Artur Mkrtchyan on 12/25/13.
//  Copyright (c) 2013 Artur Mkrtchyan. All rights reserved.
//

#import "PushedVC.h"
#import "AMSlideMenuMainViewController.h"
#import "UIViewController+AMSlideMenu.h"

@interface PushedVC ()

@end

@implementation PushedVC

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    
    // Disabling pan gesture for left menu
    [self disableSlidePanGestureForLeftMenu];
    
    AMSlideMenuMainViewController *mainVC = [AMSlideMenuMainViewController getInstanceForVC:self];
    if (mainVC.rightMenu)
    {
        // Adding right menu button to navigation bar
        [self addRightMenuButton];
    }
}

- (IBAction)exitToRoot:(id)sender
{
    AMSlideMenuMainViewController *mainVC = [AMSlideMenuMainViewController getInstanceForVC:self];
    
    [mainVC.navigationController popToRootViewControllerAnimated:YES];
}

@end
