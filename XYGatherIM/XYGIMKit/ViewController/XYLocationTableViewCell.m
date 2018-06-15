//
//  XYLocationTableViewCell.m
//  XYGatherIM
//
//  Created by 杨卢银 on 2018/6/14.
//  Copyright © 2018年 杨卢银. All rights reserved.
//

#import "XYLocationTableViewCell.h"
#import "UIView+XYExt.h"
#import "XYColors.h"

@implementation XYLocationTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.textLabel.font = [UIFont systemFontOfSize:16];
        
        self.detailTextLabel.font = [UIFont systemFontOfSize:12];
        self.detailTextLabel.textColor = kLLTextColor_lightGray_system;
    }
    
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.textLabel.top_LL -= 3;
    self.textLabel.left_LL -= 3;
    
    self.detailTextLabel.bottom_LL += 1;
    self.detailTextLabel.left_LL -= 3;
}

@end
