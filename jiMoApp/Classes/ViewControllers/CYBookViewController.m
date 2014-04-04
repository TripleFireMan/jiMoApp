//
//  CYBookViewController.m
//  jiMoApp
//
//  Created by 成焱 on 14-4-5.
//  Copyright (c) 2014年 chengYan. All rights reserved.
//

#import "CYBookViewController.h"

@interface CYBookViewController ()

@end

@implementation CYBookViewController

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
    self.title = @"书屋";
    UINavigationBar *navigationBar = [self.navigationController navigationBar];
    if (OSVersionAtLeastIOS_7()) {
        [navigationBar setBarTintColor:[UIColor redColor]];
    }
    self.view.backgroundColor = [UIColor whiteColor];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
