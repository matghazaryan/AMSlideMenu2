//
//  AMSlideMenuMainViewController.m
//  AMSlideMenu
//
//  Created by Artur Mkrtchyan on 12/24/13.
//  Copyright (c) 2013 Artur Mkrtchyan. All rights reserved.
//

#import "AMSlideMenuMainViewController.h"

#import "UIViewController+AMSlideMenu.h"

#define kPanMinTranslationX 15.0f
#define kMenuOpenAminationDuration 0.2f
#define kMenuCloseAminationDuration 0.2f

typedef enum {
  AMSlidePanningStateStopped,
  AMSlidePanningStateLeft,
  AMSlidePanningStateRight
} AMSlidePanningState;

@interface AMSlideMenuMainViewController ()
{
    AMSlidePanningState panningState;
    CGFloat panningPreviousPosition;
    NSDate* panningPreviousEventDate;
    CGFloat panningXSpeed;  // panning speed expressed in px/ms
    bool panStarted;
}
// Add transparent overlay view to currentActiveNVC's  view to disable all touches, when menu is opened
@property (strong, nonatomic) UIView *overlayView;

@property (strong, nonatomic) UINavigationController *initialViewController;

@end

static NSMutableArray *allInstances;

@implementation AMSlideMenuMainViewController

/*----------------------------------------------------*/
#pragma mark - Lifecycle -
/*----------------------------------------------------*/

- (void)viewDidLoad
{
    [super viewDidLoad];
    if (!allInstances)
    {
        allInstances = [NSMutableArray array];
    }
    [allInstances addObject:self];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleInterfaceOrientationChangedNotification:) name:UIDeviceOrientationDidChangeNotification object:nil];

    [self setup];
}

- (void)handleInterfaceOrientationChangedNotification:(NSNotification *)not
{
    if ([self.currentActiveNVC shouldAutorotate])
    {
        CGRect bounds = self.view.bounds;
        self.rightMenu.view.frame = CGRectMake(bounds.size.width - [self rightMenuWidth],0,bounds.size.width,bounds.size.height);
        if (self.overlayView && self.overlayView.superview)
        {
            self.overlayView.frame = CGRectMake(0, 0, self.currentActiveNVC.view.frame.size.width, self.currentActiveNVC.view.frame.size.height);
        }
        
        
        double delayInSeconds = 0.25f;
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            [self configureSlideLayer:self.currentActiveNVC.view.layer];
        });
        
        
        //fix orientation for iPhone
        if (UI_USER_INTERFACE_IDIOM() != UIUserInterfaceIdiomPad)
        {
            UIInterfaceOrientation toInterfaceOrientation = [[UIApplication sharedApplication] statusBarOrientation];
            CGRect frame = self.currentActiveNVC.navigationBar.frame;
            if (toInterfaceOrientation == UIInterfaceOrientationPortrait || toInterfaceOrientation == UIInterfaceOrientationPortraitUpsideDown) {
                frame.size.height = 44;
            } else {
                frame.size.height = 32;
            }
            self.currentActiveNVC.navigationBar.frame = frame;
        }
    }
}

- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    if ([self.currentActiveNVC shouldAutorotate])
    {
        self.currentActiveNVC.view.layer.shadowOpacity = 0;
    }
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

/*----------------------------------------------------*/
#pragma mark - Static methods -
/*----------------------------------------------------*/

+ (NSArray *)allInstances
{
    return allInstances;
}

+ (AMSlideMenuMainViewController *)getInstanceForVC:(UIViewController *)vc
{
    for (AMSlideMenuMainViewController *mainVC in allInstances)
    {
        if (mainVC.currentActiveNVC == vc.navigationController)
        {
            return mainVC;
        }
    }
    return nil;
}

/*----------------------------------------------------*/
#pragma mark - Datasource -
/*----------------------------------------------------*/

- (CGFloat)leftMenuWidth
{
    return 250;
}

- (CGFloat)rightMenuWidth
{
    return 250;
}

- (void)configureLeftMenuButton:(UIButton *)button
{
    
}

- (void)configureRightMenuButton:(UIButton *)button
{
    
}

- (AMPrimaryMenu)primaryMenu
{
    return AMPrimaryMenuLeft;
}

- (NSIndexPath *)initialIndexPathForLeftMenu
{
    return [NSIndexPath indexPathForRow:0 inSection:0];
}

- (NSIndexPath *)initialIndexPathForRightMenu
{
    return [NSIndexPath indexPathForRow:0 inSection:0];    
}

- (NSString *)segueIdentifierForIndexPathInLeftMenu:(NSIndexPath *)indexPath
{
    return @"";
}

- (NSString *)segueIdentifierForIndexPathInRightMenu:(NSIndexPath *)indexPath
{
    return @"";
}

- (void) configureSlideLayer:(CALayer *)layer
{
    layer.shadowColor = [UIColor grayColor].CGColor;
    layer.shadowOpacity = 1;
    layer.shadowOffset = CGSizeMake(0, 0);
    layer.masksToBounds = NO;
    layer.shadowPath =[UIBezierPath bezierPathWithRect:layer.bounds].CGPath;
}

- (CGFloat)panGestureWarkingAreaPercent
{
    return 100.0f;
}

/*----------------------------------------------------*/
#pragma mark - Private methods -
/*----------------------------------------------------*/

- (void)setup
{
    self.isInitialStart = YES;
    
    self.tapGesture = [[UITapGestureRecognizer alloc] init];
    self.panGesture = [[UIPanGestureRecognizer alloc] init];
    
    [self.tapGesture addTarget:self action:@selector(handleTapGesture:)];
    [self.panGesture addTarget:self action:@selector(handlePanGesture:)];
    
    self.tapGesture.cancelsTouchesInView = YES;
    
    if ([self primaryMenu] == AMPrimaryMenuLeft)
    {
        @try
        {
            [self performSegueWithIdentifier:@"leftMenu" sender:self];

            @try {
                [self performSegueWithIdentifier:@"rightMenu" sender:self];
            }
            @catch (NSException *exception) {
                
            }
        }
        @catch (NSException *exception)
        {
            [self performSegueWithIdentifier:@"rightMenu" sender:self];
            NSLog(@"WARNING: You setted primaryMenu to left , but you have no segue with identifier 'leftMenu'");
        }
    }
    else if ([self primaryMenu] == AMPrimaryMenuRight)
    {
        @try
        {
            [self performSegueWithIdentifier:@"rightMenu" sender:self];
            
            @try {
                [self performSegueWithIdentifier:@"leftMenu" sender:self];
            }
            @catch (NSException *exception) {
        
            }
        }
        @catch (NSException *exception)
        {
            [self performSegueWithIdentifier:@"leftMenu" sender:self];
            NSLog(@"WARNING: You setted primaryMenu to right , but you have no segue with identifier 'rightMenu'");
        }
    }
    
    [self.currentActiveNVC.view addGestureRecognizer:self.panGesture];
    
    self.isInitialStart = NO;
}

/*----------------------------------------------------*/
#pragma mark - Public Actions -
/*----------------------------------------------------*/

- (void)openLeftMenu
{
    [self openLeftMenuAnimated:YES];
}

- (void)openLeftMenuAnimated:(BOOL)animated
{
    if (self.slideMenuDelegate && [self.slideMenuDelegate respondsToSelector:@selector(leftMenuWillOpen)])
        [self.slideMenuDelegate leftMenuWillOpen];
    
    self.rightMenu.view.hidden = YES;
    self.leftMenu.view.hidden = NO;
    
    CGRect frame = self.currentActiveNVC.view.frame;
    frame.origin.x = [self leftMenuWidth];
    
    [UIView animateWithDuration: animated ? kMenuOpenAminationDuration : 0 animations:^{
        self.currentActiveNVC.view.frame = frame;
    } completion:^(BOOL finished) {
        [self addGestures];
        [self enableGestures];
        self.menuState = AMSlideMenuLeftOpened;
        
        if (self.slideMenuDelegate && [self.slideMenuDelegate respondsToSelector:@selector(leftMenuDidOpen)])
            [self.slideMenuDelegate leftMenuDidOpen];
    }];
}

- (void)openRightMenu
{
    [self openRightMenuAnimated:YES];
}

- (void)openRightMenuAnimated:(BOOL)animated
{
    if (self.slideMenuDelegate && [self.slideMenuDelegate respondsToSelector:@selector(rightMenuWillOpen)])
        [self.slideMenuDelegate rightMenuWillOpen];
    
    self.rightMenu.view.hidden = NO;
    self.leftMenu.view.hidden = YES;
    
    CGRect frame = self.currentActiveNVC.view.frame;
    frame.origin.x = -1 *[self rightMenuWidth];
    
    [UIView animateWithDuration:animated ? kMenuOpenAminationDuration : 0 animations:^{
        self.currentActiveNVC.view.frame = frame;
    } completion:^(BOOL finished) {
        [self addGestures];
        [self enableGestures];
        self.menuState = AMSlideMenuRightOpened;
        
        if (self.slideMenuDelegate && [self.slideMenuDelegate respondsToSelector:@selector(rightMenuDidOpen)])
            [self.slideMenuDelegate rightMenuDidOpen];
    }];
}

- (void)closeLeftMenu
{
    [self closeLeftMenuAnimated:YES];
}

- (void)closeLeftMenuAnimated:(BOOL)animated
{
    if (self.slideMenuDelegate && [self.slideMenuDelegate respondsToSelector:@selector(leftMenuWillClose)])
        [self.slideMenuDelegate leftMenuWillClose];
    
    CGRect frame = self.currentActiveNVC.view.frame;
    frame.origin.x = 0;
    
    [UIView animateWithDuration:animated ? kMenuCloseAminationDuration : 0 animations:^{
        self.currentActiveNVC.view.frame = frame;
    } completion:^(BOOL finished) {
        [self.overlayView removeFromSuperview];
        [self desableGestures];
        self.menuState = AMSlideMenuClosed;
        [self.currentActiveNVC.view addGestureRecognizer:self.panGesture];
        
        if (self.slideMenuDelegate && [self.slideMenuDelegate respondsToSelector:@selector(leftMenuDidClose)])
            [self.slideMenuDelegate leftMenuDidClose];
    }];
}

- (void)closeRightMenu
{
    [self closeRightMenuAnimated:YES];
}

- (void)closeRightMenuAnimated:(BOOL)animated
{
    if (self.slideMenuDelegate && [self.slideMenuDelegate respondsToSelector:@selector(rightMenuWillClose)])
        [self.slideMenuDelegate rightMenuWillClose];
    
    CGRect frame = self.currentActiveNVC.view.frame;
    frame.origin.x = 0;
    
    [UIView animateWithDuration:animated ? kMenuCloseAminationDuration : 0 animations:^{
        self.currentActiveNVC.view.frame = frame;
    } completion:^(BOOL finished) {
        [self.overlayView removeFromSuperview];        
        [self desableGestures];
        self.menuState = AMSlideMenuClosed;
        [self.currentActiveNVC.view addGestureRecognizer:self.panGesture];
        
        if (self.slideMenuDelegate && [self.slideMenuDelegate respondsToSelector:@selector(rightMenuDidClose)])
            [self.slideMenuDelegate rightMenuDidClose];
    }];
}

- (void)closeMenu
{
    if (self.menuState == AMSlideMenuLeftOpened)
    {
        [self closeLeftMenu];
    }
    else if (self.menuState == AMSlideMenuRightOpened)
    {
        [self closeRightMenu];
    }
}

- (void)switchCurrentActiveControllerToController:(UINavigationController *)nvc fromMenu:(UITableViewController *)menu
{
    if (self.isInitialStart)
    {
        if ([self primaryMenu] == AMPrimaryMenuLeft)
        {
            if ([menu isKindOfClass:[AMSlideMenuLeftTableViewController class]])
            {
                self.initialViewController = nvc;
            }
            if ([menu isKindOfClass:[AMSlideMenuRightTableViewController class]] && self.leftMenu)
            {
                if (self.currentActiveNVC)
                {
                    [self.currentActiveNVC.view removeFromSuperview];
                }
                    self.currentActiveNVC = self.initialViewController;
                
                [self.view addSubview:self.currentActiveNVC.view];
                
                return;
            }
        }
        else if ([self primaryMenu] == AMPrimaryMenuRight)
        {
            if ([menu isKindOfClass:[AMSlideMenuLeftTableViewController class]] && self.rightMenu)
            {
                if (self.currentActiveNVC)
                {
                    [self.currentActiveNVC.view removeFromSuperview];
                }
                self.currentActiveNVC = self.initialViewController;
                
                [self.view addSubview:self.currentActiveNVC.view];
                
                return;
            }
            if ([menu isKindOfClass:[AMSlideMenuRightTableViewController class]])
            {
                self.initialViewController = nvc;
            }
        }
    }
    

    if (self.currentActiveNVC)
    {
        [self.currentActiveNVC.view removeFromSuperview];
    }
    self.currentActiveNVC = nvc;
    
    [self.view addSubview:nvc.view];
    
    // Configuring for iOS 6.x
    if ([[[UIDevice currentDevice] systemVersion] floatValue] < 7.0 && ![UIApplication sharedApplication].statusBarHidden)
    {
        CGRect frame = self.currentActiveNVC.view.frame;
        frame.origin.y = -20;
        self.currentActiveNVC.view.frame = frame;
    }
    
    [self closeLeftMenu];
    [self.currentActiveNVC.view addGestureRecognizer:self.panGesture];
    
    if ([menu isKindOfClass:[AMSlideMenuLeftTableViewController class]])
    {
        [self.rightMenu.tableView deselectRowAtIndexPath:[self.rightMenu.tableView indexPathForSelectedRow] animated:NO];
    }
    else if ([menu isKindOfClass:[AMSlideMenuRightTableViewController class]])
    {
        [self.leftMenu.tableView deselectRowAtIndexPath:[self.leftMenu.tableView indexPathForSelectedRow] animated:NO];
    }
}

- (void)openContentViewControllerForMenu:(AMSlideMenu)menu atIndexPath:(NSIndexPath *)indexPath
{
    if (menu == AMSlideMenuLeft)
    {
        if (!self.leftMenu)
            return;
        
        NSString *identifier = [self segueIdentifierForIndexPathInLeftMenu:indexPath];
        [self.leftMenu.tableView selectRowAtIndexPath:indexPath animated:YES scrollPosition:UITableViewScrollPositionNone];
        [self.leftMenu performSegueWithIdentifier:identifier sender:self.leftMenu];
    }
    else if (menu == AMSlideMenuRight)
    {
        if (!self.rightMenu)
            return;
        
        NSString *identifier = [self segueIdentifierForIndexPathInRightMenu:indexPath];
        
        [self.rightMenu.tableView selectRowAtIndexPath:indexPath animated:YES scrollPosition:UITableViewScrollPositionNone];
        [self.rightMenu performSegueWithIdentifier:identifier sender:self.rightMenu];
    }
}

- (void)addGestures
{
    if (self.overlayView)
    {
        [self.overlayView removeFromSuperview];
    }
    else
    {
        self.overlayView = [[UIView alloc] initWithFrame:self.currentActiveNVC.view.bounds];
    }
    
    CGRect frame = self.overlayView.frame;
    frame.size = self.currentActiveNVC.view.bounds.size;
    self.overlayView.frame = frame;
    
    self.overlayView.backgroundColor = [UIColor clearColor];
    [self.currentActiveNVC.view addSubview:self.overlayView];
    
    [self.overlayView addGestureRecognizer:self.tapGesture];
    [self.overlayView addGestureRecognizer:self.panGesture];
}

- (void)enableGestures
{
    self.tapGesture.enabled = YES;
//    self.panGesture.enabled = YES;
}

- (void)desableGestures
{
    self.tapGesture.enabled = NO;
//    self.panGesture.enabled = NO;
}

/*----------------------------------------------------*/
#pragma mark - Gesture Recognizers -
/*----------------------------------------------------*/

- (void)handleTapGesture:(UITapGestureRecognizer *)tap
{
    [self closeMenu];
}

- (void)handlePanGesture:(UIPanGestureRecognizer *)gesture
{
    static CGPoint panStartPosition = (CGPoint){0,0};
    
    UIView* panningView = gesture.view;
    if (self.menuState != AMSlideMenuClosed)
    {
        panningView = panningView.superview;
    }
    
    CGPoint translation = [gesture translationInView:panningView];
    
    if ([gesture state] == UIGestureRecognizerStateBegan)
    {
        panStartPosition = [gesture locationInView:panningView];
        panStarted = YES;
    }
    else if ([gesture state] == UIGestureRecognizerStateEnded || [gesture state] == UIGestureRecognizerStateCancelled)
    {
        if (self.menuState != AMSlideMenuClosed)
        {
            if (self.menuState == AMSlidePanningStateLeft)
            {
                if (panningView.frame.origin.x < ([self leftMenuWidth] / 2.0f))
                {
                    [self closeLeftMenu];
                }
                else
                {
                    [self openLeftMenu];
                }
            }
            else if (self.menuState == AMSlidePanningStateRight)
            {
                if (self.view.frame.size.width - (panningView.frame.origin.x + panningView.frame.size.width) < ([self rightMenuWidth] / 2.0f))
                {
                    [self closeRightMenu];
                }
                else
                {
                    [self openRightMenu];
                }
            }
        }
        else
        {
            if (panningState == AMSlidePanningStateRight)
            {
                if (panningView.frame.origin.x < ([self leftMenuWidth] / 2.0f))
                {
                    [self closeLeftMenu];
                }
                else
                {
                    [self openLeftMenu];
                }

            }
            if (panningState == AMSlidePanningStateLeft)
            {
                if (self.view.frame.size.width - (panningView.frame.origin.x + panningView.frame.size.width) < ([self rightMenuWidth] / 2.0f))
                {
                    [self closeRightMenu];
                }
                else
                {
                    [self openRightMenu];
                }
            }
        }
        
        panningState = AMSlidePanningStateStopped;
    }
    else
    {
        if (!CGPointEqualToPoint(panStartPosition, (CGPoint){0,0}))
        {
            CGFloat actualWidth = panningView.frame.size.width * ([self panGestureWarkingAreaPercent] / 100.0f);
            if (panStartPosition.x > actualWidth && panStartPosition.x < panningView.frame.size.width - actualWidth && self.menuState == AMSlideMenuClosed)
            {
                return;
            }
        }
        
        //--- Calculate pan position
        if(panStarted)
        {
            panStarted = NO;
            
            if (panningView.frame.origin.x + translation.x < 0)
            {
                panningState = AMSlidePanningStateLeft;
                
                if (self.menuState == AMSlideMenuClosed)
                {
                    self.leftMenu.view.hidden = YES;
                    self.rightMenu.view.hidden = NO;
                }
            }
            else if(panningView.frame.origin.x + translation.x > 0)
            {
                panningState = AMSlidePanningStateRight;
                
                if (self.menuState == AMSlideMenuClosed)
                {
                    self.leftMenu.view.hidden = NO;
                    self.rightMenu.view.hidden = YES;
                }
            }
        }
        //----
        
        //----
        if (panningState == AMSlidePanningStateLeft && self.leftPanDisabled)
        {
            panningState = AMSlidePanningStateStopped;
            return;
        }
        else if (panningState == AMSlidePanningStateRight && self.rightPanDisabled)
        {
            panningState = AMSlidePanningStateStopped;
            return;
        }
        //----
        
        if (self.menuState == AMSlidePanningStateLeft)
        {
            if (abs(translation.x) > kPanMinTranslationX && translation.x < 0)
            {
                [self closeLeftMenu];
            }
            else if ((panningView.frame.origin.x + translation.x) < [self leftMenuWidth] && (panningView.frame.origin.x + translation.x) >= 0)
            {
                [panningView setCenter:CGPointMake([panningView center].x + translation.x, [panningView center].y)];
            }
        }
        else if (self.menuState == AMSlidePanningStateRight)
        {
            if (abs(translation.x) > kPanMinTranslationX && translation.x > 0)
            {
                [self closeRightMenu];
            }
            else if (self.view.frame.size.width - (panningView.frame.origin.x + panningView.frame.size.width + translation.x) < [self rightMenuWidth] &&
                panningView.frame.origin.x <= 0)
            {
                [panningView setCenter:CGPointMake([panningView center].x + translation.x, [panningView center].y)];
            }
        }
        else if (self.menuState == AMSlideMenuClosed)
        {
            if (panningState == AMSlidePanningStateRight && self.leftMenu)
            {
                if (abs(translation.x) > kPanMinTranslationX && translation.x > 0)
                {
                    [self openLeftMenu];
                }
                else if (panningView.frame.origin.x > ([self leftMenuWidth] / 2.0f))
                {
                    [self openLeftMenu];
                }
                else if ((panningView.frame.origin.x + translation.x) < [self leftMenuWidth] && (panningView.frame.origin.x + translation.x) > 0)
                {
                    [panningView setCenter:CGPointMake([panningView center].x + translation.x, [panningView center].y)];
                }
            }
            else if (panningState == AMSlidePanningStateLeft  && self.rightMenu)
            {
                if (abs(translation.x) > kPanMinTranslationX && translation.x < 0)
                {
                    [self openRightMenu];
                }
                else if (self.view.frame.size.width - (panningView.frame.origin.x + panningView.frame.size.width) > ([self rightMenuWidth] / 2.0f))
                {
                    [self openRightMenu];
                }
                else if (self.view.frame.size.width - (panningView.frame.origin.x + panningView.frame.size.width + translation.x) <= [self rightMenuWidth])
                {
                    if (panningView.frame.origin.x + translation.x <= 0)
                    {
                        [panningView setCenter:CGPointMake([panningView center].x + translation.x, [panningView center].y)];
                    }
                }
            }
        }
    }
    
    if (panningPreviousEventDate != nil) {
        CGFloat movement = panningView.frame.origin.x - panningPreviousPosition;
        NSTimeInterval movementDuration = [[NSDate date] timeIntervalSinceDate:panningPreviousEventDate] * 1000.0f;
        panningXSpeed = movement / movementDuration;
    }
    panningPreviousEventDate = [NSDate date];
    panningPreviousPosition = panningView.frame.origin.x;
    
    [gesture setTranslation:CGPointZero inView:panningView];
}

@end
