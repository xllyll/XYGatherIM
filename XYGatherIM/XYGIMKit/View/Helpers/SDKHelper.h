//
//  SDKHelper.h
//  XYGatherIM
//
//  Created by 杨卢银 on 2018/6/13.
//  Copyright © 2018年 杨卢银. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XYGIMMessage.h"
#import "XYGIMConvertToCommonEmoticonsHelper.h"

@interface SDKHelper : NSObject

#pragma mark - send message

+ (XYGIMMessage *)sendTextMessage:(NSString *)text
                               to:(NSString *)to
                      messageType:(XYGIMChatType)messageType
                       messageExt:(NSDictionary *)messageExt;


+ (XYGIMMessage *)sendImageMessageWithImageData:(NSData *)imageData
                                             to:(NSString *)to
                                    messageType:(XYGIMChatType)messageType
                                     messageExt:(NSDictionary *)messageExt;

+ (XYGIMMessage *)sendImageMessageWithImage:(UIImage *)image
                                         to:(NSString *)to
                                messageType:(XYGIMChatType)messageType
                                 messageExt:(NSDictionary *)messageExt;


+ (XYGIMMessage *)sendLocationMessageWithLatitude:(double)latitude
                                        longitude:(double)longitude
                                          address:(NSString *)address
                                               to:(NSString *)to
                                      messageType:(XYGIMChatType)messageType
                                       messageExt:(NSDictionary *)messageExt;
@end
