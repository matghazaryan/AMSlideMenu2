//
//  Slide1VC.m
//  AMSlideMenu
//
//  Created by Artur Mkrtchyan on 1/27/14.
//  Copyright (c) 2014 Artur Mkrtchyan. All rights reserved.
//

#import "Slide1VC.h"
#import "UIViewController+AMSlideMenu.h"
#import "UIColor+CreateMethods.h"

@interface Slide1VC ()

@end

@implementation Slide1VC

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.

}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    // Setting navigation's bar tint color
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithHex:@"#365491" alpha:1];

    // Making view with same color that navigation bar
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 20)];
    view.backgroundColor = [UIColor colorWithHex:@"#365491" alpha:1];

    // Replace status bar view with created view and do magic :)
    [[self mainSlideMenu] fixStatusBarWithView:view];
}


@end
