//
//  ITTBaseManager.h
//  GuanJiaoTong
//
//  Created by xiaogang meng on 6/26/12.
//  Copyright (c) 2012 itotem. All rights reserved.
//  Modified by Sword on 8/20/2013
//

#import <Foundation/Foundation.h>
#define PAGE_SIZE_NUBMER       20

typedef enum
{
    kRefreshTypeNone = 0,
    kRefreshTypeUp,
    kRefreshTypeDown
} kRefreshType;

@interface ITTBaseManager : NSObject
{
}

@property(nonatomic, strong) NSMutableArray *dataResultArray;
@property(nonatomic, assign) kRefreshType kRefreshType;
@property(nonatomic, assign) NSInteger currentRequestPage;

- (void)addObjectsFromArray:(NSArray *)resultsArray;
- (void)addObjectWithIdentifier:(id)object identifier:(NSString*)identifier;
- (void)removeObjectWithIdentifier:(id) object identifier:(NSString *)identifier;
- (void)removeAllObjects;
- (void)updatePageIndexWithResultCount:(NSInteger)resultCount pageSize:(NSInteger)pageSize;

- (id)objectAtIndex:(NSInteger)index;
- (BOOL)containsObject:(NSString*)identifier;

- (NSInteger)count;

- (NSString *)getPageIndex;//加载页数

@end
