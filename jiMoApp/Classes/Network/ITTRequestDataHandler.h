//
//  RequestDataHandler.h
//  iTotemFramework
//
//  Created by Sword on 13-9-5.
//  Copyright (c) 2013年 iTotemStudio. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ITTRequestDataHandler : NSObject

- (id)handleResultString:(NSString *)resultString error:(NSError **)error;

@end
