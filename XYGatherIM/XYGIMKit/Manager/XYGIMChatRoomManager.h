//
//  XYGIMChatRoomManager.h
//  XYGatherIM
//
//  Created by 杨卢银 on 2018/6/23.
//  Copyright © 2018年 杨卢银. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XYGIMChatroomManagerDelegate.h"
@class XYError;


/**
 聊天室相关操作
 */
@protocol XYGIMChatRoomManager < NSObject >
@required

#pragma mark - Delegate

/*!
 *  \~chinese
 *  添加回调代理
 *
 *  @param aDelegate  要添加的代理
 *  @param aQueue     添加回调代理
 */
- (void)addDelegate:(id<XYGIMChatroomManagerDelegate>)aDelegate
      delegateQueue:(dispatch_queue_t)aQueue;

/*!
 *  \~chinese
 *  移除回调代理
 *
 *  @param aDelegate  要移除的代理
 */
- (void)removeDelegate:(id<XYGIMChatroomManagerDelegate>)aDelegate;
@end
