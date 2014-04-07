//
//  RootViewController.m
//  gitHub_Project
//
//  Created by CY on 13-8-27.
//  Copyright (c) 2013年 chengYan. All rights reserved.
//

#import "CYCenterViewController.h"
#import "MMDrawerBarButtonItem.h"
#import "UIViewController+MMDrawerController.h"
#import "UIImage+ITTAdditions.h"
#import "CYFileManager.h"
#import "CommonUtils.h"
@interface CYCenterViewController ()

@end

@implementation CYCenterViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"一米阅读";
    [self initLeftBarBtnItem];
    CYFileManager *fileManager = [CYFileManager shareInstance];
    NSLog(@"text = %@",[fileManager getTxtPath]);
//    [self initCenterPannelBgImageView];

    [fileManager loadLocalTxtFiles];

}

- (void)initLeftBarBtnItem
{
    MMDrawerBarButtonItem *btnItem = [[MMDrawerBarButtonItem alloc]initWithTarget:self action:@selector(leftBarButtonItemClick:)];
    self.navigationItem.leftBarButtonItem = btnItem;
}

- (void)leftBarButtonItemClick:(id)sender
{
    [self.mm_drawerController toggleDrawerSide:MMDrawerSideLeft animated:YES completion:nil];
}

- (void)initCenterPannelBgImageView
{
    UIImageView *bgImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 320, [UIScreen mainScreen].bounds.size.height)];
    UIImage *bgImg = [UIImage imageNamed:@"leftPannelBgImage_1"];
    bgImg = [bgImg blurryImage:bgImg withBlurLevel:0.99];
    bgImageView.image = bgImg;
    [self.view addSubview:bgImageView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
