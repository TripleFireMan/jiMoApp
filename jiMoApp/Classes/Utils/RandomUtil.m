//
//  RandomUtil.m
//  TotemHunter
//
//  Created by jack 廉洁 on 2/23/12.
//  Copyright (c) 2012 iTotem. All rights reserved.
//

#import "RandomUtil.h"

@implementation RandomUtil

// get index by random rate like this NSArray[NSNumber(10.0),NSNumber(30.0),NSNumber(40.0),NSNumber(20.0)]
+(int)getIndexByRandomRates:(NSArray*)rates
{
    RANDOM_SEED();
    int maxValue = 0;
    for (NSNumber *rate in rates) {
        maxValue = maxValue + [rate intValue];
    }
    if (maxValue < 1) {
        maxValue = 1; 
    }
    int rateValue = RANDOM_INT(1, maxValue);
    int startValue = 0;
    int endValue = 0;
    int resultIndex = -1;
    for (NSNumber *rate in rates) {
        resultIndex = resultIndex + 1;
        if ([rate intValue] == 0) {
            // skip when rate is 0
            continue;
        }
        endValue = startValue + [rate intValue];
        if (rateValue > startValue && rateValue <= endValue) {
            //this is the generated chip;
            return resultIndex;
        }
        startValue = endValue;
    }
    return resultIndex;

}
@end
