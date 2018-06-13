//
//  XYGIMMessage.h
//  XYGatherIM
//
//  Created by 杨卢银 on 2018/6/11.
//  Copyright © 2018年 杨卢银. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XYGIMMessageBody.h"

/*!
 *  \~chinese
 *  聊天类型
 *
 *  \~english
 *  Chat type
 */
typedef enum {
    XYGIMChatTypeChat   = 0,   /*! \~chinese 单聊消息 \~english one to one chat type */
    XYGIMChatTypeGroupChat,    /*! \~chinese 群聊消息 \~english Group chat type */
    XYGIMChatTypeChatRoom,     /*! \~chinese 聊天室消息 \~english Chatroom chat type */
} XYGIMChatType;

/*!
 *  \~chinese
 *  消息发送状态
 *
 *  \~english
 *   Message delivery status
 */
typedef enum {
    XYGIMMessageStatusPending  = 0,    /*! \~chinese 发送未开始 \~english Pending */
    XYGIMMessageStatusDelivering,      /*! \~chinese 正在发送 \~english Delivering */
    XYGIMMessageStatusSucceed,       /*! \~chinese 发送成功 \~english Succeed */
    XYGIMMessageStatusFailed,          /*! \~chinese 发送失败 \~english Failed */
} XYGIMMessageStatus;

/*!
 *  \~chinese
 *  消息方向
 *
 *  \~english
 *  Message direction
 */
typedef enum {
    XYGIMMessageDirectionSend = 0,    /*! \~chinese 发送的消息 \~english Send */
    XYGIMMessageDirectionReceive,     /*! \~chinese 接收的消息 \~english Receive */
} XYGIMMessageDirection;


/*!
 *  \~chinese
 *  消息体类型
 *
 *  \~english
 *  Message body type
 */
typedef enum {
    XYGIMMessageBodyTypeText   = 1,    /*! \~chinese 文本类型 \~english Text */
    XYGIMMessageBodyTypeImage,         /*! \~chinese 图片类型 \~english Image */
    XYGIMMessageBodyTypeVideo,         /*! \~chinese 视频类型 \~english Video */
    XYGIMMessageBodyTypeLocation,      /*! \~chinese 位置类型 \~english Location */
    XYGIMMessageBodyTypeVoice,         /*! \~chinese 语音类型 \~english Voice */
    XYGIMMessageBodyTypeFile,          /*! \~chinese 文件类型 \~english File */
    XYGIMMessageBodyTypeCmd,           /*! \~chinese 命令类型 \~english Command */
    XYGIMMessageBodyTypeNotification
} XYGIMMessageBodyType;


@interface XYGIMMessage : NSObject

-(instancetype)initWithMessage:(id)aMessage;

@property (assign , nonatomic) id message;


/*!
 *  \~chinese
 *  消息的唯一标识符
 *
 *  \~english
 *  Unique identifier of the message
 */
@property (nonatomic, copy) NSString *messageId;

/*!
 *  \~chinese
 *  所属会话的唯一标识符
 *
 *  \~english
 *  Unique identifier of conversation, the message's container object
 */
@property (nonatomic, copy) NSString *conversationId;


@property (nonatomic, copy) NSString *text;
/*!
 *  \~chinese
 *  发送方
 *
 *  \~english
 *  Message sender
 */
@property (nonatomic, copy) NSString *from;

/*!
 *  \~chinese
 *  接收方
 *
 *  \~english
 *  Message receiver
 */
@property (nonatomic, copy) NSString *to;

/*!
 *  \~chinese
 *  时间戳，服务器收到此消息的时间
 *
 *  \~english
 *  Timestamp, the time of server received the message
 */
@property (nonatomic) long long timestamp;

/*!
 *  \~chinese
 *  客户端发送/收到此消息的时间
 *
 *  \~english
 *  The time of client sends/receives the message
 */
@property (nonatomic) long long localTime;

/*!
 *  \~chinese
 *  消息类型
 *
 *  \~english
 *  Chat type
 */
@property (nonatomic) XYGIMChatType chatType;

@property (nonatomic) XYGIMMessageBodyType messageType;
/*!
 *  \~chinese
 *  消息状态
 *
 *  \~english
 *  Message delivery status
 */
@property (nonatomic) XYGIMMessageStatus status;

/*!
 *  \~chinese
 *  已读回执是否已发送/收到, 对于发送方表示是否已经收到已读回执，对于接收方表示是否已经发送已读回执
 *
 *  \~english
 *  Acknowledge if the message is read by the receipient. It indicates whether the sender has received a message read acknowledgement; or whether the recipient has sent a message read acknowledgement
 */
@property (nonatomic) BOOL isReadAcked;

/*!
 *  \~chinese
 *  送达回执是否已发送/收到，对于发送方表示是否已经收到送达回执，对于接收方表示是否已经发送送达回执，如果EMOptions设置了enableDeliveryAck，SDK收到消息后会自动发送送达回执
 *
 *  \~english
 *  Acknowledge if the message is delivered. It indicates whether the sender has received a message deliver acknowledgement; or whether the recipient has sent a message deliver acknowledgement. SDK will automatically send delivery acknowledgement if EMOptions is set to enableDeliveryAck
 */
@property (nonatomic) BOOL isDeliverAcked;

/*!
 *  \~chinese
 *  是否已读
 *
 *  \~english
 *  Whether the message has been read
 */
@property (nonatomic) BOOL isRead;

/*!
 *  \~chinese
 *  消息体
 *
 *  \~english
 *  Message body
 */
@property (nonatomic, strong) XYGIMMessageBody *body;

/*!
 *  \~chinese
 *  消息扩展
 *
 *  Key值类型必须是NSString, Value值类型必须是NSString或者 NSNumber类型的 BOOL, int, unsigned in, long long, double.
 *
 *  \~english
 *  Message extension
 *
 *  Key type must be NSString. Value type must be NSString, or NSNumber object (including int, unsigned in, long long, double, use NSNumber (@YES/@NO) instead of BOOL).
 */
@property (nonatomic, copy) NSDictionary *ext;


@end
