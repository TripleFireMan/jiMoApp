//
//  CYUsefulCFunctionSets.h
//  lottery
//
//  Created by CY on 13-11-4.
//
//

#import <Foundation/Foundation.h>
#import <CommonCrypto/CommonDigest.h>
#include <ifaddrs.h>
#include <arpa/inet.h>
#import <mach/mach.h>
#import <mach/mach_host.h>

#pragma mark -
#pragma mark animations
/*随机选球的时候，球的动画*/
extern CAKeyframeAnimation *randomBallSizeChangeAnimation();
/*关键帧动画*/
extern void cyKeyFrameAnimation(NSArray *array,UIView *object,NSString *keyPath);

#pragma mark - 
#pragma mark NSStringExpandMethods

/*timestamp类型的字符串转换为普通显示的字符串*/
extern NSString *stampTimeConvertToNormalTime(NSString *stampTime);
/*****md5加密******/
extern NSString *md5(NSString *aString);
/*小写的26个字母*/
extern NSArray *lowerLetters();
/*大写的26个字母*/
extern NSArray *upperLetters();

#pragma mark -
#pragma mark uiMethods

/*高度*/
extern float viewHeight(UIView *view);
/*宽度*/
extern float viewWidth(UIView *view);
/*顶点*/
extern float viewTop(UIView *view);
/*最低点*/
extern float viewBottom(UIView *view);
/*左边*/
extern float viewLeft(UIView *view);
/*右边*/
extern float viewRight(UIView *view);
/*移除所有子视图*/
extern void viewRemoveAllSubViews(UIView *view);

#pragma mark -
#pragma mark mathMethods

/*阶乘*/
extern long long factorial(int num);
/*组合*/
extern long long combination(int num1,int num2);
/*求大数*/
extern int max(int a, int b);
/*求小数*/
extern int min(int a, int b);
/*求取从1-N之间的随机数，随机个数可以指定*/
extern NSArray *randomLotteryArray(int from, int to, int count);
/*数组排序,仅适用于int类型数字排序,yes的时候是升序，no的时候是降序*/
extern NSArray *sortArray(NSArray *array,BOOL isAsc);
/*计算俩点之间距离的公式*/
extern float distanceBetweenTwoPoint(CGPoint p1,CGPoint p2);
/*角度转换为弧度的函数*/
extern float degressConvertToRadian(float degress);
/*弧度转换为角度的函数*/
extern float radianConvertToDegress(float radian);

#pragma mark -
#pragma mark colorMethods

/*RGB颜色*/
extern UIColor *rgbColor(float r,float g, float b);
/*RGBA颜色*/
extern UIColor *rgbaColor(float r,float g,float b,float a);

#pragma mark -
#pragma mark UIDevice relates

/*ip地址*/
extern NSString *ipAddress();
/*剩余内存*/
extern NSString *freeMemory();
/*已使用的空间*/
extern NSString *diskUsed();






