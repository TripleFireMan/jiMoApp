//
//  DataEnvironment.h
//
//  Copyright 2010 itotem. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ITTDataEnvironment : NSObject {
    NSString *_urlRequestHost;
}

@property (nonatomic,strong) NSString *urlRequestHost;

+ (ITTDataEnvironment *)sharedDataEnvironment;

- (void)clearNetworkData;
- (void)clearCacheData;

@end
