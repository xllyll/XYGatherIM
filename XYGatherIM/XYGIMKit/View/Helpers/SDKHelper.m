//
//  SDKHelper.m
//  XYGatherIM
//
//  Created by 杨卢银 on 2018/6/13.
//  Copyright © 2018年 杨卢银. All rights reserved.
//

#import "SDKHelper.h"
#import "XYGIMClient.h"
#import "UIImage+XYImage.h"
#import "NSData+XYData.h"

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
    XYGIMTextMessageBody *body = [[XYGIMTextMessageBody alloc] initWithText:text];
    msg.body = body;
    return msg;
    
}

+ (XYGIMMessage *)sendImageMessageWithImageData:(NSData *)imageData
                                             to:(NSString *)to
                                    messageType:(XYGIMChatType)messageType
                                     messageExt:(NSDictionary *)messageExt
{
    
    NSString *img_format = [NSData xy_contentTypeForImageData:imageData];
    XYGIMImageMessageBody *body = [[XYGIMImageMessageBody alloc] initWithData:imageData displayName:@"image.png"];
    if (img_format != nil) {
        NSString *f = [[img_format componentsSeparatedByString:@"/"] lastObject];
        if ([f isEqualToString:@"gif"] || [f isEqualToString:@"GIF"]) {
            body = [[XYGIMImageMessageBody alloc] initWithData:imageData displayName:@"image.gif"];
        }
    }
    /*
    NSString *from = [[EMClient sharedClient] currentUsername];
    EMMessage *message = [[EMMessage alloc] initWithConversationID:to from:from to:to body:body ext:messageExt];
    message.chatType = messageType;
    */
    XYGIMMessage *msg = [[XYGIMMessage alloc] init];
    msg.text = @"发送一张图片";
    msg.to = to;
    msg.chatType = messageType;
    msg.messageType = XYGIMMessageBodyTypeImage;
    msg.ext = messageExt;
    msg.body = body;
    return msg;
}

+ (XYGIMMessage *)sendImageMessageWithImage:(UIImage *)image
                                      to:(NSString *)to
                             messageType:(XYGIMChatType)messageType
                              messageExt:(NSDictionary *)messageExt
{
    NSData *data = UIImageJPEGRepresentation(image, 1);
    
    return [self sendImageMessageWithImageData:data to:to messageType:messageType messageExt:messageExt];
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
+(XYGIMMessage *)sendVoiceMessageWithLocalPath:(NSString *)localPath duration:(NSInteger)duration to:(NSString *)to messageType:(XYGIMChatType)messageType messageExt:(NSDictionary *)messageExt{
    XYGIMVoiceMessageBody *body = [[XYGIMVoiceMessageBody alloc] initWithLocalPath:localPath displayName:@"audio"];
    body.duration = (int)duration;
    XYGIMMessage *msg = [[XYGIMMessage alloc] init];
    msg.text = @"发送一条语音消息";
    msg.to = to;
    msg.chatType = messageType;
    msg.messageType = XYGIMMessageBodyTypeVoice;
    msg.ext = messageExt;
    msg.body = body;
    return msg;
}
@end
