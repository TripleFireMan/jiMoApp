//
//  ITTNetworkTrafficManager.h
//  AiQiChe
//
//  Created by lian jie on 9/1/11.
//  Copyright 2011 iTotem. All rights reserved.
//

#import <Foundation/Foundation.h>

#define ITT_NETWORK_TRAFFIC_GPRS_3G_OUT @"3gOut"
#define ITT_NETWORK_TRAFFIC_GPRS_3G_IN @"3gIn"
#define ITT_NETWORK_TRAFFIC_GPRS_2G_OUT @"2gOut"
#define ITT_NETWORK_TRAFFIC_GPRS_2G_IN @"2gIn"
#define ITT_NETWORK_TRAFFIC_WIFI_OUT @"wifiOut"
#define ITT_NETWORK_TRAFFIC_WIFI_IN @"wifiIn"
#define ITT_NETWORK_TRAFFIC_RESET_DAY_IN_MONTH @"resetDate"    //数据归零日
#define ITT_NETWORK_TRAFFIC_LAST_RESET_DATE @"lastResetData"// 上次数据归零时间
#define ITT_NETWORK_TRAFFIC_NEXT_RESET_DATE @"nextResetData"// 上次数据归零时间
#define ITT_NETWORK_TRAFFIC_MAX_3G @"max3gTraffic"
#define ITT_NETWORK_TRAFFIC_MAX_3G_ALERT_INTERVAL 10 * 60      //流量提示间隔时间
#define ITT_NETWORK_TRAFFIC_IS_ALERT @"trafficIsAlert" // 是否提醒流量

@interface ITTNetworkTrafficManager : NSObject
{

}
@property (nonatomic, strong) NSString *networkType;
@property (nonatomic, assign) BOOL isUsing3GNetwork;

+ (ITTNetworkTrafficManager *)sharedManager;

// log traffic
- (void)logTrafficIn:(unsigned long long)bytes;
- (void)logTrafficOut:(unsigned long long)bytes;

// set /get reset data date
- (void)setTrafficResetDay:(int)dayInMonth;
- (int)getTrafficResetDay;

// alert user
- (void)setMax3GTraffic:(int)megabyte;
- (int)getMax3GTraffic;
- (BOOL)hasExceedMax3GTraffic;

// reset
-(void)resetData;
-(void)checkIsResetDay;

- (double)get2GTrafficIn;
- (double)get2GTrafficOut;
- (double)get2GTraffic;

// get traffic data, return megabytes
- (double)get3GTrafficIn;
- (double)get3GTrafficOut;
- (double)get3GTraffic;

- (double)getWifiTrafficIn;
- (double)getWifiTrafficOut;
- (double)getWifiTraffic;

// for debug
- (void)consoleDeviceNetworkTrafficInfo;

-(void)setAlertStatus:(BOOL)isAlert;
-(BOOL)getAlertStatus;
@end
