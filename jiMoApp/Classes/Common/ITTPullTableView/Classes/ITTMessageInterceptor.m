//
//  MessageInterceptor.m
//  TableViewPull
//
//  From http://stackoverflow.com/questions/3498158/intercept-obj-c-delegate-messages-within-a-subclass

#import "ITTMessageInterceptor.h"

@implementation ITTMessageInterceptor
@synthesize receiver = _receiver;
@synthesize middleMan = _middleMan;

- (id)forwardingTargetForSelector:(SEL)aSelector
{
    if ([_middleMan respondsToSelector:aSelector]) { return _middleMan; }
    if ([_receiver respondsToSelector:aSelector]) { return _receiver; }
    return [super forwardingTargetForSelector:aSelector];
}

- (BOOL)respondsToSelector:(SEL)aSelector
{
    if ([_middleMan respondsToSelector:aSelector]) { return YES; }
    if ([_receiver respondsToSelector:aSelector]) { return YES; }
    return [super respondsToSelector:aSelector];
}

@end
