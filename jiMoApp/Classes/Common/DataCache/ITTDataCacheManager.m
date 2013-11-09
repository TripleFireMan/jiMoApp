//
//  DataCacheManager.m
//  
//
//  Created by lian jie on 6/8/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "ITTDataCacheManager.h"
#import "ITTObjectSingleton.h"
#import "ITTCacheDao.h"

@interface ITTDataCacheManager()
{
    ITTCacheDao *_cacheDao;
}

- (void)registerMemoryWarningNotification;

@end

@implementation ITTDataCacheManager

ITTOBJECT_SINGLETON_BOILERPLATE(ITTDataCacheManager, sharedManager)

#pragma mark - lifecycle methods

- (id)init
{
    self = [super init];
    if(self){
        [self setup];
        [self restore]; 
        [self registerMemoryWarningNotification];
    }
    return self;
}

#pragma mark - private methods
- (void)registerMemoryWarningNotification
{
#if TARGET_OS_IPHONE
    // Subscribe to app events
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(clearMemoryCache)
                                                 name:UIApplicationDidReceiveMemoryWarningNotification
                                               object:nil];    
#ifdef __IPHONE_4_0
    UIDevice *device = [UIDevice currentDevice];
    if ([device respondsToSelector:@selector(isMultitaskingSupported)] && device.multitaskingSupported){
        // When in background, clean memory in order to have less chance to be killed
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(clearMemoryCache)
                                                     name:UIApplicationDidEnterBackgroundNotification
                                                   object:nil];
    }
#endif
#endif        
}

- (void)setup
{
    _cacheDao = [[NSClassFromString(@"ITTFileCacheDao") alloc] init];
}

- (void)restore
{
    [_cacheDao restore];
}

- (BOOL)hasObjectInCacheByKey:(NSString*)key
{
    return [_cacheDao hasObjectInCacheByKey:key];
}

- (NSObject*)getCachedObjectByKey:(NSString*)key
{
    return [_cacheDao getCachedObjectByKey:key];
}

- (void)clearAllCache
{
    [_cacheDao clearAllCache];
}

- (void)clearAllDiskCache
{
    [_cacheDao clearAllDiskCache];
}

- (void)clearMemoryCache
{
    [_cacheDao clearMemoryCache];
}

- (void)addObject:(NSObject*)obj forKey:(NSString*)key
{
    [_cacheDao addObject:obj forKey:key];
}

- (void)addObjectToMemory:(NSObject*)obj forKey:(NSString*)key
{
    [_cacheDao addObjectToMemory:obj forKey:key];
}

- (void)removeObjectInCacheByKey:(NSString*)key
{
    [_cacheDao removeObjectInCacheByKey:key];
}

- (void)doSave
{
    [_cacheDao doSave];
}
@end
