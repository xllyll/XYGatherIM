//
//  FUChatMessageCell+FUNCellIdentifier.m
//  FUContact
//
//  Created by 杨卢银 on 16/6/30.
//  Copyright © 2016年 杨卢银. All rights reserved.
//

#import "XYGIMChatMessageCell+XYGIMNCellIdentifier.h"

@implementation XYGIMChatMessageCell(XYGIMNCellIdentifier)

/**
 *  用来获取cellIdentifier
 *
 *  @param messageConfiguration 消息类型,需要传入两个key
 *  kXMNMessageConfigurationTypeKey     代表消息的类型
 *  kXMNMessageConfigurationOwnerKey    代表消息的所有者
 */
+ (NSString *)cellIdentifierForMessageConfiguration:(NSDictionary *)messageConfiguration {
    XYGIMNMessageType messageType = [messageConfiguration[kXYGIMNMessageConfigurationTypeKey] integerValue];
    XYGIMNMessageOwner messageOwner = [messageConfiguration[kXYGIMNMessageConfigurationOwnerKey] integerValue];
    XYGIMNMessageChat messageChat = [messageConfiguration[kXYGIMNMessageConfigurationGroupKey] integerValue];
    NSString *identifierKey = @"XYGIMChatMessageCell";
    NSString *ownerKey;
    NSString *typeKey;
    NSString *groupKey;
    switch (messageOwner) {
        case XYGIMNMessageOwnerSystem:
            ownerKey = @"OwnerSystem";
            break;
        case XYGIMNMessageOwnerOther:
            ownerKey = @"OwnerOther";
            break;
        case XYGIMNMessageOwnerSelf:
            ownerKey = @"OwnerSelf";
            break;
        default:
            NSAssert(NO, @"Message Owner Unknow");
            break;
    }
    switch (messageType) {
        case XYGIMNMessageTypeVoice:
            typeKey = @"VoiceMessage";
            break;
        case XYGIMNMessageTypeImage:
            typeKey = @"ImageMessage";
            break;
        case XYGIMNMessageTypeImageExpress:
            typeKey = @"ImageExpressMessage";
            break;
        case XYGIMNMessageTypeLocation:
            typeKey = @"LocationMessage";
            break;
        case XYGIMNMessageTypeSystem:
            typeKey = @"SystemMessage";
            break;
        case XYGIMNMessageTypeText:
            typeKey = @"TextMessage";
            break;
        case XYGIMNMessageTypeLuckyMoney:
            typeKey = @"LuckyMoneyMessage";
            break;
        case XYGIMNMessageTypeVideo:
            typeKey = @"VideoMessage";
            break;
        case XYGIMNMessageTypeAudio:
            typeKey = @"AudioMessage";
            break;
        case XYGIMNMessageTypeCallVideo:
            typeKey = @"CallVideoMessage";
            break;
        case XYGIMNMessageTypeCallAudio:
            typeKey = @"CallAudioMessage";
            break;
        case XYGIMNMessageTypeFamilyTree:
            typeKey = @"FamilyTreeMessage";
            break;
        case XYGIMNMessageTypeFamilyTreeInvitaion:
            typeKey = @"FamilyTreeMessage";
            break;
        default:
            NSAssert(NO, @"Message Type Unknow");
            break;
    }
    switch (messageChat) {
        case XYGIMNMessageChatGroup:
            groupKey = @"GroupCell";
            break;
        case XYGIMNMessageChatSingle:
            groupKey = @"SingleCell";
            break;
        default:
            groupKey = @"";
            break;
    }
    
    return [NSString stringWithFormat:@"%@_%@_%@_%@",identifierKey,ownerKey,typeKey,groupKey];
}

@end
