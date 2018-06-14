//
//  XYGIMChatTextMessageCell.m
//  XYGatherIM
//
//  Created by 杨卢银 on 2018/6/12.
//  Copyright © 2018年 杨卢银. All rights reserved.
//

#import "XYGIMChatTextMessageCell.h"
#import "XYGIMFaceManager.h"

@interface XYGIMChatTextMessageCell()
/**
 *  用于显示文本消息的文字
 */
@property (nonatomic, strong) UILabel *messageTextL;
@property (nonatomic, copy, readonly) NSDictionary *textStyle;
@end
@implementation XYGIMChatTextMessageCell

@synthesize textStyle = _textStyle;

#pragma mark - Override Methods

- (void)updateConstraints {
    [super updateConstraints];
    [self.messageTextL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.messageContentV).with.insets(UIEdgeInsetsMake(8, 16, 8, 16));
    }];
}

#pragma mark - Public Methods

- (void)setup {
    
    [self.messageContentV addSubview:self.messageTextL];
    [super setup];
    
}

- (void)configureCellWithData:(id)data {
    [super configureCellWithData:data];
    
    NSMutableAttributedString *attrS = [XYGIMFaceManager emotionStrWithString:data[kXYGIMNMessageConfigurationTextKey]];
    [attrS addAttributes:self.textStyle range:NSMakeRange(0, attrS.length)];
    self.messageTextL.attributedText = attrS;
    _messageTextL.textColor = [UIColor blackColor];
    if (self.message.isSender == YES) {
        _messageTextL.textColor = [UIColor whiteColor];
    }
    
}

#pragma mark - Getters

- (UILabel *)messageTextL {
    if (!_messageTextL) {
        _messageTextL = [[UILabel alloc] init];
        _messageTextL.textColor = [UIColor blackColor];
        
        _messageTextL.font = [UIFont systemFontOfSize:16.0f];
        _messageTextL.numberOfLines = 0;
        _messageTextL.lineBreakMode = NSLineBreakByWordWrapping;
    }
    return _messageTextL;
}

- (NSDictionary *)textStyle {
    if (!_textStyle) {
        UIFont *font = [UIFont systemFontOfSize:14.0f];
        NSMutableParagraphStyle *style = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
        //style.alignment = self.messageOwner == FUNMessageOwnerSelf ? NSTextAlignmentRight : NSTextAlignmentLeft;
        style.alignment = NSTextAlignmentLeft;
        style.paragraphSpacing = 0.25 * font.lineHeight;
        style.hyphenationFactor = 1.0;
        _textStyle = @{NSFontAttributeName: font,
                       NSParagraphStyleAttributeName: style};
    }
    return _textStyle;
    
}

@end
