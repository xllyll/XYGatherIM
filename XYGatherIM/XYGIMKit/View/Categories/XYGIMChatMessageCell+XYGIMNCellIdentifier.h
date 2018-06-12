//
//  FUChatMessageCell+FUNCellIdentifier.h
//  FUContact
//
//  Created by 杨卢银 on 16/6/30.
//  Copyright © 2016年 杨卢银. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XYGIMChatMessageCell.h"


@interface XYGIMChatMessageCell (XYGIMNCellIdentifier)

/**
 *  用来获取cellIdentifier
 *
 *  @param messageConfiguration 消息类型,需要传入两个key
 *  kXMNMessageConfigurationTypeKey     代表消息的类型
 *  kXMNMessageConfigurationOwnerKey    代表消息的所有者
 */
+ (NSString *)cellIdentifierForMessageConfiguration:(NSDictionary *)messageConfiguration;

@end
