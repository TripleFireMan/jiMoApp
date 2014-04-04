//
//  UINavigationController+IOS_6_1.m
//  jiMoApp
//
//  Created by 成焱 on 14-4-5.
//  Copyright (c) 2014年 chengYan. All rights reserved.
//

#import "UINavigationController+IOS_6_1.h"
@implementation UINavigationController (IOS_6_1)

- (BOOL)shouldAutorotate {
    return [[self.viewControllers lastObject]shouldAutorotate];
}

- (NSUInteger)supportedInterfaceOrientations {
    return [[self.viewControllers lastObject]supportedInterfaceOrientations];
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation {
    return [[self.viewControllers lastObject]preferredInterfaceOrientationForPresentation];
}
@end
