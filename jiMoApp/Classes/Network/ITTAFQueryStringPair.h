//
//  AFQueryStringPair.h
//  iTotemFramework
//
//  Created by Sword Zhou on 7/18/13.
//  Copyright (c) 2013 iTotemStudio. All rights reserved.
//

#import <Foundation/Foundation.h>

extern NSString * ITTAFQueryStringFromParametersWithEncoding(NSDictionary *parameters, NSStringEncoding stringEncoding);
extern NSArray * ITTAFQueryStringPairsFromDictionary(NSDictionary *dictionary);
extern NSArray * ITTAFQueryStringPairsFromKeyAndValue(NSString *key, id value);

@interface ITTAFQueryStringPair : NSObject

@property (strong, nonatomic) id field;
@property (strong, nonatomic) id value;

- (id)initWithField:(id)field value:(id)value;

- (NSString *)urlEncodedStringValueWithEncoding:(NSStringEncoding)stringEncoding;

@end
