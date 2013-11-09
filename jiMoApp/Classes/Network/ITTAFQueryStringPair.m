//
//  AFQueryStringPair.m
//  iTotemFramework
//
//  Created by Sword Zhou on 7/18/13.
//  Copyright (c) 2013 iTotemStudio. All rights reserved.
//

#import "ITTAFQueryStringPair.h"
#import "NSString+ITTAdditions.h"

@implementation ITTAFQueryStringPair

@synthesize field = _field;
@synthesize value = _value;

- (id)initWithField:(id)field value:(id)value
{
    self = [super init];
    if (!self) {
        return nil;
    }
    self.field = field;
    self.value = value;
    return self;
}

- (NSString *)urlEncodedStringValueWithEncoding:(NSStringEncoding)stringEncoding
{
    if (!self.value || [self.value isEqual:[NSNull null]]) {
        return [[self.field description] encodeUrl];
    }
    else {
        return [NSString stringWithFormat:@"%@=%@", [[self.field description] encodeUrl], [[self.value description] encodeUrl]];
    }
}

@end

#pragma mark -
NSString * ITTAFQueryStringFromParametersWithEncoding(NSDictionary *parameters, NSStringEncoding stringEncoding)
{
    NSMutableArray *mutablePairs = [NSMutableArray array];
    for (ITTAFQueryStringPair *pair in ITTAFQueryStringPairsFromDictionary(parameters)) {
        [mutablePairs addObject:[pair urlEncodedStringValueWithEncoding:stringEncoding]];
    }
    return [mutablePairs componentsJoinedByString:@"&"];
}

NSArray * ITTAFQueryStringPairsFromDictionary(NSDictionary *dictionary)
{
    return ITTAFQueryStringPairsFromKeyAndValue(nil, dictionary);
}

NSArray * ITTAFQueryStringPairsFromKeyAndValue(NSString *key, id value)
{
    NSMutableArray *mutableQueryStringComponents = [NSMutableArray array];
    if (value) {
        if ([value isKindOfClass:[NSDictionary class]]) {
            NSDictionary *dictionary = value;
            // Sort dictionary keys to ensure consistent ordering in query string, which is important when deserializing potentially ambiguous sequences, such as an array of dictionaries
            NSSortDescriptor *sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"description" ascending:YES selector:@selector(caseInsensitiveCompare:)];
            for (id nestedKey in [dictionary.allKeys sortedArrayUsingDescriptors:@[ sortDescriptor ]]) {
                id nestedValue = [dictionary objectForKey:nestedKey];
                if (nestedValue) {
                    [mutableQueryStringComponents addObjectsFromArray:ITTAFQueryStringPairsFromKeyAndValue((key ? [NSString stringWithFormat:@"%@[%@]", key, nestedKey] : nestedKey), nestedValue)];
                }
            }
        }
        else if ([value isKindOfClass:[NSArray class]]) {
            NSArray *array = value;
            for (id nestedValue in array) {
                [mutableQueryStringComponents addObjectsFromArray:ITTAFQueryStringPairsFromKeyAndValue([NSString stringWithFormat:@"%@[]", key], nestedValue)];
            }
        }
        else if ([value isKindOfClass:[NSSet class]]) {
            NSSet *set = value;
            for (id obj in set) {
                [mutableQueryStringComponents addObjectsFromArray:ITTAFQueryStringPairsFromKeyAndValue(key, obj)];
            }
        }
        else {
            ITTAFQueryStringPair *pair = [[ITTAFQueryStringPair alloc] initWithField:key value:value];
            [mutableQueryStringComponents addObject:pair];
        }
    }
    return mutableQueryStringComponents;
}
