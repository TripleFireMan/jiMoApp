//
//  RandomUtil.h
//  TotemHunter
//
//  Created by jack 廉洁 on 2/23/12.
//  Copyright (c) 2012 iTotem. All rights reserved.
//

#import <Foundation/Foundation.h>

#define RANDOM_SEED() srandom(time(NULL))
#define RANDOM_INT(__MIN__, __MAX__) ((__MIN__) + random() % ((__MAX__+1) - (__MIN__)))
@interface RandomUtil : NSObject

// get index by random rate like this NSArray[NSNumber(10.0),NSNumber(30.0),NSNumber(40.0),NSNumber(20.0)]
+(int)getIndexByRandomRates:(NSArray*)rates;
@end
