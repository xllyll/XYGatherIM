//
//  XYGIMChatVoiceMessageCell.m
//  XYGatherIM
//
//  Created by 杨卢银 on 2018/6/12.
//  Copyright © 2018年 杨卢银. All rights reserved.
//

#import "XYGIMChatVoiceMessageCell.h"
@interface XYGIMChatVoiceMessageCell()
@property (nonatomic, strong) UIImageView *messageVoiceStatusIV;
@property (nonatomic, strong) UILabel *messageVoiceSecondsL;
@property (nonatomic, strong) UIActivityIndicatorView *messageIndicatorV;
@end
@implementation XYGIMChatVoiceMessageCell

#pragma mark - Override Methods


- (void)prepareForReuse {
    
    [super prepareForReuse];
    [self setVoiceMessageState:XYGIMNVoiceMessageStateNormal];
    
}

- (void)updateConstraints {
    [super updateConstraints];
    
    if (self.messageOwner == XYGIMNMessageOwnerSelf) {
        [self.messageVoiceStatusIV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.messageContentV.mas_right).with.offset(-12);
            make.centerY.equalTo(self.messageContentV.mas_centerY);
        }];
        [self.messageVoiceSecondsL mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.messageVoiceStatusIV.mas_left).with.offset(-8);
            make.centerY.equalTo(self.messageContentV.mas_centerY);
        }];
        [self.messageIndicatorV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(self.messageContentV);
            make.width.equalTo(@10);
            make.height.equalTo(@10);
        }];
    }else if (self.messageOwner == XYGIMNMessageOwnerOther) {
        [self.messageVoiceStatusIV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.messageContentV.mas_left).with.offset(12);
            make.centerY.equalTo(self.messageContentV.mas_centerY);
        }];
        
        [self.messageVoiceSecondsL mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.messageVoiceStatusIV.mas_right).with.offset(8);
            make.centerY.equalTo(self.messageContentV.mas_centerY);
        }];
        [self.messageIndicatorV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(self.messageContentV);
            make.width.equalTo(@10);
            make.height.equalTo(@10);
        }];
    }
    
    [self.messageContentV mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@(80));
    }];
    
}

#pragma mark - Public Methods

- (void)setup {
    
    [self.messageContentV addSubview:self.messageVoiceSecondsL];
    [self.messageContentV addSubview:self.messageVoiceStatusIV];
    [self.messageContentV addSubview:self.messageIndicatorV];
    [super setup];
    self.voiceMessageState = XYGIMNVoiceMessageStateNormal;
    
}

- (void)configureCellWithData:(id)data {
    [super configureCellWithData:data];
    self.messageVoiceSecondsL.text = [NSString stringWithFormat:@"%ld''",[data[kXYGIMNMessageConfigurationVoiceSecondsKey] integerValue]];
    
    self.messageVoiceSecondsL.textColor = [UIColor blackColor];
    if (self.message.isSender == YES) {
        self.messageVoiceSecondsL.textColor = [UIColor whiteColor];
    }
}

#pragma mark - Getters

- (UIImageView *)messageVoiceStatusIV {
    if (!_messageVoiceStatusIV) {
        _messageVoiceStatusIV = [[UIImageView alloc] init];
        _messageVoiceStatusIV.image = self.messageOwner != XYGIMNMessageOwnerSelf ? [UIImage imageNamed:@"Emotion.bundle/message_voice_receiver_normal"] : [UIImage imageNamed:@"Emotion.bundle/message_voice_sender_normal"];
        UIImage *image1 = [UIImage imageNamed:self.messageOwner == XYGIMNMessageOwnerSelf ? @"Emotion.bundle/message_voice_sender_playing_1" : @"Emotion.bundle/message_voice_receiver_playing_1"];
        UIImage *image2 = [UIImage imageNamed:self.messageOwner == XYGIMNMessageOwnerSelf ? @"Emotion.bundle/message_voice_sender_playing_2" : @"Emotion.bundle/message_voice_receiver_playing_2"];
        UIImage *image3 = [UIImage imageNamed:self.messageOwner == XYGIMNMessageOwnerSelf ? @"Emotion.bundle/message_voice_sender_playing_3" : @"Emotion.bundle/message_voice_receiver_playing_3"];
        if (self.messageOwner == XYGIMNMessageOwnerSelf) {
            //image1 = [image1 rt_tintedImageWithColor:[UIColor whiteColor]];
            //image2 = [image2 rt_tintedImageWithColor:[UIColor whiteColor]];
            //image3 = [image3 rt_tintedImageWithColor:[UIColor whiteColor]];
        }
        _messageVoiceStatusIV.highlightedAnimationImages = @[image1,image2,image3];
        _messageVoiceStatusIV.animationDuration = 1.5f;
        _messageVoiceStatusIV.animationRepeatCount = NSUIntegerMax;
    }
    return _messageVoiceStatusIV;
}

- (UILabel *)messageVoiceSecondsL {
    if (!_messageVoiceSecondsL) {
        _messageVoiceSecondsL = [[UILabel alloc] init];
        _messageVoiceSecondsL.font = [UIFont systemFontOfSize:14.0f];
        _messageVoiceSecondsL.text = @"0''";
    }
    return _messageVoiceSecondsL;
}

- (UIActivityIndicatorView *)messageIndicatorV {
    if (!_messageIndicatorV) {
        _messageIndicatorV = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    }
    return _messageIndicatorV;
}

#pragma mark - Setters

- (void)setVoiceMessageState:(XYGIMNVoiceMessageState)voiceMessageState {
    if (_voiceMessageState != voiceMessageState) {
        _voiceMessageState = voiceMessageState;
    }
    self.messageVoiceSecondsL.hidden = NO;
    self.messageVoiceStatusIV.hidden = NO;
    self.messageIndicatorV.hidden = YES;
    [self.messageIndicatorV stopAnimating];
    
    if (_voiceMessageState == XYGIMNVoiceMessageStatePlaying) {
        self.messageVoiceStatusIV.highlighted = YES;
        [self.messageVoiceStatusIV startAnimating];
    }else if (_voiceMessageState == XYGIMNVoiceMessageStateDownloading) {
        self.messageVoiceSecondsL.hidden = YES;
        self.messageVoiceStatusIV.hidden = YES;
        self.messageIndicatorV.hidden = NO;
        [self.messageIndicatorV startAnimating];
    }else {
        self.messageVoiceStatusIV.highlighted = NO;
        [self.messageVoiceStatusIV stopAnimating];
    }
}

@end
