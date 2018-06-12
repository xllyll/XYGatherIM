//
//  XYGIMMessageStateManager.h
//  XYGatherIM
//
//  Created by 杨卢银 on 2018/6/12.
//  Copyright © 2018年 杨卢银. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XYGIMChatUntiles.h"

@interface XYGIMMessageStateManager : NSObject

+ (instancetype)shareManager;


#pragma mark - Public Methods

- (XYGIMNMessageSendState)messageSendStateForIndex:(NSUInteger)index;
- (XYGIMNMessageReadState)messageReadStateForIndex:(NSUInteger)index;

- (void)setMessageSendState:(XYGIMNMessageSendState)messageSendState forIndex:(NSUInteger)index;
- (void)setMessageReadState:(XYGIMNMessageReadState)messageReadState forIndex:(NSUInteger)index;

- (void)cleanState;
@end
