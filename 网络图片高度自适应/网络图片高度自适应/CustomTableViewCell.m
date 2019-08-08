//
//  CustomTableViewCell.m
//  网络图片高度自适应
//
//  Created by 闫继祥 on 2019/8/8.
//  Copyright © 2019 闫继祥. All rights reserved.
//

#import "CustomTableViewCell.h"

@implementation CustomTableViewCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.img = [[UIImageView alloc] init];
        self.img.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:self.img];
        self.img.contentMode=UIViewContentModeScaleAspectFill;
        self.img.clipsToBounds=YES;

    }
    return self;
}
- (void)layoutSubviews {
    [super layoutSubviews];
    self.img.frame = self.contentView.frame;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
