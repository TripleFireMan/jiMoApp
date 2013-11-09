//
//  Car.m
//  iTotemFrame
//
//  Created by Rainbow Zhang on 12/27/11.
//  Copyright (c) 2011 iTotemStudio. All rights reserved.
//

#import "DemoModel.h"

@implementation DemoModel



- (id)init
{
    self = [super init];
    if (self) {
        self.models = [NSMutableArray array];
    }
    return self;
}


/**
    Key-Value pair by dictionary key name and property name.
    key:    property name
    value:  dictionary key name
 **/
- (NSDictionary*)attributeMapDictionary
{
	return @{@"modelId": @"id"
            ,@"name": @"name"
            ,@"models": @"models"};
}

@end
