//
//  XYGIMChatMessageCell.h
//  XYGatherIM
//
//  Created by 杨卢银 on 2018/6/12.
//  Copyright © 2018年 杨卢银. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XYGIMChatUntiles.h"
#import "XYGIMMessage.h"
#import "XYGIMContentView.h"
#import "XYGIMSendImageView.h"
#import "Masonry.h"

@class XYGIMChatMessageCell;

@protocol XYGIMChatMessageCellDelegate <NSObject>

- (void)messageCellTappedBlank:(XYGIMChatMessageCell *)messageCell;
- (void)messageCellTappedHead:(XYGIMChatMessageCell *)messageCell;
- (void)messageCellTappedMessage:(XYGIMChatMessageCell *)messageCell;
- (void)messageCell:(XYGIMChatMessageCell *)messageCell withActionType:(XYGIMNChatMessageCellMenuActionType)actionType;

@end

@interface XYGIMChatMessageCell : UITableViewCell


/**
 *  消息类容
 */
@property (nonatomic, strong) XYGIMMessage *message;
/**
 *  显示用户头像的UIImageView
 */
@property (nonatomic, strong) UIImageView *headIV;

/**
 *  显示用户昵称的UILabel
 */
@property (nonatomic, strong) UILabel *nicknameL;

/**
 *  显示用户消息主体的View,所有的消息用到的textView,imageView都会被添加到这个view中 -> XMNContentView 自带一个CAShapeLayer的蒙版
 */
@property (nonatomic, strong) XYGIMContentView *messageContentV;

/**
 *  显示消息阅读状态的UIImageView -> 主要用于VoiceMessage
 */
@property (nonatomic, strong) UIImageView *messageReadStateIV;

/**
 *  显示消息发送状态的UIImageView -> 用于消息发送不成功时显示
 */
@property (nonatomic, strong) XYGIMSendImageView *messageSendStateIV;

/**
 *  messageContentV的背景层
 */
@property (nonatomic, strong) UIImageView *messageContentBackgroundIV;


@property (nonatomic, weak) id<XYGIMChatMessageCellDelegate> delegate;

/**
 *  消息的类型,只读类型,会根据自己的具体实例类型进行判断
 */
@property (nonatomic, assign, readonly) XYGIMNMessageType messageType;

/**
 *  消息的所有者,只读类型,会根据自己的reuseIdentifier进行判断
 */
@property (nonatomic, assign, readonly) XYGIMNMessageOwner messageOwner;

/**
 *  消息群组类型,只读类型,根据reuseIdentifier判断
 */
@property (nonatomic, assign) XYGIMNMessageChat messageChatType;


/**
 *  消息发送状态,当状态为XMNMessageSendFail或XMNMessageSendStateSending时,XMNMessageSendStateIV显示
 */
@property (nonatomic, assign) XYGIMNMessageSendState messageSendState;

/**
 *  消息阅读状态,当状态为XMNMessageUnRead时,XMNMessageReadStateIV显示
 */
@property (nonatomic, assign) XYGIMNMessageReadState messageReadState;


#pragma mark - Public Methods

- (void)setup;

- (void)configureCellWithData:(id)data;

- (void)updateMessageCell;
@end
