//
//  ITTBaseManager.m
//  GuanJiaoTong
//
//  Created by xiaogang meng on 6/26/12.
//  Copyright (c) 2012 itotem. All rights reserved.
//

#import "ITTBaseManager.h"

@interface ITTBaseManager()
{
    NSMutableDictionary *_stateDictionary;
    NSMutableArray      *_dataResultArray;
    NSInteger           _currentRequestPage;
    kRefreshType        _kRefreshType;
}
@end

@implementation ITTBaseManager

- (id)init
{
    self  = [super init];
    if (self) {
        _currentRequestPage = 0;
        _kRefreshType = kRefreshTypeNone;
        _stateDictionary = [[NSMutableDictionary alloc] init];
        _dataResultArray = [NSMutableArray array];
    }
    return self;
}

- (void)updatePageIndexWithResultCount:(NSInteger)resultCount pageSize:(NSInteger)pageSize
{
    if (pageSize >= resultCount) {
        _currentRequestPage++;
    }
}

- (void)addObjectsFromArray:(NSArray *)resultsArray
{
    SHOULDOVERRIDE(@"ITTBaseManager", NSStringFromClass([self class]));
}

- (void)addObjectWithIdentifier:(id)object identifier:(NSString*)identifier
{
    if (identifier) {
        _stateDictionary[identifier] = @"1";        
    }
    if (object) {
        [_dataResultArray addObject:object];        
    }
}

- (void)removeObjectWithIdentifier:(id)object identifier:(NSString *)identifier
{
    if (identifier) {
        [_stateDictionary removeObjectForKey:identifier];
    }    
    if (object) {
        [_dataResultArray removeObject:object];
    }
}

- (NSString *)getPageIndex
{
    NSString *pageIndex = nil;
    if (_kRefreshType == kRefreshTypeUp) {
        pageIndex = [NSString stringWithFormat:@"%d", _currentRequestPage];
    }
    else {
        pageIndex = @"0";
    }
    return pageIndex;
}

- (void)removeAllObjects
{
    [_stateDictionary removeAllObjects];
    [_dataResultArray removeAllObjects];
    _currentRequestPage = 0;
    _kRefreshType = kRefreshTypeNone;
}

- (void)removeStateWithIdentifier:(NSString *)identifier
{
    [_stateDictionary removeObjectForKey:identifier];
}

- (BOOL)containsObject:(NSString*)identifier
{
    return (nil != _stateDictionary[identifier]);
}

- (id)objectAtIndex:(NSInteger)index
{
    id object = nil;
    if (index >= 0 && index < [_dataResultArray count]) {
        object = _dataResultArray[index];
    }
    return object;
}

- (int)count
{
    return _dataResultArray.count;
}

@end
