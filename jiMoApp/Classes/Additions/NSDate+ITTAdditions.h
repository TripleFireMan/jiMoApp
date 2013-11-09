//
//  NSDate+ITTAdditions.h
//
//  Created by guo hua on 11-9-19.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NSDate(ITTAdditions)

+ (NSDate *)dateWithString:(NSString *)str formate:(NSString *)formate;
+ (NSDate *)relativedDateWithInterval:(NSInteger)interval;

+ (NSString *)timeStringWithInterval:(NSTimeInterval) time;
- (NSString *)stringWithSeperator:(NSString *)seperator;
- (NSString *)stringWithFormat:(NSString*)format;
- (NSString *)stringWithSeperator:(NSString *)seperator includeYear:(BOOL)includeYear;
- (NSString *)weekday;

- (NSDate *)relativedDateWithInterval:(NSInteger)interval ;

@end