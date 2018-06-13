//
//  XYGIMChatManagerDelegate.h
//  XYGatherIM
//
//  Created by 杨卢银 on 2018/6/13.
//  Copyright © 2018年 杨卢银. All rights reserved.
//

#import <Foundation/Foundation.h>

@class XYGIMMessage;

@protocol XYGIMChatManagerDelegate <NSObject>

/**
 *  收到消息回调
 *
 *  @param messages 消息列表,内部为NIMMessage
 */
- (void)XYGIM_onRecvMessages:(NSArray<XYGIMMessage *> *)messages;

@end
