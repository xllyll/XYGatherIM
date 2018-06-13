//
//  XYGIMChatManager.h
//  XYGatherIM
//
//  Created by 杨卢银 on 2018/6/13.
//  Copyright © 2018年 杨卢银. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XYGIMChatManagerDelegate.h"
#import "XYGIMConversation.h"
#import "XYGIMMacros.h"

@class XYError;

@protocol XYGIMChatManager <NSObject>

@required

#pragma mark - Delegate

/**
 *  \~chinese
 *  添加回调代理
 *
 *  @param aDelegate  要添加的代理
 *  @param aQueue     执行代理方法的队列
 */
- (void)addDelegate:(id<XYGIMChatManagerDelegate>)aDelegate
      delegateQueue:(dispatch_queue_t)aQueue;

/**
 *  \~chinese
 *  移除回调代理
 *
 *  @param aDelegate  要移除的代理
 */
- (void)removeDelegate:(id<XYGIMChatManagerDelegate>)aDelegate;
#pragma mark - Conversation

/**
 *  \~chinese
 *  获取所有会话，如果内存中不存在会从DB中加载
 *
 *  @result 会话列表<XYGIMConversation>
 */
- (NSArray *)getAllConversations;

/**
 *  \~chinese
 *  获取一个会话
 *
 *  @param aConversationId  会话ID
 *  @param aType            会话类型
 *  @param aIfCreate        如果不存在是否创建
 *
 *  @result 会话对象
 */
- (XYGIMConversation *)getConversation:(NSString *)aConversationId
                                  type:(XYGIMConversationType)aType
                      createIfNotExist:(BOOL)aIfCreate;



/**
 *  \~chinese
 *  发送消息已读回执
 *
 *  异步方法
 *
 *  @param aMessage             消息
 *  @param aCompletionBlock     完成的回调
 *
 */
- (void)sendMessageReadAck:(XYGIMMessage *)aMessage
                completion:(void (^)(XYGIMMessage *aMessage, XYError *aError))aCompletionBlock;

/**
 *  \~chinese
 *  撤回消息
 *
 *  异步方法
 *
 *  @param aMessage             消息
 *  @param aCompletionBlock     完成的回调
 *
 */
- (void)recallMessage:(XYGIMMessage *)aMessage
           completion:(void (^)(XYGIMMessage *aMessage, XYError *aError))aCompletionBlock;

/**
 *  \~chinese
 *  发送消息
 *
 *  @param aMessage         消息
 *  @param aProgressBlock   附件上传进度回调block
 *  @param aCompletionBlock 发送完成回调block
 */
- (void)sendMessage:(XYGIMMessage *)aMessage
           progress:(void (^)(int progress))aProgressBlock
         completion:(void (^)(XYGIMMessage *message, XYError *error))aCompletionBlock;

/**
 *  \~chinese
 *  重发送消息
 *
 *  @param aMessage         消息
 *  @param aProgressBlock   附件上传进度回调block
 *  @param aCompletionBlock 发送完成回调block
 */
- (void)resendMessage:(XYGIMMessage *)aMessage
             progress:(void (^)(int progress))aProgressBlock
           completion:(void (^)(XYGIMMessage *message, XYError *error))aCompletionBlock;
@end
