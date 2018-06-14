//
//  XYGIMChatSystemMessageCell.m
//  XYGatherIM
//
//  Created by 杨卢银 on 2018/6/12.
//  Copyright © 2018年 杨卢银. All rights reserved.
//

#import "XYGIMChatSystemMessageCell.h"
@interface XYGIMChatSystemMessageCell()

@property (nonatomic, weak) UILabel *systemMessageL;
@property (nonatomic, strong) UIView *systemMessageContentV;
@property (nonatomic, strong, readonly) NSDictionary *systemMessageStyle;

@end
@implementation XYGIMChatSystemMessageCell
@synthesize systemMessageStyle = _systemMessageStyle;

#pragma mark - Override Methods

- (void)updateConstraints {
    [super updateConstraints];
    [self.systemMessageContentV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top).with.offset(3);
        make.bottom.equalTo(self.contentView.mas_bottom).with.offset(-3);
        make.width.lessThanOrEqualTo(@([UIApplication sharedApplication].keyWindow.frame.size.width/5*3));
        make.centerX.equalTo(self.contentView.mas_centerX);
        make.height.equalTo(@20);
    }];
    [self.systemMessageL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(self.systemMessageContentV.mas_height);
    }];
}

#pragma mark - Public Methods

- (void)setup {
    
    self.backgroundColor = [UIColor clearColor];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    [self.contentView addSubview:self.systemMessageContentV];
    
    [self updateConstraintsIfNeeded];
}

- (void)configureCellWithData:(id)data {
    [super configureCellWithData:data];
    
    self.systemMessageL.attributedText = [[NSAttributedString alloc] initWithString:data[kXYGIMNMessageConfigurationTextKey] attributes:self.systemMessageStyle];
    
}


#pragma mark - Getters

- (UIView *)systemMessageContentV {
    if (!_systemMessageContentV) {
        _systemMessageContentV = [[UIView alloc] init];
        _systemMessageContentV.backgroundColor = [UIColor clearColor];
        _systemMessageContentV.alpha = .8f;
        _systemMessageContentV.layer.cornerRadius = 6.0f;
        _systemMessageContentV.translatesAutoresizingMaskIntoConstraints = NO;
        
        UILabel *systemMessageL = [[UILabel alloc] init];
        systemMessageL.numberOfLines = 0;
        
        [_systemMessageContentV addSubview:self.systemMessageL = systemMessageL];
        [systemMessageL mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(_systemMessageContentV).with.insets(UIEdgeInsetsMake(8, 16, 8, 16));
        }];
        
        systemMessageL.attributedText = [[NSAttributedString alloc] initWithString:@"2015-11-16" attributes:self.systemMessageStyle];
    }
    return _systemMessageContentV;
}

- (NSDictionary *)systemMessageStyle {
    if (!_systemMessageStyle) {
        UIFont *font = [UIFont systemFontOfSize:10];
        NSMutableParagraphStyle *style = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
        style.paragraphSpacing = 0.1 * font.lineHeight;
        style.hyphenationFactor = 1.0;
        style.lineBreakMode = NSLineBreakByWordWrapping;
        style.alignment = NSTextAlignmentCenter;
        _systemMessageStyle = @{
                                NSFontAttributeName: font,
                                NSParagraphStyleAttributeName: style,
                                NSForegroundColorAttributeName: [UIColor grayColor]
                                };
    }
    return _systemMessageStyle;
}

@end
