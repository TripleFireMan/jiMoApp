//
//  CommonUtils.h
//  LingQ
//
//  Created by Rainbow on 8/23/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#include <ifaddrs.h>
#include <arpa/inet.h>
#import <mach/mach.h>
#import <mach/mach_host.h>
#import <Foundation/Foundation.h>


@interface CommonUtils : NSObject

+ (long)getDocumentSize:(NSString *)folderName;

+ (BOOL)createDirectorysAtPath:(NSString *)path;

+ (NSString *)getIPAddress;
+ (NSString *)getFreeMemory;
+ (NSString *)getDiskUsed;
+ (NSString *)getStringValue:(id)value;
+ (NSString *)getDirectoryPathByFilePath:(NSString *)filepath;
+ (NSString *)convertArrayToString:(NSArray *)array;

+ (NSArray *)convertStringToArray:(NSString *)string;
+ (NSArray *)getLetters;
+ (NSArray *)getUpperLetters;

@end
