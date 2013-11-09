//
//  ITTImageManager.m
// 
//  Copyright 2010 iTotem. All rights reserved.
//

#import "ITTImageView.h"
#import "UIUtil.h"
#import "ITTDataEnvironment.h"
#import "UIImageView+WebCache.h"

@interface ITTImageView()
{    
}

@property (nonatomic, strong) UIActivityIndicatorView *indicator;
@property (nonatomic, strong) UITapGestureRecognizer *tapGestureRecognizer;

-(void)showLoading;
-(void)hideLoading;
-(void)handleTapGesture:(UITapGestureRecognizer *)recognizer;

@end

@implementation ITTImageView

- (void)dealloc
{
    _delegate = nil;
    [self cancelCurrentImageRequest];
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    self.indicatorViewStyle = UIActivityIndicatorViewStyleGray;
    self.showLoadingView = YES;
}

- (id)init
{
    self = [super init];
	if (self) {
        self.indicatorViewStyle = UIActivityIndicatorViewStyleGray;
        self.showLoadingView = YES;
	}
	return self;
}

- (void)cancelCurrentImageRequest
{
    [self cancelCurrentImageLoad];
    [self hideLoading];
}

- (void)loadImage:(NSString*)url
{
    [self loadImage:url placeHolder:nil];
}

- (void)loadImage:(NSString*)url placeHolder:(UIImage *)placeHolderImage
{
    if(nil == url || [@"" isEqualToString:url] ) {
		return;
    }
    self.imageUrl = url;
    [self cancelCurrentImageRequest];
    if (self.showLoadingView) {
        [self showLoading];
    }
    __weak ITTImageView *weakSelf = self;                   
    NSURL *URL = [[NSURL alloc] initWithString:_imageUrl];
    [self setImageWithURL:URL placeholderImage:placeHolderImage options:SDWebImageProgressiveDownload progress:^(NSUInteger receivedSize, long long expectedSize) {
        if (expectedSize > 0) {
            if (weakSelf.delegate && [weakSelf.delegate respondsToSelector:@selector(imageViewDidChangeProgress:progress:)]) {
                [weakSelf.delegate imageViewDidChangeProgress:weakSelf progress:1.0*receivedSize/expectedSize];
            }
        }
         if (weakSelf.showLoadingView) {
             [weakSelf showLoading];
         }
     }
    completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType)
     {
         [weakSelf hideLoading];
         if (weakSelf.delegate && [weakSelf.delegate respondsToSelector:@selector(imageViewDidLoaded:image:)]) {
             [weakSelf.delegate imageViewDidLoaded:weakSelf image:image];
         }
         
     }];
}

-(void)setEnableTapEvent:(BOOL)enableTapEvent
{
    _enableTapEvent = enableTapEvent;
    if (_enableTapEvent) {
        [self setUserInteractionEnabled:YES];
        if (!_tapGestureRecognizer) {
            _tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapGesture:)];
            _tapGestureRecognizer.cancelsTouchesInView = NO;
            [self addGestureRecognizer:_tapGestureRecognizer];
        }
    } else {
        if (_tapGestureRecognizer) {
            [self removeGestureRecognizer:_tapGestureRecognizer];
            _tapGestureRecognizer = nil;
        }
    }
}

-(void)setIndicatorViewStyle:(UIActivityIndicatorViewStyle)style
{
    _indicatorViewStyle = style;
    [_indicator setActivityIndicatorViewStyle:style];
}

-(void)showLoading
{
    if (!_indicator) {
        _indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:_indicatorViewStyle];
        _indicator.center = CGRectGetCenter(self.bounds);
        [_indicator setAutoresizingMask:UIViewAutoresizingFlexibleLeftMargin|UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin|UIViewAutoresizingFlexibleTopMargin];
    }
    if (!_indicator.isAnimating||_indicator.hidden) {
        _indicator.hidden = NO;
        if(!_indicator.superview){
            [self addSubview:_indicator];
        }
        [_indicator startAnimating];        
    }
}

-(void)hideLoading
{
    if (_indicator) {
        [_indicator stopAnimating];
        _indicator.hidden = YES;
    }
}

- (void)handleTapGesture:(UITapGestureRecognizer *)recognizer
{
    if (_delegate && [_delegate respondsToSelector:@selector(imageViewDidClicked:)]) {
        [_delegate imageViewDidClicked:self];
	}
}
@end

