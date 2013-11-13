//
//  CYUsefulCFunctionSets.m
//  lottery
//
//  Created by CY on 13-11-4.
//
//

#import "CYUsefulCFunctionSets.h"


#pragma mark - animationMethod
CAKeyframeAnimation *randomBallSizeChangeAnimation()
{
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"transform.scale"];
    [animation setDuration:0.35];
    
    NSMutableArray *values = [NSMutableArray array];
    [values addObject:[NSNumber numberWithFloat:1]];
    [values addObject:[NSNumber numberWithFloat:1.2]];
    [values addObject:[NSNumber numberWithFloat:0.8]];
    [values addObject:[NSNumber numberWithFloat:1.1]];
    [values addObject:[NSNumber numberWithFloat:0.9]];
    [values addObject:[NSNumber numberWithFloat:1]];
    [animation setValues:values];
    
    return animation;
}


void animation(NSArray *array,UIView *object,NSString *keyPath)
{
    CAKeyframeAnimation*animation = [CAKeyframeAnimation animation];
    CGMutablePathRef aPath = CGPathCreateMutable();
    CGPathMoveToPoint(aPath,nil, 20, 20);
    CGPathAddCurveToPoint(aPath,nil, 160, 30, 220, 220, 240, 420);
    animation.path= aPath;
    animation.autoreverses= YES;
    animation.duration= 2;
    animation.timingFunction= [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    animation.rotationMode= @"auto";
    [object.layer addAnimation:animation forKey:keyPath];
}

NSString *stampTimeConvertToNormalTime(NSString *stampTime)
{
    NSTimeInterval seconds = [stampTime integerValue];
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:seconds];
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy-MM-dd-HH-mm-ss"];
    NSString *normalString = [formatter stringFromDate:date];
    return normalString;
}

#pragma mark -
#pragma mark uiMethods

float viewHeight(UIView *view)
{
    return view.frame.size.height;
}

float viewWidth(UIView *view)
{
    return view.frame.size.width;
}

float viewTop(UIView *view)
{
    return view.frame.origin.y;
}

float viewBottom(UIView *view)
{
    return view.frame.origin.y + viewHeight(view);
}

float viewLeft(UIView *view)
{
    return view.frame.origin.x;
}

float viewRight(UIView *view)
{
    return view.frame.origin.x + viewWidth(view);
}

void viewRemoveAllSubView(UIView *view)
{
    NSArray *subviews = [view subviews];
    for (UIView *sub in subviews) {
        [sub removeFromSuperview];
    }
}
#pragma mark -
#pragma mark mathMethods

long long factorial(int num)
{
    long long result = 1;
    while (num!=1&&num!=0) {
        result *= num;
        num--;
    }
    return result;
}

long long combination(int num1,int num2)
{
    long long result = num1;
    if (num1==num2) {
        return 1;
    }else if (num1>num2){
        long long fenmu = factorial(num2);
        long flag = num1;
        while ((num1-1)>(flag- num2)) {
            result *=(num1-1);
            num1--;
        }
        result = result/fenmu;
        return result;
    }else{
        NSLog(@"wrong combination param");
        return 0;
    }
    
}


int max(int a, int b)
{
    if (a>b) {
        return a;
    }else
        return b;
}

int min(int a, int b)
{
    if (a<b) {
        return a;
    }else
        return b;
}
NSArray *randomLotteryArray(int from, int to, int count)
{
    NSMutableArray *numberArray = [NSMutableArray array];
    for (int i = from; i <= to; i++) {
        [numberArray addObject:[NSNumber numberWithInteger:i]];
    }
    
    NSArray *sortedArray = [numberArray sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        return arc4random();
    }];
    
    NSMutableArray *resultArray = [NSMutableArray array];
    
    for (int i = 0; i < count; i++) {
        [resultArray addObject:[sortedArray objectAtIndex:i]];
    }
    
    return resultArray;
}

NSArray *sortArray(NSArray *array,BOOL isAsc)
{
    if (isAsc) {
        NSArray *sortedArray = [array sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2){
            if ([obj1 intValue] > [obj2 intValue]){
                return NSOrderedDescending;
            }
            if ([obj1 intValue] < [obj2 intValue]){
                return NSOrderedAscending;
            }
            return NSOrderedSame;
        }];
        return sortedArray;
    }else {
        NSArray *sortedArray = [array sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2){
            if ([obj1 intValue] < [obj2 intValue]){
                return NSOrderedDescending;
            }
            if ([obj1 intValue] > [obj2 intValue]){
                return NSOrderedAscending;
            }
            return NSOrderedSame;
        }];
        return sortedArray;
    }
}

float distanceBetweenTwoPoint(CGPoint p1,CGPoint p2)
{
    return sqrtf((p1.x-p2.x)*(p1.x-p2.x)+(p1.y-p2.y)*(p1.y-p2.y));
}

float degressConvertToRadian(float degress)
{
    float radian = 0.0f;
    radian = (degress * M_1_PI) / 180;
    return radian;
}

float radianConvertToDegress(float radian)
{
    float degress = 0.0f;
    degress = (radian * 180) / M_1_PI;
    return degress;
}

#pragma mark -
#pragma mark colorMethods

UIColor *rgbColor(float r,float g,float b)
{
    UIColor *color = [UIColor colorWithRed:r/255.f green:g/255.f blue:b/255.f alpha:1];
    return color;
}

UIColor *rgbaColor(float r,float g,float b,float a)
{
    UIColor *color = [UIColor colorWithRed:r/255.f green:g/255.f blue:b/255.f alpha:a];
    return color;
}

NSString *md5(NSString *aString)
{
    const char *stringNeed = [aString UTF8String];
    unsigned char results[CC_MD5_DIGEST_LENGTH];
    CC_MD5(stringNeed, strlen(stringNeed), results);
    NSMutableString *hush = [NSMutableString string];
    for (int i = 0; i< 16; i++) {
        [hush appendFormat:@"%02X", results[i]];
    }
    [hush lowercaseString];
    return hush;
}

