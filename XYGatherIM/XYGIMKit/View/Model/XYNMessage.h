//
//  XYNMessage.h
//  XYGatherIM
//
//  Created by 杨卢银 on 2018/6/13.
//  Copyright © 2018年 杨卢银. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XYGIMMessage.h"

@interface XYNMessage : NSObject
//缓存数据模型对应的cell的高度，只需要计算一次并赋值，以后就无需计算了
@property (nonatomic) CGFloat cellHeight;
//SDK中的消息
@property (strong, nonatomic, readonly) XYGIMMessage *message;
//消息的第一个消息体
@property (strong, nonatomic, readonly) XYGIMMessageBody *firstMessageBody;

//消息ID
@property (strong, nonatomic, readonly) NSString *messageId;
//消息类型
@property (nonatomic, readonly) XYGIMMessageBodyType bodyType;
//消息发送状态
@property (nonatomic, readonly) XYGIMMessageStatus messageStatus;
@property (nonatomic) XYGIMDownloadStatus messageDownloadStatus;
@property (nonatomic) XYGIMDownloadStatus thumbnailDownloadStatus;
// 消息类型（单聊，群里，聊天室）
@property (nonatomic, readonly) XYGIMChatType messageType;


//消息发送方
@property (nonatomic, copy) NSString *from;
//消息接收方
@property (nonatomic, copy) NSString *to;

@property (nonatomic, getter=isFromMe) BOOL fromMe;

//是否已读
@property (nonatomic) BOOL isMessageRead;
//是否是当前登录者发送的消息
@property (nonatomic) BOOL isSender;

//消息显示的昵称
@property (strong, nonatomic) NSString *nickname;
//消息显示的头像的网络地址
@property (strong, nonatomic) NSString *avatarURLPath;
//消息显示的头像
@property (strong, nonatomic) UIImage *avatarImage;

/**文本消息：文本*/
@property (strong, nonatomic) NSString *text;

/*文本消息：文本*/
@property (strong, nonatomic) NSAttributedString *attrBody;

#pragma mark 地址消息
/*地址消息：地址描述*/
@property (strong, nonatomic) NSString *address;
//地址消息：地址经度
@property (nonatomic) double latitude;
//地址消息：地址纬度
@property (nonatomic) double longitude;

#pragma mark 图片消息
//获取图片失败后显示的图片
@property (strong, nonatomic) NSString *failImageName;
//图片消息：图片原图的宽高
@property (nonatomic) CGSize imageSize;
//图片消息：图片缩略图的宽高
@property (nonatomic) CGSize thumbnailImageSize;
//图片消息：图片原图
@property (strong, nonatomic) UIImage *image;
//图片消息：图片缩略图
@property (strong, nonatomic) UIImage *thumbnailImage;
- (UIImage *)fullImage;
//多媒体消息：是否正在播放
@property (nonatomic) BOOL isMediaPlaying;
//多媒体消息：是否播放过
@property (nonatomic) BOOL isMediaPlayed;
//多媒体消息：长度
@property (nonatomic) CGFloat mediaDuration;

- (long long)fileAttachmentSize;

- (BOOL)isVideoPlayable;

- (BOOL)isFullImageAvailable;

- (BOOL)isVoicePlayable;

//文件消息：文件图标
@property (strong, nonatomic) NSString *fileIconName;
//文件消息：文件名称
@property (strong, nonatomic) NSString *fileName;
//文件消息：文件大小描述
@property (strong, nonatomic) NSString *fileSizeDes;
//文件消息：文件大小
@property (nonatomic) CGFloat fileSize;

//带附件的消息的上传或下载进度
@property (nonatomic) float progress;
//附件上传进度，范围为0--100
@property (nonatomic) NSInteger fileUploadProgress;
//附件下载进度，范围为0--100
@property (nonatomic) NSInteger fileDownloadProgress;

//消息：附件本地地址
@property (strong, nonatomic, readonly) NSString *fileLocalPath;
//消息：压缩附件本地地址
@property (strong, nonatomic) NSString *thumbnailFileLocalPath;
//消息：附件下载地址
@property (strong, nonatomic) NSString *fileURLPath;
//消息：压缩附件下载地址
@property (strong, nonatomic) NSString *thumbnailFileURLPath;

- (instancetype)initWithMessage:(XYGIMMessage *)message;


@property (copy , nonatomic) NSDictionary *dictionary;
@end
