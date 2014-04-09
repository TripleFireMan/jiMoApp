//
//  CYLocalTxtNameViewController.m
//  jiMoApp
//
//  Created by 成焱 on 14-4-8.
//  Copyright (c) 2014年 chengYan. All rights reserved.
//

#import "CYLocalTxtNameViewController.h"
#import "CYDirectoryTableViewCell.h"
#import "CYBookReaderViewController.h"
@interface CYLocalTxtNameViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong) NSMutableArray *directorys;
@end

@implementation CYLocalTxtNameViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.directory = [CYDirectory new];
        self.directorys = [[NSMutableArray alloc]init];
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = self.directory.parentDirectoryName;
    NSArray *absoluteUrl = nil;
    NSArray *arr = [CYFileManager getTxtNamesWithDirectorPath:self.directory.parentDirectoryAbsoluteUrl txtAbsolutePaths:&absoluteUrl];
    [arr enumerateObjectsUsingBlock:^(id obj,NSUInteger index, BOOL *stop){
        CYDirectory *directory = [CYDirectory new];
        directory.index = index;
        directory.currentDirectoryName = obj;
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
    CYDirectory *directory = (CYDirectory *)[self.directorys objectAtIndex:indexPath.row];
    CYBookReaderViewController  *reader = [CYBookReaderViewController new];
    reader.txtAbsoluteUrl = directory.currentDirectoryAbsoluteUrl;
    [self.navigationController pushViewController:reader animated:YES];
    NSLog(@"---%@",self.navigationController);
}
@end
