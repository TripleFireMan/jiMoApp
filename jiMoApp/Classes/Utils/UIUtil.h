//
//  UIUtil.h
//
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "CONSTS.h"

@interface UIUtil : NSObject

+ (void)adjustPositionToPixel:(UIView*)view;
+ (void)adjustPositionToPixelByOrigin:(UIView*)view;
+ (void)setRoundCornerForView:(UIView*)view withRadius:(CGFloat)radius;
+ (void)setBorderForView:(UIView*)view withWidth:(CGFloat)width withColor:(UIColor*)color;

+ (NSString *)imageName:(NSString *)name;

@end
