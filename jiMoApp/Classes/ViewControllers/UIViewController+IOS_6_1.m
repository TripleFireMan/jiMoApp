//
//  UIViewController+IOS_6_1.m
//  jiMoApp
//
//  Created by 成焱 on 14-4-5.
//  Copyright (c) 2014年 chengYan. All rights reserved.
//

#import "UIViewController+IOS_6_1.h"

@implementation UIViewController (IOS_6_1)
// IOS5默认支持竖屏

- (NSUInteger)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskAll;
}

// IOS6默认不开启旋转，如果subclass需要支持屏幕旋转，重写这个方法return YES即可
- (BOOL)shouldAutorotate {
    return NO;
}

// IOS6默认支持竖屏
- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation {
    return UIInterfaceOrientationPortrait;
}
@end
