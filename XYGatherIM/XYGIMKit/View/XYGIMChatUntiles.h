//
//  XYGIMChatUntiles.h
//  XYGatherIM
//
//  Created by 杨卢银 on 2018/6/12.
//  Copyright © 2018年 杨卢银. All rights reserved.
//

/**
 *  消息拥有者类型
 */
typedef NS_ENUM(NSUInteger, XYGIMNMessageOwner){
    XYGIMNMessageOwnerUnknown = 0 /**< 未知的消息拥有者 */,
    XYGIMNMessageOwnerSystem      /**< 系统消息 */,
    XYGIMNMessageOwnerSelf        /**< 自己发送的消息 */,
    XYGIMNMessageOwnerOther       /**< 接收到的他人消息 */,
};


/**
 *  消息聊天类型
 */
typedef NS_ENUM(NSUInteger, XYGIMNMessageChat){
    XYGIMNMessageChatSingle = 0 /**< 单人聊天,不显示nickname */,
    XYGIMNMessageChatGroup      /**< 群组聊天,显示nickname */,
};

/**
 *  消息类型
 */
typedef NS_ENUM(NSUInteger, XYGIMNMessageType){
    XYGIMNMessageTypeUnknow = 0 /**< 未知的消息类型 */,
    XYGIMNMessageTypeSystem /**< 系统消息 */,
    XYGIMNMessageTypeText /**< 文本消息 */,
    XYGIMNMessageTypeImage /**< 图片消息 */,
    XYGIMNMessageTypeImageExpress /**< 图片表情消息 */,
    XYGIMNMessageTypeVoice /**< 语音消息 */,
    XYGIMNMessageTypeLocation /**< 地理位置消息 */,
    XYGIMNMessageTypeLuckyMoney /**< 红包消息 */,
    XYGIMNMessageTypeVideo /**< 视频消息 */,
    XYGIMNMessageTypeAudio /**< 音频消息 */,
    XYGIMNMessageTypeCallVideo /**< 视频通话消息 */,
    XYGIMNMessageTypeCallAudio /**< 音频通话消息 */,
    
    XYGIMNMessageTypeFamilyTree /**< 家谱赠送消息 */,
    XYGIMNMessageTypeFamilyTreeInvitaion /**< 家谱邀请消息 */,
};

/**
 *  消息发送状态,自己发送的消息时有
 */
typedef NS_ENUM(NSUInteger, XYGIMNMessageSendState){
    XYGIMNMessageSendSuccess = 0 /**< 消息发送成功 */,
    XYGIMNMessageSendStateSending, /**< 消息发送中 */
    XYGIMNMessageSendFail /**< 消息发送失败 */,
};

/**
 *  消息读取状态,接收的消息时有
 */
typedef NS_ENUM(NSUInteger, XYGIMNMessageReadState) {
    XYGIMNMessageUnRead = 0 /**< 消息未读 */,
    XYGIMNMessageReading /**< 正在接收 */,
    XYGIMNMessageReaded /**< 消息已读 */,
};

/**
 *  录音消息的状态
 */
typedef NS_ENUM(NSUInteger, XYGIMNVoiceMessageState){
    XYGIMNVoiceMessageStateNormal,/**< 未播放状态 */
    XYGIMNVoiceMessageStateDownloading,/**< 正在下载中 */
    XYGIMNVoiceMessageStatePlaying,/**< 正在播放 */
    XYGIMNVoiceMessageStateCancel,/**< 播放被取消 */
};


/**
 *  XMNChatMessageCell menu对应action类型
 */
typedef NS_ENUM(NSUInteger, XYGIMNChatMessageCellMenuActionType) {
    XYGIMNChatMessageCellMenuActionTypeCopy, /**< 复制 */
    XYGIMNChatMessageCellMenuActionTypeRelay, /**< 转发 */
};


#pragma mark - XMNMessage 相关key值定义


/**
 *  消息key （FUMessage）
 */
static NSString *const kXYGIMNMessageConfigurationKey = @"com.xllyll.kXYGIMNMessageConfigurationKey";
/**
 *  消息类型的key
 */
static NSString *const kXYGIMNMessageConfigurationTypeKey = @"com.xllyll.kXYGIMNMessageConfigurationTypeKey";
/**
 *  消息拥有者的key
 */
static NSString *const kXYGIMNMessageConfigurationOwnerKey = @"com.xllyll.kXYGIMNMessageConfigurationOwnerKey";
/**
 *  消息群组类型的key
 */
static NSString *const kXYGIMNMessageConfigurationGroupKey = @"com.xllyll.kXYGIMNMessageConfigurationGroupKey";

/**
 *  消息昵称类型的key
 */
static NSString *const kXYGIMNMessageConfigurationNicknameKey = @"com.xllyll.kXYGIMNMessageConfigurationNicknameKey";

/**
 *  消息头像类型的key
 */
static NSString *const kXYGIMNMessageConfigurationAvatarKey = @"com.xllyll.kXYGIMNMessageConfigurationAvatarKey";

/**
 *  消息阅读状态类型的key
 */
static NSString *const kXYGIMNMessageConfigurationReadStateKey = @"com.Xxllyll.kXYGIMNMessageConfigurationReadStateKey";

/**
 *  消息发送状态类型的key
 */
static NSString *const kXYGIMNMessageConfigurationSendStateKey = @"com.xllyll.kXYGIMNMessageConfigurationSendStateKey";

/**
 *  文本消息内容的key
 */
static NSString *const kXYGIMNMessageConfigurationTextKey = @"com.xllyll.kXYGIMNMessageConfigurationTextKey";
/**
 *  图片消息内容的key
 */
static NSString *const kXYGIMNMessageConfigurationImageKey = @"com.xllyll.kXYGIMNMessageConfigurationImageKey";
/**
 *  语音消息内容的key
 */
static NSString *const kXYGIMNMessageConfigurationVoiceKey = @"com.xllyll.kXYGIMNMessageConfigurationVoiceKey";

/**
 *  视频消息时长key
 */
static NSString *const kXYGIMNMessageConfigurationVideoSecondsKey = @"com.xllyll.kXYGIMNMessageConfigurationVideoSecondsKey";

static NSString *const kXYGIMNMessageConfigurationVideoKey = @"com.xllyll.kXYGIMNMessageConfigurationVideoKey";

/**
 *  视频消息时长key
 */
static NSString *const kXYGIMNMessageConfigurationVoiceSecondsKey = @"com.xllyll.kXYGIMNMessageConfigurationVoiceSecondsKey";

/**
 *  地理位置消息内容的key
 */
static NSString *const kXYGIMNMessageConfigurationLocationKey = @"com.xllyll.kXYGIMNMessageConfigurationLocationKey";


