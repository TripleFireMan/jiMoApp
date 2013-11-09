//
//  ITTImageCacheManager.h
//  hupan
//
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface ITTImageCacheManager : NSObject {
	NSOperationQueue *_imageQueue;
    NSMutableDictionary *_memoryCache;
    NSDate *_lastSuspendedTime;
}
@property (nonatomic,strong) NSOperationQueue *imageQueue;

+ (ITTImageCacheManager *)sharedManager;
- (void)clearMemoryCache;
- (void)clearDiskCache;
- (void)restore;
- (void)saveImage:(UIImage*)image withUrl:(NSString*)url;
- (void)saveImage:(UIImage*)image withKey:(NSString*)key;
- (NSString *)createImageFilePathWithUrl:(NSString *)url;
- (UIImage*)getImageFromCacheWithUrl:(NSString*)url;
- (UIImage*)getImageFromCacheWithKey:(NSString*)key;
- (BOOL)isImageInMemoryCacheWithUrl:(NSString*)url;
- (void)suspendImageLoading;
- (void)restoreImageLoading;
@end
