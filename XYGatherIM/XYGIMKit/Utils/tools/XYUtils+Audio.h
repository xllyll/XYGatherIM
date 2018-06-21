//
//  XYUtils+Audio.h
//  XYGatherIM
//
//  Created by 杨卢银 on 2018/6/21.
//  Copyright © 2018年 杨卢银. All rights reserved.
//

#import "XYUtils.h"
typedef NS_ENUM(NSInteger, XYSoundVolumeLevel) {
    kXYSoundVolumeLevelHight = 13,
    kXYSoundVolumeLevelMiddle = 8,
    kXYSoundVolumeLevelLow = 3,
    kXYSoundVolumeLevelMute = 0
};

@interface XYUtils (Audio)

//是否支持声音输入
+ (BOOL)hasMicphone;

//系统音量，只能有用户设置，分为16个等级，返回值范围为：0-1
+ (float)currentVolumn;

+ (NSInteger)currentVolumeLevel;

+ (void)playShortSound:(NSString *)soundName soundExtension:(NSString *)soundExtension;

// 播放接收到新消息时的声音
+ (void)playNewMessageSound;

//播放发送消息成功时的声音
+ (void)playSendMessageSound;

// 震动
+ (void)playVibration;

+ (void)playNewMessageSoundAndVibration;

+ (void)configAudioSessionForPlayback;

@end
