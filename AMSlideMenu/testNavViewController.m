//
//  testNavViewController.m
//  AMSlideMenu
//
//  Created by Artur Mkrtchyan on 12/26/13.
//  Copyright (c) 2013 Artur Mkrtchyan. All rights reserved.
//

#import "testNavViewController.h"

@interface testNavViewController ()

@end

@implementation testNavViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)dealloc
{
    NSLog(@"dealoc");
}

@end
