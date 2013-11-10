//
//  CYCommonMacros.h
//  jiMoApp
//
//  Created by CY on 13-11-11.
//  Copyright (c) 2013年 chengYan. All rights reserved.
//

#ifndef CY_Common_macros
#define CY_Common_macros

#ifndef SCREEN_4_INCH
#define SCREEN_4_INCH 568
#endif

#ifndef SCREEN_3_5_INCH
#define SCREEN_3_5_INCH 480
#endif


#ifndef IS_SCREEN_INCH_4
#define IS_SCREEN_INCH_4  ([UIScreen mainScreen].bounds.size.height == SCREEN_4_INCH)
#endif

#pragma mark screen

#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_7_0
#define CY_SCREEN_HEIGHT (IS_SCREEN_INCH_4?SCREEN_4_INCH:SCREEN_3_5_INCH)
#define CY_ORIGIN_Y 20
#else
#define CY_SCREEN_HEIGHT (IS_SCREEN_INCH_4?(SCREEN_4_INCH-20):(SCREEN_3_5_INCH-20))
#define CY_ORIGIN_Y 0
#endif

#endif