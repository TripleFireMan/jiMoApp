//
//  CYPageViewController.h
//  jiMoApp
//
//  Created by 成焱 on 14-4-10.
//  Copyright (c) 2014年 chengYan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CYPageView.h"
//制作一个能够翻页的viewController
@interface CYPageViewController : UIViewController
{
    int currentIndex;
    BOOL fromLeft;
    BOOL tap;
    float startX;
    int nextPageIndex;
    float minMoveWidth;
}
@property(nonatomic,retain) CYPageView *visitPage;
@property(nonatomic,retain) CYPageView *prePage;
@property(nonatomic,retain) CYPageView *nextPage;
@end
