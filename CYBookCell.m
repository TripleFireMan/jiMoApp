//
//  CYBookCell.m
//  jiMoApp
//
//  Created by 成焱 on 14-4-8.
//  Copyright (c) 2014年 chengYan. All rights reserved.
//

#import "CYBookCell.h"
#import "CYBookBrief.h"

@interface CYBookCell()

@property (weak, nonatomic) IBOutlet UIButton *firstBookBtn;
@property (weak, nonatomic) IBOutlet UIButton *secondBookBtn;
@property (weak, nonatomic) IBOutlet UIButton *thirdBookBtn;

@end


@implementation CYBookCell

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
