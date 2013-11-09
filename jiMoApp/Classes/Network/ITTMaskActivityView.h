//
//  ITTMaskActivityView.h
//  iTotemFramework
//
//  Created by jack 廉洁 on 3/28/12.
//  Copyright (c) 2012 iTotemStudio. All rights reserved.
//

#import "ITTXibView.h"

@class ITTBaseDataRequest;

@interface ITTMaskActivityView : ITTXibView
{
    void (^_onRequestCanceled)(ITTMaskActivityView *);
}

- (void)showInView:(UIView*)view;
- (void)showInView:(UIView *)view withHintMessage:(NSString *)message;
- (void)showInView:(UIView *)view withHintMessage:(NSString *)message
   onCancleRequest:(void(^)(ITTMaskActivityView *view))onCanceledBlock;

- (void)hide;

@end