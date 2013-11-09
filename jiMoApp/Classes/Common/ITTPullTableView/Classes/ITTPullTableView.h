//
//  PullTableView.h
//  TableViewPull
//
//  Created by Emre Ergenekon on 2011-07-30.
//  Copyright 2011 Kungliga Tekniska Högskolan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ITTMessageInterceptor.h"
#import "ITTRefreshTableHeaderView.h"
#import "ITTLoadMoreTableFooterView.h"

@class ITTPullTableView;
@protocol ITTPullTableViewDelegate <NSObject>

/* After one of the delegate methods is invoked a loading animation is started, to end it use the respective status update property */
- (void)pullTableViewDidTriggerRefresh:(ITTPullTableView*)pullTableView;
- (void)pullTableViewDidTriggerLoadMore:(ITTPullTableView*)pullTableView;

@end


@interface ITTPullTableView : UITableView <ITTRefreshTableHeaderDelegate, ITTLoadMoreTableFooterDelegate>
{
    
    ITTRefreshTableHeaderView *refreshView;
    ITTLoadMoreTableFooterView *loadMoreView;
    
    // Since we use the contentInsets to manipulate the view we need to store the the content insets originally specified.
    UIEdgeInsets realContentInsets;
    
    // For intercepting the scrollView delegate messages.
    ITTMessageInterceptor * delegateInterceptor;
    
    // Config
    UIImage *pullArrowImage;
    UIColor *pullBackgroundColor;
    UIColor *pullTextColor;
    NSDate *pullLastRefreshDate;
    
    // Status
    BOOL pullTableIsRefreshing;
    BOOL pullTableIsLoadingMore;
    
    // Delegate
//    id<ITTPullTableViewDelegate> pullDelegate;
}

/* The configurable display properties of PullTableView. Set to nil for default values */
@property (nonatomic, strong) UIImage *pullArrowImage;
@property (nonatomic, strong) UIColor *pullBackgroundColor;
@property (nonatomic, strong) UIColor *pullTextColor;

/* Set to nil to hide last modified text */
@property (nonatomic, strong) NSDate *pullLastRefreshDate;

/* Properties to set the status of the refresh/loadMore operations. */
/* After the delegate methods are triggered the respective properties are automatically set to YES. After a refresh/reload is done it is necessary to set the respective property to NO, otherwise the animation won't disappear. You can also set the properties manually to YES to show the animations. */
@property (nonatomic, assign) BOOL pullTableIsRefreshing;
@property (nonatomic, assign) BOOL pullTableIsLoadingMore;

/* Delegate */
@property (nonatomic, weak) IBOutlet id<ITTPullTableViewDelegate> pullDelegate;

- (void)setLoadMoreViewHidden:(BOOL)isHidden;
- (void)setRefreshViewHidden:(BOOL)isHidden;

@end
