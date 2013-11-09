//
//  ITTBaseDataRequest.h
//  
//
//  Created by lian jie on 6/22/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//
#import "ITTRequestResult.h"
#import "ITTDataCacheManager.h"
#import "ITTMaskActivityView.h"
#import "ITTNetwork.h"

typedef enum : NSUInteger{
	ITTRequestMethodGet = 0,
	ITTRequestMethodPost = 1,           // content type = @"application/x-www-form-urlencoded"
	ITTRequestMethodMultipartPost = 2   // content type = @"multipart/form-data"
} ITTRequestMethod;

@class ITTRequestDataHandler;
@class ITTBaseDataRequest;

@protocol DataRequestDelegate <NSObject>

@optional
- (void)requestDidStartLoad:(ITTBaseDataRequest*)request;
- (void)requestDidFinishLoad:(ITTBaseDataRequest*)request;
- (void)requestDidCancelLoad:(ITTBaseDataRequest*)request;
- (void)request:(ITTBaseDataRequest*)request progressChanged:(float)progress;
- (void)request:(ITTBaseDataRequest*)request didFailLoadWithError:(NSError*)error;

@end

@interface ITTBaseDataRequest : NSObject
{
    NSString    *_cancelSubject;
    NSString    *_cacheKey;
    NSString    *_filePath;
    NSDate      *_requestStartDate;
    
    BOOL        _useSilentAlert;
    BOOL        _usingCacheData;
    
    DataCacheManagerCacheType _cacheType;
    ITTMaskActivityView       *_maskActivityView;
    
    void (^_onRequestStartBlock)(ITTBaseDataRequest *);
    void (^_onRequestFinishBlock)(ITTBaseDataRequest *);
    void (^_onRequestCanceled)(ITTBaseDataRequest *);
    void (^_onRequestFailedBlock)(ITTBaseDataRequest *, NSError *);
    void (^_onRequestProgressChangedBlock)(ITTBaseDataRequest *, float);
    
    //progress related
    long long _totalData;
    long long _downloadedData;
    float     _currentProgress;
}

@property (nonatomic, assign) BOOL isLoading;
@property (nonatomic, assign) CGFloat currentProgress;
@property (nonatomic, assign) ITTParameterEncoding parmaterEncoding;
@property (nonatomic, strong) id handleredResult;
@property (nonatomic, strong) NSString *requestUrl;
@property (nonatomic, strong) NSString *rawResultString;
@property (nonatomic, strong) ITTRequestResult *result;
@property (nonatomic, strong, readonly) ITTRequestDataHandler *requestDataHandler;
@property (nonatomic, strong, readonly) NSDictionary *userInfo;

#pragma mark - init methods using delegate

#pragma mark - init methods using blocks

+ (id)requestWithParameters:(NSDictionary*)params
          withIndicatorView:(UIView*)indiView
          onRequestFinished:(void(^)(ITTBaseDataRequest *request))onFinishedBlock;

+ (id)requestWithParameters:(NSDictionary*)params
            withIndicatorView:(UIView*)indiView
            withCancelSubject:(NSString*)cancelSubject
            onRequestFinished:(void(^)(ITTBaseDataRequest *request))onFinishedBlock;

+ (id)requestWithParameters:(NSDictionary*)params
             withRequestUrl:(NSString*)url
          withIndicatorView:(UIView*)indiView
          onRequestFinished:(void(^)(ITTBaseDataRequest *request))onFinishedBlock;

+ (id)requestWithParameters:(NSDictionary*)params
          withRequestUrl:(NSString*)url
          withIndicatorView:(UIView*)indiView
          withCancelSubject:(NSString*)cancelSubject
          onRequestFinished:(void(^)(ITTBaseDataRequest *request))onFinishedBlock;

+ (id)requestWithParameters:(NSDictionary*)params
            withIndicatorView:(UIView*)indiView
            withCancelSubject:(NSString*)cancelSubject
               onRequestStart:(void(^)(ITTBaseDataRequest *request))onStartBlock
            onRequestFinished:(void(^)(ITTBaseDataRequest *request))onFinishedBlock
            onRequestCanceled:(void(^)(ITTBaseDataRequest *request))onCanceledBlock
              onRequestFailed:(void(^)(ITTBaseDataRequest *request))onFailedBlock;

+ (id)requestWithParameters:(NSDictionary*)params
          withRequestUrl:(NSString*)url
          withIndicatorView:(UIView*)indiView
          withCancelSubject:(NSString*)cancelSubject
             onRequestStart:(void(^)(ITTBaseDataRequest *request))onStartBlock
          onRequestFinished:(void(^)(ITTBaseDataRequest *request))onFinishedBlock
          onRequestCanceled:(void(^)(ITTBaseDataRequest *request))onCanceledBlock
            onRequestFailed:(void(^)(ITTBaseDataRequest *request))onFailedBlock;

- (id)initWithParameters:(NSDictionary*)params
          withRequestUrl:(NSString*)url
       withIndicatorView:(UIView*)indiView
    withLoadingMessage:(NSString*)loadingMessage
       withCancelSubject:(NSString*)cancelSubject
         withSilentAlert:(BOOL)silent
            withCacheKey:(NSString*)cache
           withCacheType:(DataCacheManagerCacheType)cacheType
            withFilePath:(NSString*)localFilePath
          onRequestStart:(void(^)(ITTBaseDataRequest *request))onStartBlock
       onRequestFinished:(void(^)(ITTBaseDataRequest *request))onFinishedBlock
       onRequestCanceled:(void(^)(ITTBaseDataRequest *request))onCanceledBlock
         onRequestFailed:(void(^)(ITTBaseDataRequest *request))onFailedBlock
       onProgressChanged:(void(^)(ITTBaseDataRequest *request, float))onProgressChangedBlock;


#pragma mark - file download related init methods 
+ (id)requestWithDelegate:(id<DataRequestDelegate>)delegate 
             withParameters:(NSDictionary*)params
          withIndicatorView:(UIView*)indiView
          withCancelSubject:(NSString*)cancelSubject
               withFilePath:(NSString*)localFilePath;

+ (id)requestWithParameters:(NSDictionary*)params
            withIndicatorView:(UIView*)indiView
            withCancelSubject:(NSString*)cancelSubject
                 withFilePath:(NSString*)localFilePath
            onRequestFinished:(void(^)(ITTBaseDataRequest *request))onFinishedBlock
            onProgressChanged:(void(^)(ITTBaseDataRequest *request,float progress))onProgressChangedBlock;

// request identifier userinfo
@property (nonatomic, strong) NSDictionary *userinfo;

- (void)notifyDelegateRequestDidErrorWithError:(NSError*)error;
- (void)notifyDelegateRequestDidSuccess;
- (void)doRelease;
- (void)processResult;
- (void)showIndicator:(BOOL)bshow;
- (void)doRequestWithParams:(NSDictionary*)params;
- (void)cancelRequest;                                     //subclass should override the method to cancel its request
- (void)showNetowrkUnavailableAlertView:(NSString*)message;

- (BOOL)onReceivedCacheData:(NSObject*)cacheData;
- (BOOL)isSuccess;
- (BOOL)handleResultString:(NSString*)resultString;
- (BOOL)processDownloadFile;

- (ITTRequestMethod)getRequestMethod;                       //default method is GET

- (NSStringEncoding)getResponseEncoding;

- (NSString*)encodeURL:(NSString *)string;
- (NSString*)getRequestUrl;
- (NSString*)getRequestHost;

- (NSDictionary*)getStaticParams;

+ (NSDictionary*)getDicFromString:(NSString*)cachedResponse;

@end
