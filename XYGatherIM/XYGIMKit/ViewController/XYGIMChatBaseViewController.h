//
//  XYChatBaseViewController.h
//  XYGatherIM
//
//  Created by 杨卢银 on 2018/6/11.
//  Copyright © 2018年 杨卢银. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XYGIMChatBar.h"
#import "XYGIMChatViewModel.h"

#import "XYGIMAudioPlayer.h"
#import "XYGIMChatMessageCell.h"
#import "XYGIMChatUntiles.h"
#import "XYGIMClient.h"

@interface XYGIMChatBaseViewController : UIViewController

#ifndef DOXYGEN_SHOULD_SKIP_THIS

- (id)init __attribute__((unavailable("init is not a supported initializer for this class.")));


#endif

-(instancetype)initWithConversationChatter:(NSString *)conversationChatter conversationType:(XYGIMConversationType)conversationType;

@property (strong, nonatomic) UITableView *tableView;

@property (strong, nonatomic) XYGIMChatBar *chatBar;

@property (nonatomic, strong) XYGIMChatViewModel *chatViewModel;

@property (assign, nonatomic) XYGIMNMessageChat messageChatType;
/*!
 @property
 @brief 聊天的会话对象
 */
@property (strong, nonatomic) XYGIMConversation *conversation;
/*!
 @property
 @brief 显示的EMMessage类型的消息列表
 */
@property (strong, nonatomic) NSMutableArray *messsagesSource;
/*!
 @property
 @brief 时间间隔标记
 */
@property (nonatomic) NSTimeInterval messageTimeIntervalTag;

/*!
 @property
 @brief 加载的每页message的条数
 */
@property (nonatomic) NSInteger messageCountOfPage;
/*!
 @property
 @brief 页面是否处于显示状态
 */
@property (nonatomic) BOOL isViewDidAppear;
/**
 @property
 @brief 当前页面显示时，是否滚动到最后一条
 */
@property (nonatomic) BOOL scrollToBottomWhenAppear; //default YES;

#pragma mark SendMessage
/**
 @method
 @brief 发送文本消息
 @param text 文本消息
 */
- (void)sendTextMessage:(NSString *)text;

/**
 @method
 @brief 发送文本消息
 @param text 文本消息
 @param ext  扩展信息
 */
- (void)sendTextMessage:(NSString *)text withExt:(NSDictionary*)ext;
- (void)sendCmcMessage:(NSString *)text withExt:(NSDictionary*)ext cmdParams:(NSArray*)cmdParams;
/**
 @method
 @brief 发送图片消息
 @param image 发送图片
 */
- (void)sendImageMessage:(UIImage *)image;
- (void)sendImageMessageWithData:(NSData *)imageData;

/**
 @method
 @brief 发送位置消息
 @param latitude 经度
 @param longitude 纬度
 @param address 地址
 */
- (void)sendLocationMessageLatitude:(double)latitude
                          longitude:(double)longitude
                         andAddress:(NSString *)address;

/**
 @method
 @brief 发送语音消息
 @param localPath 语音本地地址
 @param duration 时长
 */
- (void)sendVoiceMessageWithLocalPath:(NSString *)localPath
                             duration:(NSInteger)duration;

/**
 @method
 @brief 发送视频消息
 @param url 视频url
 */
- (void)sendVideoMessageWithURL:(NSURL *)url;
-(void)addMessageToDataSource:(XYGIMMessage *)message
                     progress:(id)progress;

#pragma mark SELECT
- (void)imageMessageCellSelected:(id)model messageCell:(UIView *)messageCell;
- (void)videoMessageCellSelected:(id)model messageCell:(UIView *)messageCell;
@end
