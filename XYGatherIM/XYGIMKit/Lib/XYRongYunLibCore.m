//
//  XYRongYunLibCore.m
//  XYGatherIM
//
//  Created by 杨卢银 on 2018/3/20.
//  Copyright © 2018年 杨卢银. All rights reserved.
//

#import "XYRongYunLibCore.h"
#import <RongIMKit/RongIMKit.h>

@interface XYRongYunLibCore ()

@property (strong , nonatomic) RCIM *rcIM;
@property (strong , nonatomic) RCIMClient *client;

@end


@implementation XYRongYunLibCore

-(instancetype)init{
    self = [super init];
    if (self) {
        _rcIM = [RCIM sharedRCIM];
        _client = [RCIMClient sharedRCIMClient];
    }
    return self;
}
-(NSString *)version{
    return [_client getSDKVersion];
}

@end
