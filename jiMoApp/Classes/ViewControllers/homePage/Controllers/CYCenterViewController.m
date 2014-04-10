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
//#import "UIImage+ITTAdditions.h"
//#import "CYFileManager.h"
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
//    NSArray *absulteArr = nil;
//    NSArray *bb = [CYFileManager  getTxtDirectorysFinishedAbsulteUrlsArray:nil];
//    NSLog(@"b = %@",bb);
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark tableViewDelegates

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return nil;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}


@end
