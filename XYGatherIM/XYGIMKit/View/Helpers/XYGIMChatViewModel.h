//
//  XYGIMChatViewModel.h
//  FUContact
//
//  Created by 杨卢银 on 16/6/30.
//  Copyright © 2016年 杨卢银. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XYGIMChatUntiles.h"

@protocol XYGIMChatViewModelDelegate <NSObject>

@optional

- (void)reloadAfterReceiveMessage:(NSDictionary *)message;

- (void)messageSendStateChanged:(XYGIMNMessageSendState)sendState  withProgress:(CGFloat)progress forIndex:(NSUInteger)index;
- (void)messageReadStateChanged:(XYGIMNMessageReadState)readState withProgress:(CGFloat)progress forIndex:(NSUInteger)index;


@end

@protocol XYGIMChatMessageCellDelegate;

@interface XYGIMChatViewModel : NSObject<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, assign, readonly) NSUInteger messageCount;

@property (nonatomic, weak) id<XYGIMChatViewModelDelegate> delegate;



- (instancetype)initWithParentVC:(UIViewController<XYGIMChatMessageCellDelegate> *)parentVC;

/**
 *  添加一条消息到XMNChatViewModel,并不会出发发送消息到服务器的方法
 */
- (void)addMessage:(NSDictionary *)message;

/**
 *  发送一条消息,消息已经通过addMessage添加到XMNChatViewModel数组中了,次方法主要为了XMNChatServer发送消息过程
 */
- (void)sendMessage:(NSDictionary *)message;


- (void)removeMessageAtIndex:(NSUInteger)index;

- (NSDictionary *)messageAtIndex:(NSUInteger)index;


/**
 设置状态 state ： 0 默认正常状态 1 未连接状态
 */
@property(assign,nonatomic) NSInteger state;

@end
