//
//  ITTImageDataOperation.m
//  AiQiChe
//
//  Created by lian jie on 7/18/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "ITTImageDataOperation.h"
#import "ITTImageCacheManager.h"
#import "UIImage+ITTAdditions.h"
#import "ITTNetworkTrafficManager.h"

@implementation ITTImageDataOperation


- (void)dealloc
{
    [self cancel];
    _delegate = nil;
}

- (id)initWithURL:(NSString *)url delegate:(id<ITTImageDataOperationDelegate>)delegate
{
    self = [super init];
	if (self) {
		_imageUrl = url;
		_delegate = delegate;
        _targetSize = CGSizeZero;
	}
	return self;
}

- (void)cancel
{
    [super cancel];
    _delegate = nil;
}

- (void)main
{
    UIImage *image = [[ITTImageCacheManager sharedManager] getImageFromCacheWithUrl:_imageUrl];
	if(!image){
        ITTDINFO(@"loading image from web:%@",_imageUrl);
		NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:_imageUrl]];
		if( imageData!=nil){
			image = [UIImage imageWithData:imageData];
            [[ITTImageCacheManager sharedManager] saveImage:[UIImage imageWithData:imageData] withUrl:_imageUrl];
            [[ITTNetworkTrafficManager sharedManager] logTrafficOut:[_imageUrl lengthOfBytesUsingEncoding:NSUTF8StringEncoding]];
            [[ITTNetworkTrafficManager sharedManager] logTrafficIn:[imageData length]];
		}
	}
    if (image && _delegate && [_delegate respondsToSelector:@selector(imageDataOperation:loadedWithUrl:withImage:)]) {
        if (_targetSize.height > 0 && _targetSize.width > 0) {
            [_delegate imageDataOperation:self 
                            loadedWithUrl:_imageUrl
                                withImage:[image imageFitInSize:_targetSize]];
        }else{
            
            [_delegate imageDataOperation:self 
                            loadedWithUrl:_imageUrl
                                withImage:image];
        }
    }
}
@end
