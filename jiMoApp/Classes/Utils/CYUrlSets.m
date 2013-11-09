//
//  CYUrlSetTool.m
//  iTotemMinFramework
//
//  Created by CY on 13-10-29.
//
//

#import "CYUrlSets.h"

#define LOTTERY_URL_DEBUG
#ifdef LOTTERY_URL_DEBUG
#define HOSTUrl() @"http://www.baidu.com/"
#else
#define HOSTUrl() @"http://www.google.com/"
#endif

#define SUFFIX(suffix) suffix
#define REAL_URL(url) HOSTUrl()SUFFIX(url)

NSString const *cyTestUrl = REAL_URL(@"aaaa");
