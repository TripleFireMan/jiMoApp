//
//  ITTGobalPaths.m
//  iTotemFrame
//
//  Created by jian jin on 8/23/11.
//  Copyright 2011 caixin. All rights reserved.
//


static NSBundle* globalBundle = nil;

/**
 * 设置全局bundle,默认为main bundle, 如多主题可以使用
 */
void ITTSetDefaultBundle(NSBundle* bundle)
{
    globalBundle = bundle;
}

/**
 * 返回全局默认bundle
 */
NSBundle *ITTGetDefaultBundle()
{
    return (nil != globalBundle) ? globalBundle : [NSBundle mainBundle];
}

/**
 * 返回bundle资源路径
 */
NSString *ITTPathForBundleResource(NSString* relativePath)
{
    NSString* resourcePath = [ITTGetDefaultBundle() resourcePath];
    return [resourcePath stringByAppendingPathComponent:relativePath];
}

/**
 * 返回Documents资源路径
 */
NSString *ITTPathForDocumentsResource(NSString* relativePath)
{
    static NSString* documentsPath = nil;
    if (nil == documentsPath) {
        NSArray* dirs = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        documentsPath = dirs[0];
    }
    return [documentsPath stringByAppendingPathComponent:relativePath];
}


/**
 * 返回Cache资源路径
 */
NSString *ITTPathForCacheResource(NSString* relativePath)
{
    static NSString* documentsPath = nil;
    if (nil == documentsPath) {
        NSArray* dirs = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
        documentsPath = dirs[0];
    }
    return [documentsPath stringByAppendingPathComponent:relativePath];
}


