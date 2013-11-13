//
//  CYCommonMacros.h
//  jiMoApp
//
//  Created by CY on 13-11-11.
//  Copyright (c) 2013年 chengYan. All rights reserved.
//

#ifndef CY_Common_macros
#define CY_Common_macros

/** Screen Macros
 *  SCREEN_4_INCH - the 4 inch screen's height
 *  SCREEN_3_5_INCH - the 3.5 inch screen's height
 *  IS_SCRREN_INCH_4 - the macros using for decide screen height of iPhones
 *  CY_ORIGIN_Y - the real origin of screen despite the OS_version
 *  CY_SCREEN_HEIGHT - the real screen height of screen despite the os version
 *  will add more latter
 */

#pragma mark -
#pragma mark screen

#ifndef SCREEN_4_INCH
#define SCREEN_4_INCH 568
#endif

#ifndef SCREEN_3_5_INCH
#define SCREEN_3_5_INCH 480
#endif

#ifndef IS_SCREEN_INCH_4
#define IS_SCREEN_INCH_4  ([UIScreen mainScreen].bounds.size.height == SCREEN_4_INCH)
#endif

#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_7_0
#define REAL_SCREEN_HEIGHT (IS_SCREEN_INCH_4?SCREEN_4_INCH:SCREEN_3_5_INCH)
#define REAL_ORIGIN_Y 20
#else
#define REAL_SCREEN_HEIGHT (IS_SCREEN_INCH_4?(SCREEN_4_INCH-20):(SCREEN_3_5_INCH-20))
#define REAL_ORIGIN_Y 0
#endif

/** suggest to use CYUsefulCFunctionSets 
 *  rgbColor(r,g,b),rgbaColor(r,g,b,a) instead
 */
#pragma mark -
#pragma mark RGBColor(deprecated)

#define RGB(r,g,b) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:1]
#define RGBA(r,g,b,a) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:(a)]

/** short cut of some frequently used oc tool
 *  such as NSUserDefault 、NSFileManager
 */
#pragma mark -
#pragma mark

#define USER_DEFAULT [NSUserDefaults standardUserDefaults]
#define FILE_MANAGER [NSFileManager defaultManager]


#endif