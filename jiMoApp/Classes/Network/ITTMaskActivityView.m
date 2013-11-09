//
//  ITTMaskActivityView.m
//  iTotemFramework
//
//  Created by jack 廉洁 on 3/28/12.
//  Copyright (c) 2012 iTotemStudio. All rights reserved.
//
//  Modify by Sword on 5/2 2013

#import "ITTMaskActivityView.h"

@interface ITTMaskActivityView()

@property (strong, nonatomic) IBOutlet UIView *bgMaskView;
@property (strong, nonatomic) IBOutlet UILabel *hintLabel;
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *maskViewIndicator;
@property (strong, nonatomic) IBOutlet UIButton *cancleBtn;

@end

@implementation ITTMaskActivityView

- (void)awakeFromNib
{
    [super awakeFromNib];
    _bgMaskView.layer.masksToBounds = YES;
    _bgMaskView.layer.cornerRadius = 5;
}

- (UIView*)keyboardView
{
	NSArray *windows = [[UIApplication sharedApplication] windows];
	for (UIWindow *window in [windows reverseObjectEnumerator])
	{
		for (UIView *view in [window subviews])
		{
            // UIPeripheralHostView is used from iOS 4.0, UIKeyboard was used in previous versions:
			if (!strcmp(object_getClassName(view), "UIPeripheralHostView") || !strcmp(object_getClassName(view), "UIKeyboard"))
			{
				return view;
			}
		}
	}
	return nil;
}

- (UIView*)viewForView:(UIView *)view
{
    UIView *keyboardView = [self keyboardView];
    if (keyboardView) {
        view = keyboardView.superview;
    }
    return view;
}

//  Modify by Sword on 5/2 2013
- (void)showInView:(UIView*)parentView
{
    [self showInView:parentView withHintMessage:nil onCancleRequest:nil];
}

//  Modify by Sword on 5/2 2013
- (void)showInView:(UIView *)view withHintMessage:(NSString *)message
{
    [self showInView:view withHintMessage:message onCancleRequest:nil];    
}

//  Modify by Sword on 5/2 2013
- (void)showInView:(UIView *)view withHintMessage:(NSString *)message
   onCancleRequest:(void (^)(ITTMaskActivityView *))onCanceledBlock
{
    if (onCanceledBlock) {
        _onRequestCanceled = [onCanceledBlock copy];
    }
    UIView *superView = [self viewForView:view];
    [superView addSubview:self];
    
    CGPoint origin = CGPointMake((CGRectGetWidth(superView.bounds) - CGRectGetWidth(self.bounds))/2, (CGRectGetHeight(superView.bounds) - CGRectGetHeight(self.bounds))/2);
    CGRect frame = self.bounds;
    frame.origin.x = origin.x;
    frame.origin.y = origin.y;
    self.frame = frame;
    
    _hintLabel.hidden = NO;
    _hintLabel.text = message;
    self.alpha = 0;
    [UIView animateWithDuration:0.3
                     animations:^{
                         self.alpha = 1;
                     }
                     completion:^(BOOL finished) {
                         //
                     }];    
}

- (void)hide
{
    [UIView animateWithDuration:0.3
                     animations:^{
                         self.alpha = 0;
                     }
                     completion:^(BOOL finished) {
                         [self removeFromSuperview];
                     }];
}

//  Modify by Sword on 5/2 2013
- (IBAction)onCancelBtnTouched:(id)sender
{
    if (_onRequestCanceled) {
        _onRequestCanceled(self);
    }
}

@end
