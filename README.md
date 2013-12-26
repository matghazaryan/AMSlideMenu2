AMSlideMenu  
===========

Sliding Menu for iOS by <b> arturdev </b>.

This is a simple library to create sliding menus that can be used in storyboards and support static cells.

Whith this library you can create 3 types of sliding menus: <br>
1. Slide menu with <b>right</b> menu only. <br>
2. Slide menu with <b>left</b> menu only. <br>
3. Slide menu with <b>both left and right</b> menus. <br>


This repo contains project that demonstrate usage of <b> AMSlideMenu </b>.<br>
This project created in <b>Xcode 5</b> , so this library is <b>fully compatible with iOS 7</b>

USAGE
=====

You can use AMSlideMenu with both static cells and dynamic cell prototypes.

Just follow this steps:<br>
1. Copy AMSlideMenu/<b>AMSlideMenu</b> folder to your project. <br>
2. Make a subclass of <b>AMSlideMenuMainViewController</b>. Assume you made <b>MainVC.h</b> and <b>MainVC.m</b> files (like in this project).<br> 
3. Add a UIViewController to your iPhone's or iPad's storyboard and name it's class to MainVC<br>
4. For Left  Menu:<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Add a UITableViewController to your storyboard and name it's class to any class that inherits from <br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<b>AMSlideMenuLeftTableViewController</b>. Connect the AMSlideMenuMainViewController with your subclass with a custom 
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;segue of type <b>AMSlideMenuLeftMenuSegue</b>, set the segue identifier to <b>leftMenu</b>.    

&nbsp;&nbsp;&nbsp;&nbsp;For Right Menu:<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Add a UITableViewController to your storyboard and name it's class to any class that inherits from <br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<b>AMSlideMenuRightTableViewController</b>. Connect the AMSlideMenuMainViewController with your subclass with a custom 
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;segue of type <b>AMSlideMenuRightMenuSegue</b>, set the segue identifier to <b>rightMenu</b>.<br>     
5. To add Content ViewController you have to to do the following:<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&#8226; Create your content view controller and embed it in a <b>UINavigationController</b><br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&#8226; Connect it to the <b>AMSlideMenuLeftTableViewController</b> or <b>AMSlideMenuRightTableViewController</b> with custom segue 
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<b>AMSlideMenuContentSegue</b> and set some identifier.<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; If you want to use dynamic cells , then you have to perform segues in 
-tableView:didSelectRowAtIndexPath: method yourself.<br>

6.. In MainVC.m override this methods and return segue identifiers that you setted in previous step: <br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;-(NSString *)segueIdentifierForIndexPathInLeftMenu:(NSIndexPath *)indexPath; <br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;-(NSString *)segueIdentifierForIndexPathInRightMenu:(NSIndexPath *)indexPath; <br>

Thats it, you are done.

CUSTOMIZATION
=============

You can easily customize slide menu by overriding needed methods in you MainVC.m , such us: 
<pre>
- (AMPrimaryMenu)primaryMenu;
- (NSIndexPath *)initialIndexPathForLeftMenu;
- (NSIndexPath *)initialIndexPathForRightMenu;
- (NSString *)segueIdentifierForIndexPathInLeftMenu:(NSIndexPath *)indexPath;
- (NSString *)segueIdentifierForIndexPathInRightMenu:(NSIndexPath *)indexPath;
- (void)configureLeftMenuButton:(UIButton *)button;
- (void)configureRightMenuButton:(UIButton *)button;
- (CGFloat)leftMenuWidth;
- (CGFloat)rightMenuWidth;
- (void) configureSlideLayer:(CALayer *)layer;
- (CGFloat) panGestureWarkingAreaPercent;
</pre>

You cas use this methods in you MainVC.m if you want to open or close left or right menus programmatically:
<pre>
- (void)openLeftMenu;
- (void)openLeftMenuAnimated:(BOOL)animated;
- (void)openRightMenu;
- (void)openRightMenuAnimated:(BOOL)animated;
- (void)closeLeftMenu;
- (void)closeLeftMenuAnimated:(BOOL)animated;
- (void)closeRightMenu;
- (void)closeRightMenuAnimated:(BOOL)animated;
</pre>

If you want to get menu's open/close callbacks, then set MainVC's delegate property,
and implement protocol named 'AMSlideMenuProtocols'.
<pre>
@optional
- (void)leftMenuWillOpen;
- (void)leftMenuDidOpen;
- (void)rightMenuWillOpen;
- (void)rightMenuDidOpen;

- (void)leftMenuWillClose;
- (void)leftMenuDidClose;
- (void)rightMenuWillClose;
- (void)rightMenuDidClose;
</pre>

<img src="https://raw.github.com/arturdev/AMSlideMenu/5c5af35e78a34275e1a3665b37b75ecd715b5d3c/AMSlideMenu/ScreenShotLeftMenu.png" width="320" height="580"><br>
<img src="https://raw.github.com/arturdev/AMSlideMenu/5c5af35e78a34275e1a3665b37b75ecd715b5d3c/AMSlideMenu/ScreenshowRightMenu.png" width="320" height="580"><br>
<img src="https://raw.github.com/arturdev/AMSlideMenu/5c5af35e78a34275e1a3665b37b75ecd715b5d3c/AMSlideMenu/ScreenshotBothMenu.png" width="320" height="580">
