//
//  Header.h
//  AMSlideMenu
//
//  Created by Artur Mkrtchyan on 12/24/13.
//  Copyright (c) 2013 Artur Mkrtchyan. All rights reserved.
//

@protocol AMSlideMenuDataSource <NSObject>

@optional


@end


//--------------------------//
#pragma mark -
//--------------------------//


@protocol AMSlideMenuDelegate <NSObject>

@optional
- (void)leftMenuWillOpen;
- (void)leftMenuDidOpen;
- (void)rightMenuWillOpen;
- (void)rightMenuDidOpen;

- (void)leftMenuWillClose;
- (void)leftMenuDidClose;
- (void)rightMenuWillClose;
- (void)rightMenuDidClose;

@end