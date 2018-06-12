//
//  XYGIMNChatServer.h
//  XYGatherIM
//
//  Created by 杨卢银 on 2018/6/12.
//  Copyright © 2018年 杨卢银. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "XYGIMChatUntiles.h"

typedef void(^XYGIMNChatServerProgressBlock)(CGFloat progress);
typedef void(^XYGIMNChatServerCompleteBlock)(XYGIMNMessageSendState sendState);

@protocol XYGIMNChatServerDelegate <NSObject>

- (void)recieveMessage:(NSDictionary *)message;

@end

@protocol XYGIMNChatServer <NSObject>

@property (nonatomic, weak) id<XYGIMNChatServerDelegate> delegate;

- (void)sendMessage:(NSDictionary *)message withProgressBlock:(XYGIMNChatServerProgressBlock)progressBlock completeBlock:(XYGIMNChatServerCompleteBlock)completeBlock;

@end
