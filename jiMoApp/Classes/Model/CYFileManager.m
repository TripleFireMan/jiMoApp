//
//  CYFileManager.m
//  jiMoApp
//
//  Created by 成焱 on 14-4-6.
//  Copyright (c) 2014年 chengYan. All rights reserved.
//

#import "CYFileManager.h"
#import "ITTGobalPaths.h"
#import "ITTObjectSingleton.h"
#import "CommonUtils.h"
@implementation CYFileManager

ITTOBJECT_SINGLETON_BOILERPLATE(CYFileManager, shareInstance)

- (id)init
{
    self = [super init];
    if (self) {
    }
    return self;
}

- (NSString *)getTxtPath
{
    if (![ITTPathForDocumentsResource(@"txt")isEmptyOrNull]) {
        return ITTPathForDocumentsResource(@"txt");
    }else{
        return @"";
    }
}
- (void)loadLocalTxtFiles
{
    NSString *txtPath = [DOCUMENT_PATH stringByAppendingPathComponent:@"txt"];
    if ([FILE_MANAGER fileExistsAtPath:txtPath]==NO) {
        
        dispatch_queue_t localFilesQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
        dispatch_queue_t mainQueue = dispatch_get_main_queue();
        void (^willLoadFiles)(void) =^(void){
            NSLog(@"willloadFiles");
        };
        void (^didLoadFiled)(void) = ^(void){
            NSLog(@"didLoadFiles");
        };
        void (^loadFiles)(void)= ^(void){
            dispatch_sync(mainQueue, willLoadFiles);
            [CommonUtils createDirectorysAtPath:txtPath];
            NSArray *directorys = [NSArray arrayWithObjects:@"小说",@"社会",@"科普",@"管理",@"纪实", nil];
            NSMutableArray *directoryPaths = [[NSMutableArray alloc]initWithCapacity:6];
            NSMutableArray *localTxtFileNames = [NSMutableArray arrayWithObjects:@"狄仁杰断案传奇",@"反骗指南",@"智能简史",@"辩驳诡辩的方法与技巧",@"李小龙的功夫人生",nil];
            NSMutableArray *localTxt = [[NSMutableArray alloc]initWithCapacity:6];
            
            
            for (NSString *obj in localTxtFileNames) {
                NSString *txtPath = [[NSBundle mainBundle]pathForResource:obj ofType:@"txt"];
                NSString *txt = [NSString stringWithContentsOfFile:txtPath encoding:NSUTF8StringEncoding error:nil] ;
                if (!txt) {
                    txt = [NSString stringWithContentsOfFile:txtPath encoding:0x80000632 error:nil];
                }
                if (!txt) {
                    txt = [NSString stringWithContentsOfFile:txtPath encoding:0x80000631 error:nil];
                }
                [localTxt addObject:txt];
            }
            
            [directorys enumerateObjectsUsingBlock:^(id obj,NSUInteger index,BOOL *stop){
                obj = [NSString stringWithFormat:@"%@/%@",txtPath,obj];
                [directoryPaths addObject:obj];
            }];
            
            if ([FILE_MANAGER fileExistsAtPath:[txtPath stringByAppendingPathComponent:@"Inbox"]]==NO) {
                [CommonUtils createDirectorysAtPath:[txtPath stringByAppendingPathComponent:@"Inbox"]];
            }
            
            [directoryPaths enumerateObjectsUsingBlock:^(id obj,NSUInteger index,BOOL *stop){
                if ([FILE_MANAGER fileExistsAtPath:obj]==NO) {
                    [CommonUtils createDirectorysAtPath:obj];
                    NSString *txt = [localTxt objectAtIndex:index];
                    NSString *abslouteTxtName = [[obj stringByAppendingPathComponent:localTxtFileNames[index]]stringByAppendingString:@".txt"];
                    [txt writeToFile:abslouteTxtName atomically:YES encoding:NSUTF8StringEncoding error:nil];
                }
            }];
            dispatch_sync(mainQueue, didLoadFiled);
        };
        dispatch_async(localFilesQueue, loadFiles);
    }
}

+ (NSArray *)getTxtDirectorysFinishedAbsulteUrlsArray:(NSArray **)arr
{
    NSError *error = nil;
    NSArray *contents = [FILE_MANAGER contentsOfDirectoryAtPath:[[CYFileManager shareInstance] getTxtPath] error:&error];//获取到的就是该路径下的子路径的名称
    NSMutableArray *absluteUrl = [NSMutableArray array];
    for (NSString *subFileUrl in contents) {
        [absluteUrl addObject:[[[CYFileManager shareInstance] getTxtPath] stringByAppendingPathComponent:subFileUrl]];
    }
    if (arr!=nil) {
         *arr = absluteUrl;
    }
    return contents;
}

+ (NSArray *)getTxtNamesWithDirectorPath:(NSString *)path txtAbsolutePaths:(NSArray **)paths
{
    NSError *error = nil;
    NSArray *contents = [FILE_MANAGER contentsOfDirectoryAtPath:path error:&error];
    if ([contents count]!=0) {
        NSMutableArray *absluteUrl = [NSMutableArray array];
        for (NSString *subFileUrl in contents) {
            [absluteUrl addObject:[path stringByAppendingPathComponent:subFileUrl]];
        }
        if (paths!=nil) {
            *paths = absluteUrl;
        }
        return contents;
    }else
        return nil;
}
@end
