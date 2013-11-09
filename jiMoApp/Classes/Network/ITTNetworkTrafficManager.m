//
//  ITTNetworkTrafficManager.m
//  AiQiChe
//
//  Created by lian jie on 9/1/11.
//  Copyright 2011 iTotem. All rights reserved.
//
// modified by sword on 1/23/2013

#import "ITTNetworkTrafficManager.h"
#import "ITTObjectSingleton.h"
#import "Reachability.h"

#define SHOULD_LOG_TRAFFIC_DATA YES

@interface ITTNetworkTrafficManager()
{
    BOOL        _isUsing3GNetwork;
    BOOL        _isAlert;
    double      _wifiInBytes;
    double      _wifiOutBytes;
    double      _3gInBytes;
    double      _3gOutBytes;
    double      _2gInBytes;
    double      _2gOutBytes;
    int         _resetDayInMonth;
    int         _max3gMegaBytes;     // this is MB not byte
    
    NetworkStatus _networkStatus;
    
    NSDate      *_lastAlertTime;
    NSDate      *_lastResetDate;
    
    Reachability *_reachability;
}

- (void)restore;
- (void)initTrafficData;

- (double)getMegabytesFromBytes:(int)bytes;

@end

@implementation ITTNetworkTrafficManager

@synthesize networkType = _networkType;

ITTOBJECT_SINGLETON_BOILERPLATE(ITTNetworkTrafficManager, sharedManager)

- (id)init
{
    self = [super init];
	if (self) {
		[self restore];
	}
	return self;
}


#pragma mark - private methods
- (void)initTrafficData
{
    NSUserDefaults *userinfo = [NSUserDefaults standardUserDefaults];
    _max3gMegaBytes = [[userinfo objectForKey:ITT_NETWORK_TRAFFIC_MAX_3G] intValue];
    if (!_max3gMegaBytes) {
        _wifiInBytes = 0;
        _wifiOutBytes = 0;
        _2gInBytes = 0;
        _2gOutBytes = 0;
        _3gInBytes = 0;
        _3gOutBytes = 0;
        _resetDayInMonth = 1;
        _max3gMegaBytes = 999;
    }
    else {
        _wifiInBytes = [[userinfo objectForKey:ITT_NETWORK_TRAFFIC_WIFI_IN] doubleValue];
        _wifiOutBytes = [[userinfo objectForKey:ITT_NETWORK_TRAFFIC_WIFI_OUT] doubleValue];
        _3gInBytes = [[userinfo objectForKey:ITT_NETWORK_TRAFFIC_GPRS_3G_IN] doubleValue];
        _3gOutBytes = [[userinfo objectForKey:ITT_NETWORK_TRAFFIC_GPRS_3G_OUT] doubleValue];
        _2gInBytes = [[userinfo objectForKey:ITT_NETWORK_TRAFFIC_GPRS_2G_IN] doubleValue];
        _2gOutBytes = [[userinfo objectForKey:ITT_NETWORK_TRAFFIC_GPRS_2G_OUT] doubleValue];
        _resetDayInMonth = [[userinfo objectForKey:ITT_NETWORK_TRAFFIC_RESET_DAY_IN_MONTH] intValue];
        _max3gMegaBytes = [[userinfo objectForKey:ITT_NETWORK_TRAFFIC_MAX_3G] intValue];
    }
    _lastResetDate =(NSDate*)[userinfo objectForKey:ITT_NETWORK_TRAFFIC_LAST_RESET_DATE];
    _isAlert = [userinfo boolForKey:ITT_NETWORK_TRAFFIC_IS_ALERT]; 
    [self checkIsResetDay];
}

- (void) networkStateDidChanged:(NSNotification*)n
{
    ITTDINFO(@"networkStateDidChanged");
    Reachability* curReach = [n object];
    NSParameterAssert([curReach isKindOfClass: [Reachability class]]);
    [self updateNetwordStatus:curReach.currentReachabilityStatus];
}

- (void) updateNetwordStatus:(NetworkStatus)status
{
    _isUsing3GNetwork = FALSE;
    switch (status)
    {
        case ReachableViaWiFi:
            _networkType = @"wifi";
            break;
        case ReachableVia3G:
            _networkType = @"3g";
            _isUsing3GNetwork = TRUE;            
            break;
        case ReachableVia2G:
            _networkType = @"2g";
            break;
        case NotReachable:
            _networkType = @"unavailable";
            break;
        default:
            _networkType = @"unknown";
            break;
    }
    ITTDINFO(@"network status %@", _networkType);
}

- (void)restore
{
    _networkStatus = ReachableViaWiFi;
    _lastAlertTime = nil;
    [self initTrafficData];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(networkStateDidChanged:) name:kReachabilityChangedNotification object:nil];
    _reachability = [Reachability reachabilityForInternetConnection];
    [self updateNetwordStatus:_reachability.currentReachabilityStatus];
    [_reachability startNotifier];    
}

-(void)checkIsResetDay
{
    //得到当前的日期
    
    NSDate *date = [NSDate date];
    NSDate *nextResetDate =(NSDate*)[[NSUserDefaults standardUserDefaults] objectForKey:ITT_NETWORK_TRAFFIC_NEXT_RESET_DATE];
    if (!nextResetDate||[nextResetDate timeIntervalSinceNow] < 0) {
        [self resetData];
    }
    
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *comps = [calendar components:NSDayCalendarUnit fromDate:date];
    NSInteger day = [comps day];
    
    NSInteger nextResetMoth = comps.month;
    NSInteger nextResetYear = comps.year;
    NSInteger nextResetDay = _resetDayInMonth;
    
    if (day>_resetDayInMonth) {
        nextResetMoth +=1;
        if (nextResetMoth>12) {
            nextResetMoth-=12;
            nextResetYear+=1;
        }
    }
    [comps setDay:nextResetDay];
    [comps setMonth:nextResetMoth];
    [comps setYear:nextResetYear];
    
    nextResetDate = [calendar dateFromComponents:comps];
    [[NSUserDefaults standardUserDefaults] setObject:nextResetDate forKey:ITT_NETWORK_TRAFFIC_NEXT_RESET_DATE];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (double)getMegabytesFromBytes:(int)bytes
{
    return (bytes * 1.0/1000)/1000;
}

#pragma mark - public methods
- (void)doSave
{
    NSUserDefaults *userinfo = [NSUserDefaults standardUserDefaults];
    [userinfo setObject:@(_wifiInBytes) forKey:ITT_NETWORK_TRAFFIC_WIFI_IN];
    [userinfo setObject:@(_wifiOutBytes) forKey:ITT_NETWORK_TRAFFIC_WIFI_OUT];
    [userinfo setObject:@(_3gInBytes) forKey:ITT_NETWORK_TRAFFIC_GPRS_3G_IN];
    [userinfo setObject:@(_3gOutBytes) forKey:ITT_NETWORK_TRAFFIC_GPRS_3G_OUT];
    [userinfo setObject:@(_2gInBytes) forKey:ITT_NETWORK_TRAFFIC_GPRS_2G_IN];
    [userinfo setObject:@(_2gOutBytes) forKey:ITT_NETWORK_TRAFFIC_GPRS_2G_OUT];
    [userinfo setObject:@(_resetDayInMonth) forKey:ITT_NETWORK_TRAFFIC_RESET_DAY_IN_MONTH];
    [userinfo setObject:@(_max3gMegaBytes) forKey:ITT_NETWORK_TRAFFIC_MAX_3G];
    [userinfo synchronize];
}

// log traffic
- (void)logTrafficIn:(unsigned long long)bytes
{
    NSUserDefaults *userinfo = [NSUserDefaults standardUserDefaults];
    switch (_networkStatus) {
        case ReachableVia2G:
            _2gInBytes = _2gInBytes + bytes;
            [userinfo setObject:@(_2gInBytes) forKey:ITT_NETWORK_TRAFFIC_GPRS_2G_IN];
            [userinfo synchronize];
            if (SHOULD_LOG_TRAFFIC_DATA) {
                ITTDINFO(@"2g trafic in :%lf bytes", _2gInBytes);
            }
            break;
        case ReachableVia3G:
            _3gInBytes = _3gInBytes + bytes;
            [userinfo setObject:@(_3gInBytes) forKey:ITT_NETWORK_TRAFFIC_GPRS_3G_IN];
            [userinfo synchronize];
            if (SHOULD_LOG_TRAFFIC_DATA) {
                ITTDINFO(@"3g trafic in :%lf bytes", _3gInBytes);
            }
            break;
        case ReachableViaWiFi:
            _wifiInBytes = _wifiInBytes + bytes;
            [userinfo setObject:@(_wifiInBytes) forKey:ITT_NETWORK_TRAFFIC_WIFI_IN];
            [userinfo synchronize];
            if (SHOULD_LOG_TRAFFIC_DATA) {
                ITTDINFO(@"wifi trafic in :%lf bytes", _wifiInBytes);
            }
            break;
        default:
            break;
    }
    if ([self hasExceedMax3GTraffic]) {
        NSDate *now = [NSDate date];
        BOOL shouldShowAlert = NO;
        if (!_lastAlertTime || [now timeIntervalSinceDate:_lastAlertTime]/100 > ITT_NETWORK_TRAFFIC_MAX_3G_ALERT_INTERVAL) {
            shouldShowAlert = YES;
        }
        if (shouldShowAlert) {
            NSString *alertMsg = [NSString stringWithFormat:@"您目前的GPRS/3g流量(%4.2fM)已超过您所设定的上限(%dM)",[self get3GTraffic],[self getMax3GTraffic] ];
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"流量提示" 
                                                             message:alertMsg
                                                            delegate:nil 
                                                   cancelButtonTitle:@"知道了" 
                                                   otherButtonTitles:nil];
            [alert show];
            _lastAlertTime = now;
        }
    }
}

- (void)logTrafficOut:(unsigned long long)bytes
{
    NSUserDefaults *userinfo = [NSUserDefaults standardUserDefaults];
    switch (_networkStatus) {
        case ReachableVia2G:
            _2gOutBytes = _2gOutBytes + bytes;
            [userinfo setObject:@(_2gOutBytes) forKey:ITT_NETWORK_TRAFFIC_GPRS_2G_OUT];
            [userinfo synchronize];
            if (SHOULD_LOG_TRAFFIC_DATA) {
                ITTDINFO(@"2g trafic in :%lf bytes", _2gInBytes);
            }
            break;
        case ReachableVia3G:
            _3gOutBytes = _3gOutBytes + bytes;
            [userinfo setObject:@(_3gOutBytes) forKey:ITT_NETWORK_TRAFFIC_GPRS_3G_OUT];
            [userinfo synchronize];
            if (SHOULD_LOG_TRAFFIC_DATA) {
                ITTDINFO(@"3g trafic in :%lf bytes", _3gInBytes);
            }
            break;
        case ReachableViaWiFi:
            _wifiOutBytes = _wifiOutBytes + bytes;
            [userinfo setObject:@(_wifiOutBytes) forKey:ITT_NETWORK_TRAFFIC_WIFI_OUT];
            [userinfo synchronize];
            if (SHOULD_LOG_TRAFFIC_DATA) {
                ITTDINFO(@"wifi trafic in :%lf bytes", _wifiInBytes);
            }
            break;
        default:
            break;
    }
}

// set /get reset data date
- (void)setTrafficResetDay:(int)dayInMonth
{
    _resetDayInMonth = dayInMonth;
    NSUserDefaults *userinfo = [NSUserDefaults standardUserDefaults];
    [userinfo setObject:@(_resetDayInMonth) forKey:ITT_NETWORK_TRAFFIC_RESET_DAY_IN_MONTH];    
    [userinfo synchronize];    
}

- (int)getTrafficResetDay
{
    return _resetDayInMonth;
}

// alert user
- (void)setMax3GTraffic:(int)megabyte
{
    _max3gMegaBytes = megabyte;
    NSUserDefaults *userinfo = [NSUserDefaults standardUserDefaults];
    [userinfo setObject:@(_max3gMegaBytes) forKey:ITT_NETWORK_TRAFFIC_MAX_3G];
    [userinfo synchronize];    
}

- (int)getMax3GTraffic
{
    return _max3gMegaBytes;
}

- (BOOL)hasExceedMax3GTraffic
{
    if (_max3gMegaBytes <= 0 || !_isAlert) {
        return NO;
    }
    else{
        return ([self get3GTraffic] > _max3gMegaBytes) ;
    }
}

-(void)setAlertStatus:(BOOL)isAlert
{
    NSUserDefaults *userinfo = [NSUserDefaults standardUserDefaults];
    [userinfo setObject: [NSNumber numberWithInt:isAlert] forKey:ITT_NETWORK_TRAFFIC_IS_ALERT];
    [userinfo synchronize];
    _isAlert = isAlert;
}

-(BOOL)getAlertStatus
{
    return _isAlert;
}

// reset
- (void)resetData
{
    _2gInBytes = 0;
    _2gOutBytes = 0;
    _wifiInBytes = 0;
    _wifiOutBytes = 0;
    _3gOutBytes = 0;
    _3gInBytes = 0;
    [[NSUserDefaults standardUserDefaults] setObject:[NSDate date] forKey:ITT_NETWORK_TRAFFIC_LAST_RESET_DATE];
    [self doSave];
}

// get traffic data, return megabytes
- (double)get3GTrafficIn
{
    return [self getMegabytesFromBytes:_3gInBytes];
}

- (double)get3GTrafficOut
{
    return [self getMegabytesFromBytes:_3gOutBytes];
}

- (double)get3GTraffic
{
    return [self getMegabytesFromBytes:(_3gInBytes + _3gOutBytes)];
}

// get traffic data, return megabytes
- (double)get2GTrafficIn
{
    return [self getMegabytesFromBytes:_2gInBytes];
}

- (double)get2GTrafficOut
{
    return [self getMegabytesFromBytes:_2gOutBytes];
}

- (double)get2GTraffic
{
    return [self getMegabytesFromBytes:(_2gInBytes + _2gOutBytes)];
}

- (double)getWifiTrafficIn
{
    return [self getMegabytesFromBytes:_wifiInBytes];
}

- (double)getWifiTrafficOut
{
    return [self getMegabytesFromBytes:_wifiOutBytes];
}

- (double)getWifiTraffic
{
    return [self getMegabytesFromBytes:(_wifiInBytes + _wifiOutBytes)];
}

// for debug
- (void)consoleDeviceNetworkTrafficInfo
{
    ITTDINFO(@"==============current network traffic=============\n");
    ITTDINFO(@"2g in:%fmb", [self get2GTrafficIn]);
    ITTDINFO(@"2g out:%fmb", [self get2GTrafficOut]);
    ITTDINFO(@"2g total:%fmb", [self get2GTraffic]);
    ITTDINFO(@"3g in:%fmb", [self get3GTrafficIn]);
    ITTDINFO(@"3g out:%fmb", [self get3GTrafficOut]);
    ITTDINFO(@"3g total:%fmb", [self get3GTraffic]);
    ITTDINFO(@"wifi in:%fmb", [self getWifiTrafficIn]);
    ITTDINFO(@"wifi out:%fmb", [self getWifiTrafficOut]);
    ITTDINFO(@"wifi total:%fmb", [self getWifiTraffic]);
    ITTDINFO(@"==================================================\n");
}
@end
