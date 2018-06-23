//
//  XYGIMCallManager.h
//  XYGatherIM
//
//  Created by 杨卢银 on 2018/6/23.
//  Copyright © 2018年 杨卢银. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XYGIMCallManagerDelegate.h"

@class XYError;

@protocol XYGIMCallManager <NSObject>

@optional

#pragma mark - Delegate

/*!
 *  \~chinese
 *  添加回调代理
 *
 *  @param aDelegate  要添加的代理
 *  @param aQueue     执行代理方法的队列
 */
- (void)addDelegate:(id<XYGIMCallManagerDelegate>)aDelegate
      delegateQueue:(dispatch_queue_t)aQueue;

/*!
 *  \~chinese
 *  移除回调代理
 *
 *  @param aDelegate  要移除的代理
 */
- (void)removeDelegate:(id<XYGIMCallManagerDelegate>)aDelegate;

@end
