//
//  CYDirectory.h
//  jiMoApp
//
//  Created by 成焱 on 14-4-8.
//  Copyright (c) 2014年 chengYan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CYDirectory : NSObject
@property (nonatomic, assign) NSInteger index;//索引
@property (nonatomic, copy) NSString *parentDirectoryName;//上一级的url路径名
@property (nonatomic, copy) NSString *parentDirectoryAbsoluteUrl;//上一级的完全路径名
@property (nonatomic, copy) NSString *currentDirectoryName;//当前级的url路径名
@property (nonatomic, copy) NSString *currentDirectoryAbsoluteUrl;//当前级的完全路径名
@end
