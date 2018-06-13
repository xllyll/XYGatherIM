//
//  SDKHelper+WangYiYun.m
//  XYGatherIM
//
//  Created by 杨卢银 on 2018/6/13.
//  Copyright © 2018年 杨卢银. All rights reserved.
//

#import "SDKHelper+WangYiYun.h"
#import <NIMSDK/NIMSDK.h>

@implementation SDKHelper_WangYiYun
+(XYGIMMessage *)sendTextMessage:(NSString *)text to:(NSString *)to messageType:(XYGIMChatType)messageType messageExt:(NSDictionary *)messageExt{
    NIMMessage *message = [[NIMMessage alloc] init];
    message.text        = text;
    return message;
}
@end
