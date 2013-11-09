//
//  LocaleUtils.m
//  hupan
//
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "LocaleUtils.h"


@implementation LocaleUtils
+ (NSString *)getCountryCode
{
    NSLocale *currentLocale = [NSLocale currentLocale];
    
    //    NSLog(@"Country Code is %@", [currentLocale objectForKey:NSLocaleCountryCode]);    
    return [currentLocale objectForKey:NSLocaleCountryCode];
}

+ (NSString *)getLanguageCode
{
    NSLocale *currentLocale = [NSLocale currentLocale];
    
    ITTDINFO(@"Language Code is %@", [currentLocale objectForKey:NSLocaleLanguageCode]);    
    
    return [currentLocale objectForKey:NSLocaleLanguageCode];
}
@end
