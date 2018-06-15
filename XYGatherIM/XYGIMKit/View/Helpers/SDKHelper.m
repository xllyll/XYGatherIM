//
//  SDKHelper.m
//  XYGatherIM
//
//  Created by 杨卢银 on 2018/6/13.
//  Copyright © 2018年 杨卢银. All rights reserved.
//

#import "SDKHelper.h"
#import "XYGIMClient.h"

@implementation SDKHelper
//+(Class)getSDKHelper{
//    Class a;
//    switch ([XYGIMClient sharedClient].libType) {
//        case XYGIMLibTypeHuanXin:
//            a = NSClassFromString(@"SDKHelper+HuanXin");
//            break;
//        case XYGIMLibTypeRongYun:
//            a = NSClassFromString(@"SDKHelper+RongYun");
//            break;
//        case XYGIMLibTypeJiGuang:
//            a = NSClassFromString(@"SDKHelper+JiGuang");
//            break;
//        case XYGIMLibTypeWangYiYun:
//            a = NSClassFromString(@"SDKHelper+WangYiYun");
//            break;
//        default:
//            a = NSClassFromString(@"SDKHelper");
//            break;
//    }
//    return a;
//}
+(XYGIMMessage *)sendTextMessage:(NSString *)text to:(NSString *)to messageType:(XYGIMChatType)messageType messageExt:(NSDictionary *)messageExt{
    //return [[SDKHelper getSDKHelper] sendTextMessage:text to:to messageType:messageType messageExt:messageExt];
    
    XYGIMMessage *msg = [[XYGIMMessage alloc] init];
    msg.text = text;
    msg.to = to;
    msg.chatType = messageType;
    msg.messageType = XYGIMMessageBodyTypeText;
    msg.ext = messageExt;
    return msg;
    
}
+(XYGIMMessage *)sendLocationMessageWithLatitude:(double)latitude longitude:(double)longitude address:(NSString *)address to:(NSString *)to messageType:(XYGIMChatType)messageType messageExt:(NSDictionary *)messageExt{
    XYGIMMessage *msg = [[XYGIMMessage alloc] init];
    msg.text = @"发送一条地理位置";
    msg.to = to;
    msg.chatType = messageType;
    msg.messageType = XYGIMMessageBodyTypeLocation;
    msg.ext = messageExt;
    XYGIMLocationMessageBody *body = [[XYGIMLocationMessageBody alloc] initWithLatitude:latitude longitude:longitude address:address];
    msg.body = body;
    return msg;
}
@end
