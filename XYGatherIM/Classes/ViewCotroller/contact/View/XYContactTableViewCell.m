//
//  XYContactTableViewCell.m
//  XYGatherIM
//
//  Created by 杨卢银 on 2018/6/11.
//  Copyright © 2018年 杨卢银. All rights reserved.
//

#import "XYContactTableViewCell.h"

@implementation XYContactTableViewCell
-(instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier{
    NSString *xibname =  NSStringFromClass(self.class);
    self = [[[NSBundle mainBundle] loadNibNamed:[NSString stringWithFormat:@"%@",xibname] owner:self options:nil] lastObject];
    if (self) {
        [self setRestorationIdentifier:reuseIdentifier];
    }
    return self;
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
