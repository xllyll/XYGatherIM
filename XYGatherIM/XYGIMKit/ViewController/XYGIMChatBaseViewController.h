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
@end
