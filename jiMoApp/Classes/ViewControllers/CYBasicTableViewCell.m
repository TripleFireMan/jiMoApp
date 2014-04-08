//
//  CYBasicTableViewCell.m
//  jiMoApp
//
//  Created by 成焱 on 14-4-8.
//  Copyright (c) 2014年 chengYan. All rights reserved.
//

#import "CYBasicTableViewCell.h"
#import "ITTXibViewUtils.h"
@implementation CYBasicTableViewCell

+ (id)loadFromXib
{
    CYBasicTableViewCell *cell = [ITTXibViewUtils loadViewFromXibNamed:NSStringFromClass([self class]) withFileOwner:nil];
    return cell;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
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

- (void)configModel:(id)model
{
    SHOULDOVERRIDE(@"CYBasicTableViewCell", NSStringFromClass([self class]));
}
@end
