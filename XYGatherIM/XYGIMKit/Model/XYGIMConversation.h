//
//  XYGIMConversation.h
//  XYGatherIM
//
//  Created by 杨卢银 on 2018/6/13.
//  Copyright © 2018年 杨卢银. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XYGIMMessage.h"
#import "XYError.h"
/*
 *  \~chinese
 *  会话类型
 *
 *  \~english
 *  Conversation type
 */
typedef enum {
    XYGIMConversationTypeChat  = 0,    /*! \~chinese 单聊会话 \~english one-to-one chat */
    XYGIMConversationTypeGroupChat,    /*! \~chinese 群聊会话 \~english group chat  */
    XYGIMConversationTypeChatRoom      /*! \~chinese 聊天室会话 \~english chat room  */
} XYGIMConversationType;

typedef enum {
    XYGIMMessageSearchDirectionUp  = 0,    /*! \~chinese 向上搜索 \~english Search older messages */
    XYGIMMessageSearchDirectionDown        /*! \~chinese 向下搜索 \~english Search newer messages */
} XYGIMMessageSearchDirection;

@interface XYGIMConversation : NSObject

-(instancetype)initWithConversation:(id)conversation;

@property (strong , nonatomic)id conversation;

@property (nonatomic, copy) NSString *conversationId;

/*!
 *  \~chinese
 *  会话类型
 *
 *  \~english
 *  Conversation type
 */
@property (nonatomic, assign) XYGIMConversationType type;

/*!
 *  \~chinese
 *  对话中未读取的消息数量
 *
 *  \~english
 *  unread message count
 */
@property (nonatomic, assign) NSInteger unreadMessagesCount;

/*!
 *  \~chinese
 *  会话扩展属性
 *
 *  \~english
 *  Conversation extension property
 */
@property (nonatomic, copy) NSDictionary *ext;

/*!
 *  \~chinese
 *  会话最新一条消息
 *
 *  \~english
 *  Conversation latest message
 */
@property (nonatomic, strong) XYGIMMessage *latestMessage;

-(NSString*)showTime;

/*!
 *  \~chinese
 *  将消息设置为已读
 *
 *  @param aMessageId   要设置消息的ID
 *  @param pError       错误信息
 *
 */
- (void)markMessageAsReadWithId:(NSString *)aMessageId
                          error:(XYError **)pError;

/*!
 *  \~chinese
 *  将所有未读消息设置为已读
 *
 *  @param pError   错误信息
 *
 */
- (void)markAllMessagesAsRead:(XYError **)pError;


/**
 *  \~chinese
 *  删除一条消息
 *
 *  @param aMessageId   要删除消失的ID
 *  @param pError       错误信息
 *
 */
- (void)deleteMessageWithId:(NSString *)aMessageId
                      error:(XYError **)pError;

/**
 *  \~chinese
 *  删除该会话所有消息，同时清除内存和数据库中的消息
 *
 *  @param pError       错误信息
 */
- (void)deleteAllMessages:(XYError **)pError;

#pragma mark - Load Messages Methods
/**
 *  \~chinese
 *  获取指定ID的消息
 *
 *  @param aMessageId       消息ID
 *  @param pError           错误信息
 *
 */
- (XYGIMMessage *)loadMessageWithId:(NSString *)aMessageId
                              error:(XYError **)pError;
/**
 *  \~chinese
 *  从数据库获取指定数量的消息，取到的消息按时间排序，并且不包含参考的消息，如果参考消息的ID为空，则从最新消息取
 *
 *  @param aMessageId       参考消息的ID
 *  @param aCount            获取的条数
 *  @param aDirection       消息搜索方向
 *  @param aCompletionBlock 完成的回调
 */
- (void)loadMessagesStartFromId:(NSString *)aMessageId
                          count:(int)aCount
                searchDirection:(XYGIMMessageSearchDirection)aDirection
                     completion:(void (^)(NSArray *aMessages, XYError *aError))aCompletionBlock;
@end
