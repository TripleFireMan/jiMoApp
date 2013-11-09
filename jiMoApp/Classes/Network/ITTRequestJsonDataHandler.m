//
//  ITTRequestJsonDataHandler.m
//  iTotemFramework
//
//  Created by Sword on 13-9-5.
//  Copyright (c) 2013年 iTotemStudio. All rights reserved.
//

#import "ITTRequestJsonDataHandler.h"
#import "JSONKit.h"

@implementation ITTRequestJsonDataHandler

- (id)handleResultString:(NSString *)resultString error:(NSError **)error
{
    NSMutableDictionary *returnDic;
    resultString = [resultString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    if (![resultString isStartWithString:@"{"]) {
        resultString = [NSString stringWithFormat:@"{\"data\":%@}", resultString];
    }
    NSData *jsonData = [resultString dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *resultDic = [NSJSONSerialization JSONObjectWithData:jsonData options:0 error:error];
    if(resultDic) {
        returnDic = [[NSMutableDictionary alloc] initWithDictionary:resultDic];        
    }
    return returnDic;
}

@end
