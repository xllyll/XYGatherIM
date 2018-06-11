//
//  XYWangYiYunCore.m
//  XYGatherIM
//
//  Created by 杨卢银 on 2018/6/8.
//  Copyright © 2018年 杨卢银. All rights reserved.
//

#import "XYWangYiYunLibCore.h"
#import <NIMSDK/NIMSDK.h>
#import "NSString+XYString.h"

@implementation XYWangYiYunLibCore
-(instancetype)init{
    self = [super init];
    if (self) {
        
        //配置额外配置信息 （需要在注册 appkey 前完成
        [[NIMSDKConfig sharedConfig] setShouldSyncUnreadCount:YES];
        [[NIMSDKConfig sharedConfig] setMaxAutoLoginRetryTimes:10];
        
        
        //推荐在程序启动的时候初始化 NIMSDK
        NSString *appKey        = @"45c6af3c98409b18a84451215d0bdd6e";
        NIMSDKOption *option    = [NIMSDKOption optionWithAppKey:appKey];
        option.apnsCername      = @"ENTERPRISE";
        option.pkCername        = @"DEMO_PUSH_KIT";
        [[NIMSDK sharedSDK] registerWithOption:option];
        
    }
    return self;
}
-(NSString *)version{
    XYLog(@"========= 网易云 IM =========");
    return [[NIMSDK sharedSDK] sdkVersion];
}
-(void)loginWithUsername:(NSString *)aUsername password:(NSString *)aPassword completion:(void (^)(NSString *, XYError *))aCompletionBlock{
    NSString *pass = aPassword;
    if ([[NIMSDK sharedSDK] isUsingDemoAppKey]) {
        pass = aPassword.md5_32_String;
    }
    [[[NIMSDK sharedSDK] loginManager] login:aUsername token:pass completion:^(NSError * _Nullable error) {
        if(error==nil){
            aCompletionBlock(aUsername,nil);
        }else{
            XYLog(@"%@", error.description);
            XYError *e = [XYError new];
            aCompletionBlock(nil,e);
        }
    }];
    
}
-(void)logOutWithCompletion:(void (^)(XYError *))aCompletionBlock{
    [[[NIMSDK sharedSDK] loginManager] logout:^(NSError * _Nullable error) {
        if(error==nil){
            aCompletionBlock(nil);
        }else{
            XYLog(@"%@", error.description);
            XYError *e = [XYError new];
            aCompletionBlock(e);
        }
    }];
}
@end
