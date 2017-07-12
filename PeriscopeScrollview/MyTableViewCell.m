//
//  MyTableViewCell.m
//  滚动test
//
//  Created by keyan on 15/9/21.
//  Copyright (c) 2015年 keyan. All rights reserved.
//

#import "MyTableViewCell.h"

@interface MyTableViewCell ()
@property (weak, nonatomic) IBOutlet UIImageView *headImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@end
@implementation MyTableViewCell

- (void)awakeFromNib {
    // Initialization code
    self.titleLabel.text  =@"yizeruier";
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)layoutSubviews
{
    [super layoutSubviews];
}
+ (CGFloat)tableViewHeightWithWidth:(CGFloat)width
{
    return 60;
}

@end
