//
//  XYGIMChatLocationMessageCell.m
//  XYGatherIM
//
//  Created by 杨卢银 on 2018/6/12.
//  Copyright © 2018年 杨卢银. All rights reserved.
//

#import "XYGIMChatLocationMessageCell.h"
@interface XYGIMChatLocationMessageCell ()
@property (nonatomic, strong) UIView *locationV;
@property (nonatomic, strong) UIImageView *locationIV;
@property (nonatomic, strong) UIView  *locationAddressIV;
@property (nonatomic, strong) UILabel *locationAddressL;

@end
@implementation XYGIMChatLocationMessageCell

#pragma mark - Override Methods

- (void)updateConstraints {
    [super updateConstraints];
    CGFloat location_image_width = ceil(0.618 * [UIScreen mainScreen].bounds.size.width);
    CGFloat location_image_height = 128.0;
    [self.messageContentBackgroundIV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@(location_image_height));
        make.width.equalTo(@(location_image_width));
    }];
//    [self.locationV mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.edges.equalTo(self.messageContentV);
//    }];
//    [self.locationAddressIV mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(self.locationIV.mas_left).with.offset(0);
//        make.top.equalTo(self.locationIV.mas_top).with.offset(0);
//        make.right.equalTo(self.locationIV.mas_right).with.offset(0);
//        make.height.equalTo(@46);
//    }];
//    [self.locationAddressL mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(self.locationAddressIV.mas_left).with.offset(0);
//        make.top.equalTo(self.locationAddressIV.mas_top).with.offset(0);
//        make.right.equalTo(self.locationAddressIV.mas_right).with.offset(0);
//    }];
    
}

#pragma mark - Public Methods

- (void)setup {
    
    [self.messageContentV addSubview:self.locationV];
//    [self.locationV addSubview:self.locationIV];
//    [self.locationIV addSubview:self.locationAddressIV];
//    [self.locationAddressIV addSubview:self.locationAddressL];
    [super setup];
    //self.messageContentBackgroundIV.image = [UIImage imageNamed:@"map_located"];
}

- (void)configureCellWithData:(id)data {
    [super configureCellWithData:data];
    _locationAddressL.textColor = [UIColor blackColor];
    if (self.message.isSender) {
        _locationAddressL.textColor = [UIColor whiteColor];
    }
    _locationAddressL.text=data[kXYGIMNMessageConfigurationLocationKey];
}

#pragma mark - Getters

- (UILabel *)locationAddressL {
    if (!_locationAddressL) {
        _locationAddressL = [[UILabel alloc] init];
        _locationAddressL.textColor = [UIColor blackColor];
        _locationAddressL.font = [UIFont systemFontOfSize:16.0f];
        _locationAddressL.numberOfLines = 3;
        _locationAddressL.textAlignment = NSTextAlignmentNatural;
        _locationAddressL.lineBreakMode = NSLineBreakByTruncatingTail;
        _locationAddressL.text = @"上海市 试验费snap那就开动脑筋阿萨德你接啊三年级可 ";
    }
    return _locationAddressL;
}
-(UIView *)locationAddressIV{
    if (!_locationAddressIV) {
        _locationAddressIV = [[UIView alloc] initWithFrame:CGRectZero];
        _locationAddressIV.backgroundColor = [UIColor whiteColor];
    }
    return _locationAddressIV;
}
-(UIView *)locationV{
    if (!_locationV) {
        _locationV = [[UIView alloc] initWithFrame:CGRectZero];
        _locationV.backgroundColor = [UIColor redColor];
    }
    return _locationV;
}
- (UIImageView *)locationIV {
    if (!_locationIV) {
        _locationIV = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"map_located"]];
    }
    return _locationIV;
}

@end
