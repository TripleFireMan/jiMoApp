//
//  CYPersonalCell.m
//  jiMoApp
//
//  Created by 成焱 on 14-4-5.
//  Copyright (c) 2014年 chengYan. All rights reserved.
//

#import "CYPersonalCell.h"

#import "ITTXibViewUtils.h"

@implementation CYPersonalCell

+ (id)loadFromXib
{
    CYPersonalCell *cell = [ITTXibViewUtils loadViewFromXibNamed:NSStringFromClass([CYPersonalCell class]) withFileOwner:nil];
    return cell;
}
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
