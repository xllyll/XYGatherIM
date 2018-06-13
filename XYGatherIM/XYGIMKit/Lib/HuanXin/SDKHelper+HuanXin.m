//
//  SDKHelper+HuanXin.m
//  XYGatherIM
//
//  Created by 杨卢银 on 2018/6/13.
//  Copyright © 2018年 杨卢银. All rights reserved.
//

#import "SDKHelper+HuanXin.h"
#import <Hyphenate/Hyphenate.h>

@implementation SDKHelper_HuanXin
+(XYGIMMessage *)sendTextMessage:(NSString *)text to:(NSString *)toUser messageType:(XYGIMChatType)messageType messageExt:(NSDictionary *)messageExt{
    
    NSString *willSendText = [XYGIMConvertToCommonEmoticonsHelper convertToCommonEmoticons:text];
    EMTextMessageBody *body = [[EMTextMessageBody alloc] initWithText:willSendText];
    NSString *from = [[EMClient sharedClient] currentUsername];
    EMMessage *message = [[EMMessage alloc] initWithConversationID:toUser from:from to:toUser body:body ext:messageExt];
    message.chatType = messageType;
    
    return message;
}
@end
