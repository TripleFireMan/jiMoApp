//
//  CYLeftRootViewController.m
//  jiMoApp
//
//  Created by 成焱 on 14-4-4.
//  Copyright (c) 2014年 chengYan. All rights reserved.
//

#import "CYLeftRootViewController.h"
#import "CYCenterViewController.h"
#import "CYPersonalItem.h"
#import "CYPersonalCell.h"
#import "CYDownLoadViewController.h"
#import "CYLocalViewController.h"
#import "CYSettingViewController.h"
@interface CYLeftRootViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataSource;
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
    
    self.title = @"个人中心";

    [self initDataSource];
}

- (void)initDataSource
{
    self.dataSource = [[NSMutableArray alloc]init];
    NSArray *itemName = [NSArray arrayWithObjects:@"回到首页",@"本地书库",@"下载书籍",@"系统设置", nil];
    for (int i = 0; i<[itemName count]; i++) {
        CYPersonalItem *item = [CYPersonalItem new];
        item.itemName = itemName[i];
        [self.dataSource addObject:item];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"personalCell";
    CYPersonalCell *cell = nil;
    cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell==nil) {
        cell = [CYPersonalCell loadFromXib];
    }
    CYPersonalItem *item = [self.dataSource objectAtIndex:indexPath.row];
    cell.itemNameLabel.text = item.itemName;
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.dataSource count];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.row) {
        case 0:
        {
            CYCenterViewController *centerVc = [[CYCenterViewController alloc]init];
            UINavigationController *navi = [[UINavigationController   alloc]initWithRootViewController:centerVc];
            [self.mm_drawerController setCenterViewController:navi withCloseAnimation:YES completion:nil];
        }
            break;
        case 1:{
            CYLocalViewController *localVc = [[CYLocalViewController alloc]init];
            UINavigationController *navi = [[UINavigationController alloc]initWithRootViewController:localVc];
            [self.mm_drawerController setCenterViewController:navi withCloseAnimation:YES completion:nil];
        }break;
        case 2:{
            CYDownLoadViewController *downloadVc = [[CYDownLoadViewController alloc]init];
            UINavigationController *navi = [[UINavigationController alloc]initWithRootViewController:downloadVc];
            [self.mm_drawerController setCenterViewController:navi withCloseAnimation:YES completion:nil];
        }break;
        case 3:{
            CYSettingViewController *settingVc = [[CYSettingViewController alloc]init];
            UINavigationController *navi = [[UINavigationController alloc]initWithRootViewController:settingVc];
            [self.mm_drawerController setCenterViewController:navi withCloseAnimation:YES completion:nil];
        }break;
        default:
            break;
    }
}
@end
