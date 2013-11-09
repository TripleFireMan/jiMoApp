//
//  ITTCacheDao.h
//  iTotemFramework
//
//  Created by Sword on 13-9-6.
//  Copyright (c) 2013年 iTotemStudio. All rights reserved.
//

#import <Foundation/Foundation.h>

#define UD_KEY_DATA_CACHE_KEYS @"UD_KEY_DATA_CACHE_KEYS"

@interface ITTCacheDao : NSObject

/*!
 * @param key the key
 * @returns Returns a Boolean value that indicates whether a given object is present in the local disk and memory cache pool
 */
- (BOOL)hasObjectInCacheByKey:(NSString*)key;

/*!
 * Returns a Boolean value that indicates whether a given object is present in the local disk and memory cache pool
 * @param key the key
 */
- (id)getCachedObjectByKey:(NSString*)key;

/*!
 * restore all cached objects
 */
- (void)restore;

/*!
 * clear all cached objects in disk and memory
 */
- (void)clearAllCache;

/*!
 * clear all cached objects in disk
 */
- (void)clearAllDiskCache;

/*!
 * clear all memory cached objects
 */
- (void)clearMemoryCache;

/*!
 *	cache object in memory and disk, all cache object will when user exit the app
 *	@param	obj	The object to add to the memory cache pool. This value must not be nil
 *	@param	key The key for value. The key is copied (using copyWithZone:; keys must conform to the NSCopying protocol).
 *          If aKey already exists in the dictionary anObject takes its place.
 */
- (void)addObject:(NSObject*)obj forKey:(NSString*)key;

/*!
 *	cache object in memory, all cache object will when user exit the app
 *	@param	obj	The object to add to the memory cache pool. This value must not be nil
 *	@param	key The key for value. The key is copied (using copyWithZone:; keys must conform to the NSCopying protocol). 
 *          If aKey already exists in the dictionary anObject takes its place.
 */
- (void)addObjectToMemory:(NSObject*)obj forKey:(NSString*)key;

/*!
 *	remove cached object with specified key
 *	@param	key	The key to remove from the memory cache pool. This value must not be nil, otherwise nothing will happen
 */
- (void)removeObjectInCacheByKey:(NSString*)key;

/*!
 *	save all cached objects to disk
 */
- (void)doSave;

@end
