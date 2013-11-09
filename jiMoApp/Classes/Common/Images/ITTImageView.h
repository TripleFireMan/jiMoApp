//
//  ITTImageView.h
//
//  Copyright 2010 iTotem. All rights reserved.
//
#import "ITTImageDataOperation.h"

@class ITTImageView;

@protocol ITTImageViewDelegate <NSObject>

@optional

- (void)imageViewDidLoaded:(ITTImageView *)imageView image:(UIImage*)image;
- (void)imageViewDidChangeProgress:(ITTImageView *)imageView progress:(CGFloat)progress;
- (void)imageViewDidClicked:(ITTImageView *)imageView;

@end

@interface ITTImageView : UIImageView <UIGestureRecognizerDelegate>
{
}

@property (nonatomic,weak) id<ITTImageViewDelegate> delegate;
@property (nonatomic,assign) BOOL enableTapEvent;
@property (nonatomic,assign) BOOL showLoadingView;
@property (nonatomic,assign) UIActivityIndicatorViewStyle indicatorViewStyle;
@property (nonatomic,strong) NSString *imageUrl;

- (void)loadImage:(NSString*)url;
- (void)loadImage:(NSString*)url placeHolder:(UIImage *)placeHolderImage;
- (void)cancelCurrentImageRequest;     //caller must call this method in its dealloc method

@end
