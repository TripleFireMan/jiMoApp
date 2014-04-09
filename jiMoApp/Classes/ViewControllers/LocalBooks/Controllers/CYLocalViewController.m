//
//  CYLocalViewController.m
//  jiMoApp
//
//  Created by 成焱 on 14-4-5.
//  Copyright (c) 2014年 chengYan. All rights reserved.
//

#import "CYLocalViewController.h"
#import "CYDirectoryTableViewCell.h"
#import "CYDirectory.h"
#import "CYLocalTxtNameViewController.h"
@interface CYLocalViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) NSMutableArray *directorys;//路径名
@end

@implementation CYLocalViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.directorys = [[NSMutableArray alloc]init];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"本地书库";
    NSArray *absoluteUrl = nil;
    NSArray *arr = [CYFileManager getTxtDirectorysFinishedAbsulteUrlsArray:&absoluteUrl];
    [arr enumerateObjectsUsingBlock:^(id obj, NSUInteger index, BOOL *stop){
        CYDirectory *directory = [CYDirectory new];
        directory.currentDirectoryName = obj;
        directory.index = index;
        directory.currentDirectoryAbsoluteUrl = absoluteUrl[index];
        [self.directorys addObject:directory];
    }];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark tableViewDelegates

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdenfier = @"cellIdentifier";
    CYDirectoryTableViewCell *cell = nil;
    cell = [tableView dequeueReusableCellWithIdentifier:cellIdenfier];
    if (cell==nil) {
        cell = [CYDirectoryTableViewCell loadFromXib];
    }
    CYDirectory *directory = [self.directorys objectAtIndex:indexPath.row];
    [cell configModel:directory];
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.directorys count];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    CYDirectory *directory = [self.directorys objectAtIndex:indexPath.row];
    CYLocalTxtNameViewController *localNameViewController = [[CYLocalTxtNameViewController alloc]init];
    
    localNameViewController.directory.parentDirectoryName = directory.currentDirectoryName;
    localNameViewController.directory.parentDirectoryAbsoluteUrl = directory.currentDirectoryAbsoluteUrl;
    [self.navigationController pushViewController:localNameViewController animated:YES];
}

@end
