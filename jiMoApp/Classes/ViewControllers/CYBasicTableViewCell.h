//
//  CYBasicTableViewCell.h
//  jiMoApp
//
//  Created by 成焱 on 14-4-8.
//  Copyright (c) 2014年 chengYan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CYBasicTableViewCell : UITableViewCell
+ (id)loadFromXib;
- (void)configModel:(id)model;
@end
