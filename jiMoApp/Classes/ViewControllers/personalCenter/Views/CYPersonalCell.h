//
//  CYPersonalCell.h
//  jiMoApp
//
//  Created by 成焱 on 14-4-5.
//  Copyright (c) 2014年 chengYan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CYPersonalCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *itemNameLabel;

+ (id)loadFromXib;
@end
