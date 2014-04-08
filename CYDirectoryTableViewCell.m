//
//  CYDirectoryTableViewCell.m
//  jiMoApp
//
//  Created by 成焱 on 14-4-8.
//  Copyright (c) 2014年 chengYan. All rights reserved.
//

#import "CYDirectoryTableViewCell.h"
#import "CYDirectory.h"
@interface CYDirectoryTableViewCell ()
@property (weak, nonatomic) IBOutlet UILabel *directoryNameLabel;
@property (weak, nonatomic) IBOutlet UIView *bottomLine;
@property (weak, nonatomic) IBOutlet UIView *topLine;

@end



@implementation CYDirectoryTableViewCell

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
    if ([model isKindOfClass:[CYDirectory class]]) {
        CYDirectory *directory = (CYDirectory *)model;
        self.directoryNameLabel.text = directory.currentDirectoryName;
        if (directory.index==0) {
            self.topLine.hidden = NO;
        }else{
            self.topLine.hidden = YES;
        }
    }
}
@end
