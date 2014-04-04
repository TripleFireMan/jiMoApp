//
//  CYLeftRootViewController.m
//  jiMoApp
//
//  Created by 成焱 on 14-4-4.
//  Copyright (c) 2014年 chengYan. All rights reserved.
//

#import "CYLeftRootViewController.h"
#import "CYBookViewController.h"
#import "CYCenterViewController.h"
@interface CYLeftRootViewController ()
- (IBAction)home:(id)sender;

- (IBAction)push:(id)sender;
@end

@implementation CYLeftRootViewController

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
    UINavigationBar *navigationBar = [self.navigationController navigationBar];
    self.title = @"设置";
    if (OSVersionAtLeastIOS_7()) {
        [navigationBar setBarTintColor:[UIColor redColor]];
    }
    self.view.backgroundColor = [UIColor whiteColor];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
}

- (IBAction)home:(id)sender {
    CYCenterViewController   *center = [[CYCenterViewController alloc]init];
    UINavigationController *navi = [[UINavigationController alloc]initWithRootViewController:center];

    [self.mm_drawerController setCenterViewController:navi withCloseAnimation:YES completion:nil];
}

- (IBAction)push:(id)sender {
    CYBookViewController    *book = [[CYBookViewController alloc]init];
    UINavigationController *navi = [[UINavigationController alloc]initWithRootViewController:book];
    [self.mm_drawerController setCenterViewController:navi withCloseAnimation:YES completion:nil];
}
@end
