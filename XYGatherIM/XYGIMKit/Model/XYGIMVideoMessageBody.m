//
//  XYGIMVideoMessageBody.m
//  XYGatherIM
//
//  Created by 杨卢银 on 2018/6/14.
//  Copyright © 2018年 杨卢银. All rights reserved.
//

#import "XYGIMVideoMessageBody.h"

@implementation XYGIMVideoMessageBody
-(instancetype)initWithLocalPath:(NSString *)aLocalPath displayName:(NSString *)aDisplayName{
    self = [super initWithLocalPath:aLocalPath displayName:aDisplayName];
    if (self) {
        self.type = XYGIMMessageBodyTypeVideo;
    }
    return self;
}
@end
