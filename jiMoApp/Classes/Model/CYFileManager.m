//
//  CYFileManager.m
//  jiMoApp
//
//  Created by 成焱 on 14-4-6.
//  Copyright (c) 2014年 chengYan. All rights reserved.
//

#import "CYFileManager.h"
#import "ITTGobalPaths.h"
#import "ITTObjectSingleton.h"
#import "CommonUtils.h"
@implementation CYFileManager

ITTOBJECT_SINGLETON_BOILERPLATE(CYFileManager, shareInstance)

- (id)init
{
    self = [super init];
    if (self) {
        NSString *txtFileResourcePath = ITTPathForDocumentsResource(@"txt");
        if (![txtFileResourcePath isEmptyOrNull]) {
            if ([[NSFileManager defaultManager]fileExistsAtPath:txtFileResourcePath]) {
                [CommonUtils createDirectorysAtPath:txtFileResourcePath];
            }
        }
    }
    return self;
}

- (NSString *)getTxtPath
{
    if (![ITTPathForDocumentsResource(@"txt")isEmptyOrNull]) {
        return ITTPathForDocumentsResource(@"txt");
    }else{
        return @"";
    }
}
@end
