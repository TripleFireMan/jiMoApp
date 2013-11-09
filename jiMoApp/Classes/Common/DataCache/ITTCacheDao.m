//
//  ITTCacheDao.m
//  iTotemFramework
//
//  Created by Sword on 13-9-6.
//  Copyright (c) 2013年 iTotemStudio. All rights reserved.
//

#import "ITTCacheDao.h"

@implementation ITTCacheDao

- (BOOL)hasObjectInCacheByKey:(NSString*)key
{
    SHOULDOVERRIDE(@"ITTCacheDao", NSStringFromClass([self class]));
    return TRUE;
}

- (BOOL)hasObjectInMemoryByKey:(NSString*)key
{
    SHOULDOVERRIDE(@"ITTCacheDao", NSStringFromClass([self class]));
    return TRUE;
}

- (id)getCachedObjectByKey:(NSString*)key
{
    SHOULDOVERRIDE(@"ITTCacheDao", NSStringFromClass([self class]));
    return nil;
}

- (void)restore
{
    SHOULDOVERRIDE(@"ITTCacheDao", NSStringFromClass([self class]));
}

- (void)clearAllCache
{
}

- (void)clearAllDiskCache
{
}

- (void)clearMemoryCache
{
    SHOULDOVERRIDE(@"ITTCacheDao", NSStringFromClass([self class]));    
}

- (void)addObject:(NSObject*)obj forKey:(NSString*)key
{
    SHOULDOVERRIDE(@"ITTCacheDao", NSStringFromClass([self class]));    
}

- (void)addObjectToMemory:(NSObject*)obj forKey:(NSString*)key
{
    SHOULDOVERRIDE(@"ITTCacheDao", NSStringFromClass([self class]));    
}

- (void)removeObjectInCacheByKey:(NSString*)key
{
    SHOULDOVERRIDE(@"ITTCacheDao", NSStringFromClass([self class]));    
}

- (void)doSave
{
    SHOULDOVERRIDE(@"ITTCacheDao", NSStringFromClass([self class]));    
}
@end
