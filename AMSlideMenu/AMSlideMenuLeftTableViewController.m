//
//  AMSlideMenuLeftTableViewController.m
//  AMSlideMenu
//
//  Created by Artur Mkrtchyan on 12/24/13.
//  Copyright (c) 2013 Artur Mkrtchyan. All rights reserved.
//

#import "AMSlideMenuLeftTableViewController.h"

#import "AMSlideMenuMainViewController.h"

#import "AMSlideMenuContentSegue.h"

@interface AMSlideMenuLeftTableViewController ()

@end

@implementation AMSlideMenuLeftTableViewController

/*----------------------------------------------------*/
#pragma mark - Lifecycle -
/*----------------------------------------------------*/

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)openContentNavigationController:(UINavigationController *)nvc
{
#ifdef AMSlideMenuWithoutStoryboards
    AMSlideMenuContentSegue *contentSegue = [[AMSlideMenuContentSegue alloc] initWithIdentifier:@"contentSegue" source:self destination:nvc];
    [contentSegue perform];
#else
    NSLog(@"This methos is only for NON storyboard use! You must define AMSlideMenuWithoutStoryboards \n (e.g. #define AMSlideMenuWithoutStoryboards)");
#endif
}


/*----------------------------------------------------*/
#pragma mark - TableView Delegate -
/*----------------------------------------------------*/

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *segueIdentifier = [self.mainVC segueIdentifierForIndexPathInLeftMenu:indexPath];
    if (segueIdentifier && segueIdentifier.length > 0)
    {
        @try {
            [self performSegueWithIdentifier:segueIdentifier sender:self];
        }
        @catch (NSException *exception) {
            NSLog(@"Segue not found: %@, will look for storyboard", segueIdentifier);
            // look for a specific storyboard
            NSString *storyBoardID = [self.mainVC storyboardIdentifierForIndexPathInLeftMenu:indexPath];
            
            if (storyBoardID.length)
            {
                // load via storyboard external object
                UIStoryboard *story = [UIStoryboard storyboardWithName:storyBoardID bundle:nil];
                if (story){
                    UINavigationController* viewController;
                    
                    @try {
                        viewController = [story instantiateViewControllerWithIdentifier:segueIdentifier];
                    }
                    @catch (NSException *exception) {
                        NSLog(@"Identifier not found: %@", exception);
                    }
                    
                    if (viewController)
                        [self switchToMenuController:viewController];
                    
                }
                
            }else{
                // load from the current storyboard, not using a segue
                UINavigationController* viewController;
                @try {
                    viewController = [self.storyboard instantiateViewControllerWithIdentifier:segueIdentifier];
                }
                @catch (NSException *exception) {
                    NSLog(@"Identifier not found: %@", exception);
                }
                
                if (viewController)
                    [self switchToMenuController:viewController];
            }
            
            
        }
    }
}

/*----------------------------------------------------*/
#pragma mark - Manual Loading of Views -
/*----------------------------------------------------*/

- (void) switchToMenuController:(UINavigationController *) newMenu{
    
    UITableViewController *sourceVC = self;
    UINavigationController *destinationNVC = newMenu;
    
    AMSlideMenuMainViewController *mainVC = (AMSlideMenuMainViewController *)sourceVC.parentViewController;
    
    UINavigationItem *navItem = mainVC.currentActiveNVC.navigationBar.topItem;
    
    if (!navItem)
        navItem = destinationNVC.navigationBar.topItem;
    
    if (!mainVC.isInitialStart)
    {
        CGRect openedFrame = mainVC.currentActiveNVC.view.frame;
        [mainVC.currentActiveNVC.view removeFromSuperview];
        mainVC.currentActiveNVC.viewControllers = nil;
        mainVC.currentActiveNVC = nil;
        
        mainVC.currentActiveNVC = destinationNVC;
        mainVC.currentActiveNVC.view.frame = openedFrame;
        navItem = destinationNVC.navigationBar.topItem;
        
    }
    
    if (mainVC.leftMenu)
    {
        UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [mainVC configureLeftMenuButton:leftBtn];
        [leftBtn addTarget:mainVC action:@selector(openLeftMenu) forControlEvents:UIControlEventTouchUpInside];
        
        navItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftBtn];
    }
    
    if (mainVC.rightMenu)
    {
        UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [mainVC configureRightMenuButton:rightBtn];
        [rightBtn addTarget:mainVC action:@selector(openRightMenu) forControlEvents:UIControlEventTouchUpInside];
        
        navItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
    }
    
    
    //Waiting for calling viewWillApear in nvc
    double delayInSeconds = 0;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        [mainVC configureSlideLayer:destinationNVC.view.layer];
    });
    
    
    [mainVC switchCurrentActiveControllerToController:destinationNVC fromMenu:sourceVC];
    
    
}


@end
