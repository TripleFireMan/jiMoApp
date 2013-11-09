//
//  ITTDataRequestManager.h
//  iTotemFrame
//  数据请求管理中心
//  Created by jack 廉洁 on 3/12/12.
//  Copyright (c) 2012 iTotemStudio. All rights reserved.
//

#import <Foundation/Foundation.h>
@class ITTBaseDataRequest;

@interface ITTDataRequestManager : NSObject
{
    NSMutableArray *_requests;
}

+ (ITTDataRequestManager *)sharedManager;

- (void)addRequest:(ITTBaseDataRequest*)request;
- (void)removeRequest:(ITTBaseDataRequest*)request;

@end
