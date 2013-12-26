//
//  AMSlideMenuMainViewController.h
//  AMSlideMenu
//
//  Created by Artur Mkrtchyan on 12/24/13.
//  Copyright (c) 2013 Artur Mkrtchyan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AMSlideMenuProtocols.h"
#import "AMSlideMenuLeftTableViewController.h"
#import "AMSlideMenuRightTableViewController.h"

typedef enum {
    AMPrimaryMenuLeft,
    AMPrimaryMenuRight
} AMPrimaryMenu;

typedef enum {
    AMSlideMenuClosed,
    AMSlideMenuLeftOpened,
    AMSlideMenuRightOpened,
} AMSlideMenuState;

@interface AMSlideMenuMainViewController : UIViewController

#pragma mark - Properties

@property (weak, nonatomic) id<AMSlideMenuDelegate> slideMenuDelegate;

@property (strong, nonatomic) AMSlideMenuLeftTableViewController *leftMenu;
@property (strong, nonatomic) AMSlideMenuRightTableViewController *rightMenu;
@property (strong, nonatomic) UINavigationController *currentActiveNVC;

@property (strong, nonatomic) UITapGestureRecognizer *tapGesture;
@property (strong, nonatomic) UIPanGestureRecognizer *panGesture;

@property (nonatomic) BOOL leftPanDisabled;
@property (nonatomic) BOOL rightPanDisabled;

@property (nonatomic) BOOL isInitialStart;

@property (nonatomic) AMSlideMenuState menuState;

+ (AMSlideMenuMainViewController *)getInstanceForVC:(UIViewController *)vc;
+ (NSArray *)allInstances;

#pragma mark - Overridable Public Methods

/**
 * Override this method for customize left menu button.
 * @param Left button instance to encapsulate
 */
- (void)configureLeftMenuButton:(UIButton *)button;

/**
 * Override this method for customize right menu button.
 * @param Left button instance to encapsulate
 */
- (void)configureRightMenuButton:(UIButton *)button;

/**
 * Override this method for setting visible width for left menu.
 * @return The left menu width (Default will return 250)
 */
- (CGFloat)leftMenuWidth;

/**
 * Override this method for setting visible width for right menu.
 * @return The right menu width (Default will return 250)
 */
- (CGFloat)rightMenuWidth;

/**
 * Override this method to select whether of 
 * menues is the primary and which's root vc will be presented in first time.
 * @return Type of primary menu (Default will return AMPrimaryMenuLeft)
 */
- (AMPrimaryMenu)primaryMenu;

/**
 * Override this method to set which of indexPaths 
 * will be selected automatically on first time for left menu
 * @return Default will return (0, 0)
 */
- (NSIndexPath *)initialIndexPathForLeftMenu;

/**
 * Override this method to set which of 
 * indexPaths will be selected automatically on first time for right menu
 * @return Default will return (0, 0)
 */
- (NSIndexPath *)initialIndexPathForRightMenu;

/**
 * Override this method to set which of 
 * indexPaths will be selected automatically on first time for right menu
 * @param indexPath of left menu table
 * @return Segue identifier for input indexPath
 */
- (NSString *)segueIdentifierForIndexPathInLeftMenu:(NSIndexPath *)indexPath;

/**
 * Override this method to set which 
 * of indexPaths will be selected automatically on first time for right menu
 * @param indexPath of right menu table
 * @return Segue identifier for input indexPath
 */
- (NSString *)segueIdentifierForIndexPathInRightMenu:(NSIndexPath *)indexPath;

/**
 * Override this method to configure slide layer. (e.g. for shadow)
 * @param layer of slider
 */
- (void)configureSlideLayer:(CALayer *)layer;

/**
 * Override this method if you want that pan work only on edges of view
 * Default value is 100%
 * @return percentage of pan's working area in view.
 */
- (CGFloat)panGestureWarkingAreaPercent;

#pragma mark - Methods

#pragma mark -- Actions

/**
 * Opens Left menu by animation
 */
- (void)openLeftMenu;

/**
 * Opens Left menu
 * @param animated indicates if menu should be openen
 * by animation
 */
- (void)openLeftMenuAnimated:(BOOL)animated;

/**
 * Opens Right menu by animation
 */
- (void)openRightMenu;

/**
 * Opens Right menu
 * @param animated indicates if menu should be openen
 * by animation
 */
- (void)openRightMenuAnimated:(BOOL)animated;

/**
 * Closes Left menu by animation
 */
- (void)closeLeftMenu;

/**
 * Closes Left menu
 * @param animated indicates if menu should be closed
 * by animation
 */
- (void)closeLeftMenuAnimated:(BOOL)animated;

/**
 * Closes Right menu by animation
 */
- (void)closeRightMenu;

/**
 * Closes Right menu
 * @param animated indicates if menu should be closed
 * by animation
 */
- (void)closeRightMenuAnimated:(BOOL)animated;

/**
 * makes switch between active controller to input controller
 * @param Destination controller
 * @param Menu from where switch should be done
 */
- (void)switchCurrentActiveControllerToController:(UINavigationController *)nvc
                                         fromMenu:(UITableViewController *)menu;

@end
