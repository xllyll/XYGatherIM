//
//  XYGIMVoiceMessageBody.h
//  XYGatherIM
//
//  Created by 杨卢银 on 2018/6/14.
//  Copyright © 2018年 杨卢银. All rights reserved.
//

#import "XYGIMFileMessageBody.h"


/**
 语音消息体
 */
@interface XYGIMVoiceMessageBody : XYGIMFileMessageBody
/*!
 *  \~chinese
 *  语音时长, 秒为单位
 *
 *  \~english
 *  Voice duration, in seconds
 */
@property (nonatomic) int duration;

-(instancetype)initWithLocalPath:(NSString *)aLocalPath url:(NSString *)url duration:(int)duration;
@end
