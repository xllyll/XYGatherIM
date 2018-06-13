//
//  XYChatListTableViewCell.m
//  XYGatherIM
//
//  Created by 杨卢银 on 2018/6/13.
//  Copyright © 2018年 杨卢银. All rights reserved.
//

#import "XYChatListTableViewCell.h"
#import "UIView+XYView.h"

@interface XYChatListTableViewCell()

@property (weak, nonatomic) IBOutlet UILabel *badgeValuelabel;

@end
@implementation XYChatListTableViewCell
-(instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier{
    NSString *xibname =  NSStringFromClass(self.class);
    self = [[[NSBundle mainBundle] loadNibNamed:[NSString stringWithFormat:@"%@",xibname] owner:self options:nil] lastObject];
    if (self) {
        [self setRestorationIdentifier:reuseIdentifier];
        [_badgeValuelabel setRoundView];
        
    }
    return self;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [_badgeValuelabel setRoundView];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)setBadgeValue:(NSInteger)badgeValue{
    _badgeValuelabel.hidden = NO;
    if (badgeValue <= 0) {
        _badgeValuelabel.hidden = YES;
    }else{
        _badgeValuelabel.text = [NSString stringWithFormat:@"%d",(int)badgeValue];
    }
}
@end
