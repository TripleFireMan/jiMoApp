//
//  CYFileManager.h
//  jiMoApp
//
//  Created by 成焱 on 14-4-6.
//  Copyright (c) 2014年 chengYan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CYFileManager : NSObject

+ (id)shareInstance;

+ (NSArray *)getTxtDirectorysFinishedAbsulteUrlsArray:(NSArray **)arr;
+ (NSArray *)getTxtNamesWithDirectorPath:(NSString *)path txtAbsolutePaths:(NSArray **)paths;

- (void)loadLocalTxtFiles;
- (NSString *)getTxtPath;
@end
