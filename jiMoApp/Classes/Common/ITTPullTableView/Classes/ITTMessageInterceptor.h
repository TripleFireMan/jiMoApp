//
//  MessageInterceptor.h
//  TableViewPull
//
//  From http://stackoverflow.com/questions/3498158/intercept-obj-c-delegate-messages-within-a-subclass

#import <Foundation/Foundation.h>

@interface ITTMessageInterceptor : NSObject
{
//    id receiver;
//    id middleMan;
}
@property (nonatomic, weak) id receiver;
@property (nonatomic, weak) id middleMan;
@end
