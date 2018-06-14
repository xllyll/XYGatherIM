//
//  XYGIMVoiceMessageBody.m
//  XYGatherIM
//
//  Created by 杨卢银 on 2018/6/14.
//  Copyright © 2018年 杨卢银. All rights reserved.
//

#import "XYGIMVoiceMessageBody.h"

@implementation XYGIMVoiceMessageBody
-(instancetype)initWithLocalPath:(NSString *)aLocalPath url:(NSString *)url duration:(int)duration{
    self = [super init];
    if (self) {
        self.type = XYGIMMessageBodyTypeVoice;
        self.localPath = aLocalPath;
        self.remotePath = url;
        self.duration = duration;
    }
    return self;
}
@end
