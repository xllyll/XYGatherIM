//
//  XYGIMChatMessageCell.m
//  XYGatherIM
//
//  Created by 杨卢银 on 2018/6/12.
//  Copyright © 2018年 杨卢银. All rights reserved.
//

#import "XYGIMChatMessageCell.h"
#import "XYGIMChatTextMessageCell.h"
#import "XYGIMChatImageMessageCell.h"
#import "XYGIMChatVoiceMessageCell.h"
#import "XYGIMChatSystemMessageCell.h"
#import "XYGIMChatLocationMessageCell.h"
#import "XYGIMChatNotConnectCell.h"
#import "XYGIMChatVideoMessageCell.h"
#import "XYGIMChatAudioCallMessageCell.h"
#import "XYGIMChatVideoCallMessageCell.h"

#import <objc/runtime.h>

@interface XYGIMChatMessageCell ()
{
    UIImage *_defentImage;
}


@end
@implementation XYGIMChatMessageCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if ([super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setup];
    }
    return self;
}

#pragma mark - Life Cycle

- (instancetype)initWithFrame:(CGRect)frame {
    if ([super initWithFrame:frame]) {
        [self setup];
    }
    return self;
}

#pragma mark - Override Methods


- (void)updateConstraints {
    [super updateConstraints];
    if (self.messageOwner == XYGIMNMessageOwnerSystem || self.messageOwner == XYGIMNMessageOwnerUnknown) {
        return;
    }
    
    float width = 560;
    
    if (self.messageOwner == XYGIMNMessageOwnerSelf) {
        [self.headIV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.contentView.mas_right).with.offset(-16);
            make.top.equalTo(self.contentView.mas_top).with.offset(16);
            make.width.equalTo(@50);
            make.height.equalTo(@50);
        }];
        
        [self.nicknameL mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.headIV.mas_top);
            make.right.equalTo(self.headIV.mas_left).with.offset(-16);
            make.width.mas_lessThanOrEqualTo(@120);
            make.height.equalTo(self.messageChatType == XYGIMNMessageChatGroup ? @16 : @0);
        }];
        
        [self.messageContentV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.headIV.mas_left).with.offset(-8);
            make.top.equalTo(self.nicknameL.mas_bottom).with.offset(4);
            make.width.lessThanOrEqualTo(@(width/5*3)).priorityHigh();
            make.width.greaterThanOrEqualTo(@50);
            make.bottom.equalTo(self.contentView.mas_bottom).with.offset(-16).priorityLow();
        }];
        
        [self.messageSendStateIV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.messageContentV.mas_left).with.offset(-8);
            make.centerY.equalTo(self.messageContentV.mas_centerY);
            make.width.equalTo(@20);
            make.height.equalTo(@20);
        }];
        
        [self.messageReadStateIV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.messageContentV.mas_left).with.offset(-8);
            make.centerY.equalTo(self.messageContentV.mas_centerY);
            make.width.equalTo(@10);
            make.height.equalTo(@10);
        }];
    }else if (self.messageOwner == XYGIMNMessageOwnerOther){
        [self.headIV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView.mas_left).with.offset(16);
            make.top.equalTo(self.contentView.mas_top).with.offset(16);
            make.width.equalTo(@50);
            make.height.equalTo(@50);
        }];
        
        [self.nicknameL mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.headIV.mas_top);
            make.left.equalTo(self.headIV.mas_right).with.offset(16);
            make.width.mas_lessThanOrEqualTo(@120);
            make.height.equalTo(self.messageChatType == XYGIMNMessageChatGroup ? @16 : @0);
        }];
        
        [self.messageContentV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.headIV.mas_right).with.offset(8);
            make.top.equalTo(self.nicknameL.mas_bottom).with.offset(4);
            make.width.lessThanOrEqualTo(@(width/5*3)).priorityHigh();
            make.bottom.equalTo(self.contentView.mas_bottom).with.offset(-16).priorityLow();
        }];
        
        [self.messageSendStateIV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.messageContentV.mas_right).with.offset(8);
            make.centerY.equalTo(self.messageContentV.mas_centerY);
            make.width.equalTo(@20);
            make.height.equalTo(@20);
        }];
        
        [self.messageReadStateIV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.messageContentV.mas_right).with.offset(8);
            make.centerY.equalTo(self.messageContentV.mas_centerY);
            make.width.equalTo(@10);
            make.height.equalTo(@10);
        }];
    }
    [self.messageContentBackgroundIV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.messageContentV);
    }];
    
    if (self.messageChatType == XYGIMNMessageChatSingle) {
        [self.nicknameL mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@0);
        }];
    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
    CGPoint touchPoint = [[touches anyObject] locationInView:self.contentView];
    if (CGRectContainsPoint(self.messageContentV.frame, touchPoint)) {
        self.messageContentBackgroundIV.highlighted = YES;
    }
}

- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesCancelled:touches withEvent:event];
    self.messageContentBackgroundIV.highlighted = NO;
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesEnded:touches withEvent:event];
    self.messageContentBackgroundIV.highlighted = NO;
}


#pragma mark - Private Methods

- (void)setup {
    
    _defentImage = [UIImage imageNamed:@"man"];
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.backgroundColor = [UIColor clearColor];
    
    [self.contentView addSubview:self.headIV];
    [self.contentView addSubview:self.nicknameL];
    [self.contentView addSubview:self.messageContentV];
    [self.contentView addSubview:self.messageReadStateIV];
    [self.contentView addSubview:self.messageSendStateIV];
    
    self.messageSendStateIV.hidden = YES;
    self.messageReadStateIV.hidden = YES;
    
    if (self.messageOwner == XYGIMNMessageOwnerSelf) {
        //        [self.messageContentBackgroundIV setImage:[[UIImage imageNamed:@"chat_bubble_right"] resizableImageWithCapInsets:UIEdgeInsetsMake(30, 16, 16, 24) resizingMode:UIImageResizingModeStretch]];
        //        [self.messageContentBackgroundIV setHighlightedImage:[[UIImage imageNamed:@"message_sender_background_highlight"] resizableImageWithCapInsets:UIEdgeInsetsMake(30, 16, 16, 24) resizingMode:UIImageResizingModeStretch]];
        //
        
        
        UIImage *leftBgImage = [UIImage imageNamed:@"SenderTextNodeBkg"];
        leftBgImage = [leftBgImage resizableImageWithCapInsets:(UIEdgeInsetsMake(30, 20, 10, 15))];
        // 左端盖宽度
        NSInteger leftCapWidth = leftBgImage.size.width * 0.5f;
        // 顶端盖高度
        NSInteger topCapHeight = leftBgImage.size.height * 0.5f;
        leftBgImage = [leftBgImage stretchableImageWithLeftCapWidth:leftCapWidth topCapHeight:topCapHeight];
        self.messageContentBackgroundIV.image = leftBgImage;
        self.messageContentV.layer.mask = self.messageContentBackgroundIV.layer;
    }else if (self.messageOwner == XYGIMNMessageOwnerOther){
        //        [self.messageContentBackgroundIV setImage:[[UIImage imageNamed:@"chat_bubble_left"] resizableImageWithCapInsets:UIEdgeInsetsMake(30, 16, 16, 24) resizingMode:UIImageResizingModeStretch]];
        //        [self.messageContentBackgroundIV setHighlightedImage:[[UIImage imageNamed:@"message_receiver_background_highlight"] resizableImageWithCapInsets:UIEdgeInsetsMake(30, 16, 16, 24) resizingMode:UIImageResizingModeStretch]];
        UIImage *rightBgImage = [UIImage imageNamed:@"ReceiverTextNodeBkg"];
        rightBgImage = [rightBgImage resizableImageWithCapInsets:(UIEdgeInsetsMake(30, 20, 10, 15))];
        // 左端盖宽度
        NSInteger rightCapWidth = rightBgImage.size.width * 0.5f;
        // 顶端盖高度
        NSInteger topCapHeight = rightBgImage.size.height * 0.5f;
        rightBgImage = [rightBgImage stretchableImageWithLeftCapWidth:rightCapWidth topCapHeight:topCapHeight];
        self.messageContentBackgroundIV.image = rightBgImage;
    }
    
    self.messageContentV.layer.mask.contents = (__bridge id _Nullable)(self.messageContentBackgroundIV.image.CGImage);
    [self.contentView insertSubview:self.messageContentBackgroundIV belowSubview:self.messageContentV];
    
    [self updateConstraintsIfNeeded];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)];
    [self.contentView addGestureRecognizer:tap];
    
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(chatMessageCell_handleLongPress:)];
    longPress.numberOfTouchesRequired = 1;
    longPress.minimumPressDuration = 1.f;
    [self.contentView addGestureRecognizer:longPress];
    
}
-(void)updateMessageCell{
    
}
#pragma mark - Public Methods

- (void)configureCellWithData:(id)data {
    
    _message = data[kXYGIMNMessageConfigurationKey];
    if ([data[kXYGIMNMessageConfigurationOwnerKey] integerValue]==XYGIMNMessageOwnerSelf) {
        
    }else{
        self.nicknameL.text = data[kXYGIMNMessageConfigurationNicknameKey];
        
        
        
    }
    
    if (data[kXYGIMNMessageConfigurationReadStateKey]) {
        self.messageReadState = [data[kXYGIMNMessageConfigurationReadStateKey] integerValue];
    }
    if (data[kXYGIMNMessageConfigurationSendStateKey]) {
        self.messageSendState = [data[kXYGIMNMessageConfigurationSendStateKey] integerValue];
    }
    
}

#pragma mark - Private Methods



- (void)handleTap:(UITapGestureRecognizer *)tap {
    if (tap.state == UIGestureRecognizerStateEnded) {
        CGPoint tapPoint = [tap locationInView:self.contentView];
        if (CGRectContainsPoint(self.messageContentV.frame, tapPoint)) {
            [self.delegate messageCellTappedMessage:self];
        }else if (CGRectContainsPoint(self.headIV.frame, tapPoint)) {
            [self.delegate messageCellTappedHead:self];
        }else {
            [self.delegate messageCellTappedBlank:self];
        }
    }
}

#pragma mark - Setters

- (void)setMessageSendState:(XYGIMNMessageSendState)messageSendState {
    _messageSendState = messageSendState;
    if (self.messageOwner == XYGIMNMessageOwnerOther) {
        self.messageSendStateIV.hidden = YES;
    }
    self.messageSendStateIV.messageSendState = messageSendState;
}

- (void)setMessageReadState:(XYGIMNMessageReadState)messageReadState {
    _messageReadState = messageReadState;
    if (self.messageOwner == XYGIMNMessageOwnerSelf) {
        self.messageSendStateIV.hidden = YES;
    }
    switch (_messageReadState) {
        case XYGIMNMessageUnRead:
            self.messageReadStateIV.hidden = NO;
            break;
        default:
            self.messageReadStateIV.hidden = YES;
            break;
    }
}

#pragma mark - Getters

- (UIImageView *)headIV {
    if (!_headIV) {
        _headIV = [[UIImageView alloc] init];
        _headIV.layer.cornerRadius = 25.0f;
        _headIV.layer.masksToBounds = YES;
        _headIV.backgroundColor = [UIColor whiteColor];
    }
    return _headIV;
}

- (UILabel *)nicknameL {
    if (!_nicknameL) {
        _nicknameL = [[UILabel alloc] init];
        _nicknameL.font = [UIFont systemFontOfSize:12.0f];
        _nicknameL.textColor = [UIColor blackColor];
        _nicknameL.text = @"nickname";
    }
    return _nicknameL;
}

- (XYGIMContentView *)messageContentV {
    if (!_messageContentV) {
        _messageContentV = [[XYGIMContentView alloc] init];
    }
    return _messageContentV;
}

- (UIImageView *)messageReadStateIV {
    if (!_messageReadStateIV) {
        _messageReadStateIV = [[UIImageView alloc] init];
        _messageReadStateIV.backgroundColor = [UIColor redColor];
    }
    return _messageReadStateIV;
}

- (XYGIMSendImageView *)messageSendStateIV {
    if (!_messageSendStateIV) {
        _messageSendStateIV = [[XYGIMSendImageView alloc] init];
    }
    return _messageSendStateIV;
}

- (UIImageView *)messageContentBackgroundIV {
    if (!_messageContentBackgroundIV) {
        _messageContentBackgroundIV = [[UIImageView alloc] init];
    }
    return _messageContentBackgroundIV;
}

- (XYGIMNMessageType)messageType {
    if ([self isKindOfClass:[XYGIMChatTextMessageCell class]]) {
        return XYGIMNMessageTypeText;
    }else if ([self isKindOfClass:[XYGIMChatImageMessageCell class]]) {
        return XYGIMNMessageTypeImage;
    }else if ([self isKindOfClass:[XYGIMChatVoiceMessageCell class]]) {
        return XYGIMNMessageTypeVoice;
    }else if ([self isKindOfClass:[XYGIMChatLocationMessageCell class]]) {
        return XYGIMNMessageTypeLocation;
    }else if ([self isKindOfClass:[XYGIMChatSystemMessageCell class]]) {
        return XYGIMNMessageTypeSystem;
    }else if ([self isKindOfClass:[XYGIMChatVideoMessageCell class]]) {
        return XYGIMNMessageTypeVideo;
    }else if ([self isKindOfClass:[XYGIMChatAudioCallMessageCell class]]) {
        return XYGIMNMessageTypeCallAudio;
    }else if ([self isKindOfClass:[XYGIMChatVideoCallMessageCell class]]) {
        return XYGIMNMessageTypeCallVideo;
    }
    
    return XYGIMNMessageTypeUnknow;
}

- (XYGIMNMessageChat)messageChatType {
    if ([self.reuseIdentifier containsString:@"GroupCell"]) {
        return XYGIMNMessageChatGroup;
    } {
        return XYGIMNMessageChatSingle;
    }
}

- (XYGIMNMessageOwner)messageOwner {
    if ([self.reuseIdentifier containsString:@"OwnerSelf"]) {
        return XYGIMNMessageOwnerSelf;
    }else if ([self.reuseIdentifier containsString:@"OwnerOther"]) {
        return XYGIMNMessageOwnerOther;
    }else if ([self.reuseIdentifier containsString:@"OwnerSystem"]) {
        return XYGIMNMessageOwnerSystem;
    }
    return XYGIMNMessageOwnerUnknown;
}


@end



#pragma mark - XMNChatMessageCellMenuActionCategory

NSString * const kXYGIMNChatMessageCellMenuControllerKey;

@interface XYGIMChatMessageCell (XMNChatMessageCellMenuAction)

@property (nonatomic, strong, readonly) UIMenuController *menuController;

- (void)chatMessageCell_handleLongPress:(UILongPressGestureRecognizer *)longPressGes;

@end

@implementation XYGIMChatMessageCell (XYGIMNChatMessageCellMenuAction)

#pragma mark - Private Methods

//以下两个方法必须有
/*
 *  让UIView成为第一responser
 */
- (BOOL)canBecomeFirstResponder{
    return YES;
}

/*
 *  根据action,判断UIMenuController是否显示对应aciton的title
 */
- (BOOL)canPerformAction:(SEL)action withSender:(id)sender{
    if (action == @selector(menuRelayAction) || action == @selector(menuCopyAction)) {
        return YES;
    }
    return NO;
}

- (void)chatMessageCell_handleLongPress:(UILongPressGestureRecognizer *)longPressGes {
    if (longPressGes.state == UIGestureRecognizerStateBegan) {
        CGPoint longPressPoint = [longPressGes locationInView:self.contentView];
        if (!CGRectContainsPoint(self.messageContentV.frame, longPressPoint)) {
            return;
        }
        [self becomeFirstResponder];
        
        //!!!此处使用self.superview.superview 获得到cell所在的tableView,不是很严谨,有哪位知道更加好的方法请告知
        CGRect targetRect = [self convertRect:self.messageContentV.frame toView:self.superview.superview];
        [self.menuController setTargetRect:targetRect inView:self.superview.superview];
        [self.menuController setMenuVisible:YES animated:YES];
    }
}


- (void)menuCopyAction {
    if (self.delegate && [self.delegate respondsToSelector:@selector(messageCell:withActionType:)]) {
        [self.delegate messageCell:self withActionType: XYGIMNChatMessageCellMenuActionTypeCopy];
    }
}

- (void)menuRelayAction {
    if (self.delegate && [self.delegate respondsToSelector:@selector(messageCell:withActionType:)]) {
        [self.delegate messageCell:self withActionType: XYGIMNChatMessageCellMenuActionTypeRelay];
    }
}

#pragma mark - Getters


- (UIMenuController *)menuController{
    UIMenuController *menuController = objc_getAssociatedObject(self,&kXYGIMNChatMessageCellMenuControllerKey);
    if (!menuController) {
        menuController = [UIMenuController sharedMenuController];
        UIMenuItem *copyItem = [[UIMenuItem alloc] initWithTitle:@"复制" action:@selector(menuCopyAction)];
        UIMenuItem *shareItem = [[UIMenuItem alloc] initWithTitle:@"转发" action:@selector(menuRelayAction)];
        UIMenuItem *shoucItem = [[UIMenuItem alloc] initWithTitle:@"收藏" action:@selector(menuRelayAction)];
        UIMenuItem *deleteItem = [[UIMenuItem alloc] initWithTitle:@"删除" action:@selector(menuRelayAction)];
        if (self.messageType == XYGIMNMessageTypeText) {
            [menuController setMenuItems:@[copyItem,shareItem,shoucItem,deleteItem]];
        }else{
            [menuController setMenuItems:@[shareItem,shoucItem,deleteItem]];
        }
        [menuController setArrowDirection:UIMenuControllerArrowDown];
        objc_setAssociatedObject(self, &kXYGIMNChatMessageCellMenuControllerKey, menuController, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return menuController;
}

@end
