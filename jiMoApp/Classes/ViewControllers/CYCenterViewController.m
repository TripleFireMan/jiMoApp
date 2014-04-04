//
//  RootViewController.m
//  gitHub_Project
//
//  Created by CY on 13-8-27.
//  Copyright (c) 2013年 chengYan. All rights reserved.
//

#import "CYCenterViewController.h"
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
    self.title = @"首页";
    UINavigationBar *navigationBar = [self.navigationController navigationBar];
    if (OSVersionAtLeastIOS_7()) {
        [navigationBar setBarTintColor:[UIColor redColor]];
    }
    self.view.backgroundColor = [UIColor whiteColor];
	
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
