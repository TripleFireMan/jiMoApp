//
//  CYBasicViewController.m
//  jiMoApp
//
//  Created by 成焱 on 14-4-5.
//  Copyright (c) 2014年 chengYan. All rights reserved.
//

#import "CYBasicViewController.h"
#import "MMDrawerBarButtonItem.h"
#import "UIViewController+MMDrawerController.h"
@interface CYBasicViewController ()
@end

@implementation CYBasicViewController

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
    [self setTitleWithAtttibuteDic];
//    if (self.showLeftBarButtonItem) {
//        [self initLeftBarBtnItem];
//    }
}

- (void)setTitleWithAtttibuteDic
{
    UINavigationBar *navigationBar = [self.navigationController navigationBar];
    NSDictionary *textcolor = [NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],UITextAttributeTextColor,nil];
    navigationBar.titleTextAttributes = textcolor;
    
    if (OSVersionAtLeastIOS_7()) {
        [navigationBar setBarTintColor:[UIColor darkGrayColor]];
    }else{
        [navigationBar setTintColor:[UIColor darkGrayColor]];
    }
    self.view.backgroundColor = [UIColor whiteColor];
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

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
