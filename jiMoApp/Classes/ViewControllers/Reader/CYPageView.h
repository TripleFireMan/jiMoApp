//
//  CYPageView.h
//  jiMoApp
//
//  Created by 成焱 on 14-4-10.
//  Copyright (c) 2014年 chengYan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

typedef void(^DidFinishedMove)(void);

@interface CYPageView : UIView
@property (nonatomic, strong) UILabel *txtLabel;
@property (nonatomic, strong) UIView *txtView;
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UIView *imageParentView;
@property (nonatomic, retain) CAGradientLayer *ShadowLayer;
//设置一个动画结束的回调方法
@property (nonatomic, copy) DidFinishedMove finishedMove;
/**
 *  @brief  指定的初始化方法
 *  @param  frame 在父视图上的大小
 *  @param  txt 需要显示的文本
 *  @return self
 *  @author cheng yan
 */
- (id)initWithFrame:(CGRect)frame txt:(NSString *)txt;

/**
 *  @brife  视图在屏幕上进行平移的操作
 *  @param  x 视图需要移动的距离
 *  @param  animation 是否有动画
 *  @return nil
 *  @author cheng yan
 */
- (void)move:(float)x animation:(BOOL)animation;

@end
