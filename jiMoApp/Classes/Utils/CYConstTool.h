//
//  CYConstTool.h
//  iTotemMinFramework
//
//  Created by CY on 13-10-29.
//
//

#import <Foundation/Foundation.h>

#define cyPrint(x)              NSLog(@"%@ = %@",@"x",x);
#define cyPrintCGRectFrame(x)   NSLog(@"%@ = %@",(x), NSStringFromCGRect(x.frame));
#define cyPrintCGRectBounds(x)  NSLog(@"%@ = %@",(x), NSStringFromCGRect(x.bounds));
#define cyPrintCGPoint(x)       NSLog(@"%@%@",@"该点坐标为:", NSStringFromCGPoint(x));

/*set enum*/
/*play kind*/
typedef NS_ENUM(NSInteger, CustomScrollerPlayKind)
{
    CustomScrollerPlayKindDoubleBall = 1<<1,
    CustomScrollerPlayKindShenFengCai = 1<<2,
    CustomScrollerPlayKindThreeD = 1<<3,
    CustomScrollerPlayKindSevenLeTou = 1<<4,
};

/*play type*/
typedef NS_ENUM(NSInteger, CustomScrollerPlayType)
{
    CustomScrollerPlayTypeNormal = 100,
    CustomScrollerPlayTypeDanTuo,
};

//全局的信息打印
extern NSString const *cyLoadingMsg;
extern NSString const *cyLoadedErrorNetWorkMsg;
extern NSString const *cyLoadedTimeOutMsg;
extern NSString const *cyLoadedNoMoreDataMsg;
extern NSString const *cyLoadedEmptyDataMsg;

