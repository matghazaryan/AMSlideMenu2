//
//  UIColor+CreateMethods.h
//  PTO
//
//  Created by Ashot Tonoyan on 21/07/2012.
//  Copyright (c) 2012 SocialObjects Software. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (CreateMethods)

// wrapper for [UIColor colorWithRed:green:blue:alpha:]
// values must be in range 0 - 255
+ (UIColor*)colorWith8BitRed:(NSInteger)red green:(NSInteger)green blue:(NSInteger)blue alpha:(CGFloat)alpha;

// hex - must be in format: #FF00CC 
// alpha - must be in range 0.0 - 1.0
+ (UIColor*)colorWithHex:(NSString*)hex alpha:(CGFloat)alpha;

@end
