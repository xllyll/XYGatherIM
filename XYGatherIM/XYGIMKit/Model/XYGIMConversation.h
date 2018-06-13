//
//  XYGIMConversation.h
//  XYGatherIM
//
//  Created by 杨卢银 on 2018/6/13.
//  Copyright © 2018年 杨卢银. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XYGIMMessage.h"
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

@interface XYGIMConversation : NSObject

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

@end
