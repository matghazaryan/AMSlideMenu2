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

@property (weak, nonatomic) id<AMSlideMenuDataSource> slideMenuDataSource;
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
 */
- (void)configureLeftMenuButton:(UIButton *)button;

/**
 * Override this method for customize right menu button.
 */
- (void)configureRightMenuButton:(UIButton *)button;

/**
 * Override this method for setting visible width for left menu.
 * Default value is 250
 */
- (CGFloat)leftMenuWidth;

/**
 * Override this method for setting visible width for right menu.
  * Default value is 250
 */
- (CGFloat)rightMenuWidth;

/**
 * Override this method to select whether of menues is the primary and which's root vc will be presented in first time.
 * Default value is AMPrimaryMenuLeft
 */
- (AMPrimaryMenu)primaryMenu;

/**
 * Override this method to set which of indexPaths will be selected automatically on first time for left menu
 * Default value is (0,0)
 */
- (NSIndexPath *)initialIndexPathForLeftMenu;

/**
 * Override this method to set which of indexPaths will be selected automatically on first time for right menu
 * Default value is (0,0)
 */
- (NSIndexPath *)initialIndexPathForRightMenu;

/**
 * Override this method to set which of indexPaths will be selected automatically on first time for right menu
 */
- (NSString *)segueIdentifierForIndexPathInLeftMenu:(NSIndexPath *)indexPath;

/**
 * Override this method to set which of indexPaths will be selected automatically on first time for right menu
 */
- (NSString *)segueIdentifierForIndexPathInRightMenu:(NSIndexPath *)indexPath;

/**
 * Override this method to configure slide layer. (e.g. for shadow)
 */
-(void) configureSlideLayer:(CALayer *)layer;

/**
 * Override this method if you want that pan work only on edges of view
 * Default value is 100%
 * @returns percentage of pan's working area in view.
 */
-(CGFloat) panGestureWarkingAreaPercent;

#pragma mark - Methods

#pragma mark -- Actions
- (void)openLeftMenu;
- (void)openLeftMenuAnimated:(BOOL)animated;
- (void)openRightMenu;
- (void)openRightMenuAnimated:(BOOL)animated;
- (void)closeLeftMenu;
- (void)closeLeftMenuAnimated:(BOOL)animated;
- (void)closeRightMenu;
- (void)closeRightMenuAnimated:(BOOL)animated;
- (void)switchCurrentActiveControllerToController:(UINavigationController *)nvc fromMenu:(UITableViewController *)menu;

@end
