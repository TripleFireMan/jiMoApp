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
#import "UIImage+ITTAdditions.h"
@interface CYLeftRootViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    UINavigationController *_homeNavi;
    UINavigationController *_localNavi;
    UINavigationController *_downLoadNavi;
    UINavigationController *_settingNavi;
    
    CYCenterViewController *_center;
    CYLocalViewController  *_local;
    CYDownLoadViewController *_downLoad;
    CYSettingViewController *_settting;
}
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

    [self initBlurryImageView];
    [self initDataSource];
    [self initViewControllers];
}

- (void)initBlurryImageView
{
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:self.tableView.frame];
    UIImage *image = [UIImage imageNamed:@"leftPannelBgImage_1"];
    image = [image blurryImage:image withBlurLevel:0.9f];
    imageView.image = image;
    self.tableView.backgroundView = imageView;
//    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
//    [self tableView:self.tableView didSelectRowAtIndexPath:indexPath];
}

- (void)initDataSource
{
    self.dataSource = [[NSMutableArray alloc]init];
    NSArray *itemName = [NSArray arrayWithObjects:@"一米阅读",@"本地书库",@"下载书籍",@"系统设置", nil];
    for (int i = 0; i<[itemName count]; i++) {
        CYPersonalItem *item = [CYPersonalItem new];
        item.itemName = itemName[i];
        [self.dataSource addObject:item];
    }
}

- (void)initViewControllers
{
    _center = [CYCenterViewController new];
    _center.showLeftBarButtonItem = YES;
    _local = [CYLocalViewController new];
    _local.showLeftBarButtonItem = YES;
    _downLoad = [CYDownLoadViewController new];
    _downLoad.showLeftBarButtonItem = YES;
    _settting = [CYSettingViewController new];
    _settting.showLeftBarButtonItem = YES;
    _homeNavi = [[UINavigationController alloc]initWithRootViewController:_center];
    _localNavi = [[UINavigationController alloc]initWithRootViewController:_local];
    _downLoadNavi = [[UINavigationController alloc]initWithRootViewController:_downLoad];
    _settingNavi = [[UINavigationController alloc]initWithRootViewController:_settting];
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
            [self.mm_drawerController setCenterViewController:_homeNavi withCloseAnimation:YES completion:nil];
        }
            break;
        case 1:{
            [self.mm_drawerController setCenterViewController:_localNavi withCloseAnimation:YES completion:nil];
        }break;
        case 2:{
            [self.mm_drawerController setCenterViewController:_downLoadNavi withCloseAnimation:YES completion:nil];
        }break;
        case 3:{
            [self.mm_drawerController setCenterViewController:_settingNavi withCloseAnimation:YES completion:nil];
        }break;
        default:
            break;
    }
}
@end
