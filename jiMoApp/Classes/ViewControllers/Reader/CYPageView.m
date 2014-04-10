//
//  CYPageView.m
//  jiMoApp
//
//  Created by 成焱 on 14-4-10.
//  Copyright (c) 2014年 chengYan. All rights reserved.
//

#import "CYPageView.h"

@implementation CYPageView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame txt:(NSString *)txt
{
    if (self = [self initWithFrame:frame]) {
        _txtLabel = [[UILabel alloc]initWithFrame:self.bounds];
        _txtLabel.text = txt;
        _txtLabel.numberOfLines = 0;
        _txtLabel.backgroundColor = [UIColor whiteColor];
        _txtView = [[UIView alloc]initWithFrame:self.bounds];
        [_txtView addSubview:_txtLabel];
        _txtView.clipsToBounds = YES;
        [self addSubview:_txtView];
        
        _imageParentView = [[UIView alloc]initWithFrame:self.bounds];
        _imageView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 0, self.frame.size.width, self.frame.size.height)];
        [_imageParentView addSubview:_imageView];
        _imageParentView.clipsToBounds = YES;
        [self addSubview:_imageParentView];
        _imageParentView.hidden = YES;
     
        _ShadowLayer = [[CAGradientLayer alloc]init];
        _ShadowLayer.colors = [NSArray arrayWithObjects:(id)[UIColor colorWithRed:0xee /255.0 green:0xee /255.0 blue:0xee /255.0 alpha:0.1].CGColor,(id)[UIColor colorWithRed:0x00 /255.0 green:0x00 /255.0 blue:0x00 /255.0 alpha:0.2].CGColor,
                             (id)[UIColor colorWithRed:0xee /255.0 green:0xee /255.0 blue:0xee /255.0 alpha:0.1].CGColor
                             ,nil];
        _ShadowLayer.frame = CGRectMake(self.frame.size.width - self.frame.size.width /6 /2, 0, self.frame.size.width /6, self.frame.size.height);
        _ShadowLayer.startPoint = CGPointMake(0, 0.5);
        _ShadowLayer.endPoint = CGPointMake(1.0, 0.5);
        _imageView.clipsToBounds = NO;
        _ShadowLayer.hidden = YES;
        [self.layer addSublayer:_ShadowLayer];
    }
    return self;
}

- (void)didMoveToSuperview
{
    UIGraphicsBeginImageContext(_txtLabel.frame.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [UIColor colorWithRed:0xcc /255.0 green:0xcc /255.0 blue:0xcc /255.0 alpha:0.1].CGColor);
    CGContextTranslateCTM(context, _txtLabel.frame.size.width, 0);
    CGContextScaleCTM(context, -1, 1);
    
    [_txtLabel.layer renderInContext:context];
    CGContextFillRect(context, _txtLabel.bounds);
    
    _imageView.image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    
    CAGradientLayer *shadow = [[CAGradientLayer alloc] init];
    shadow.colors =[NSArray arrayWithObjects:(id)[UIColor colorWithRed:0xee /255.0 green:0xee /255.0 blue:0xee /255.0 alpha:0.2].CGColor,(id)[UIColor colorWithRed:0x00 /255.0 green:0x00 /255.0 blue:0x00 /255.0 alpha:0.3].CGColor
                    ,nil];
    shadow.frame = CGRectMake(-10, 0, 10, self.frame.size.height);
    shadow.startPoint = CGPointMake(0, 0.5);
    shadow.endPoint = CGPointMake(1.0, 0.5);
    
    _imageView.clipsToBounds = NO;
    [_imageView.layer addSublayer:shadow];
}

- (void)move:(float)x animation:(BOOL)animation
{
    _ShadowLayer.hidden = NO;
    _imageParentView.hidden = NO;
    if (animation) {
        [UIView beginAnimations:@"addd" context:nil];
        [UIView setAnimationDidStopSelector:@selector(didStop)];
        [UIView setAnimationDelegate:self];
        [UIView setAnimationDuration:0.5f];
    }
    CGRect rect = _imageParentView.frame;
    rect.origin.x = x;
    rect.size.width = self.frame.size.width - x;
    _imageParentView.frame = rect;
    
    rect = _txtView.frame;
    rect.size.width = x;
    rect.origin.x = self.frame.size.width - x;
    _txtView.frame = rect;
    rect = self.frame;
    rect.origin.x = -(self.frame.size.width - x);
    self.frame = rect;
    if(animation)
    {
        [UIView commitAnimations];
    }
}


- (void)didStop
{
    if (self.finishedMove!=nil) {
        self.finishedMove();
    }
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
