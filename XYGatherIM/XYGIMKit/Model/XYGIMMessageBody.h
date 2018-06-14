//
//  XYGIMMessageBody.h
//  XYGatherIM
//
//  Created by 杨卢银 on 2018/6/13.
//  Copyright © 2018年 杨卢银. All rights reserved.
//

#import <UIKit/UIKit.h>
/**
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

@interface XYGIMMessageBody : NSObject

/*!
 *  \~chinese
 *  消息体类型
 *
 *  \~english
 *  Message body type
 */
@property (nonatomic) XYGIMMessageBodyType type;

@end
