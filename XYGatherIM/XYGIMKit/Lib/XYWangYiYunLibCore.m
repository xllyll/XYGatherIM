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
#import "XYGIMFileCore+WangYiYun.h"
#import "XYGIMContactManagerWangYiYunImpl.h"

@interface XYWangYiYunLibCore()<NIMLoginManagerDelegate>
{
    XYGIMContactManagerWangYiYunImpl *_contactManagerImpl;
}
@end
@implementation XYWangYiYunLibCore

-(instancetype)init{
    self = [super init];
    if (self) {
        
        //配置额外配置信息 （需要在注册 appkey 前完成
        [[NIMSDKConfig sharedConfig] setShouldSyncUnreadCount:YES];
        [[NIMSDKConfig sharedConfig] setMaxAutoLoginRetryTimes:10];
        
        
        //推荐在程序启动的时候初始化 NIMSDK
        NSString *appKey        = K_WangYiYunIM_APPKEY;
        NIMSDKOption *option    = [NIMSDKOption optionWithAppKey:appKey];
        option.apnsCername      = K_WangYiYunIM_APNS_CerName;
        option.pkCername        = K_WangYiYunIM_PK_CerName;
        [[NIMSDK sharedSDK] registerWithOption:option];
        
        [[[NIMSDK sharedSDK] loginManager] addDelegate:self];
       
        _contactManagerImpl = [[XYGIMContactManagerWangYiYunImpl alloc] init];
        self.contactManager = _contactManagerImpl;
        
    }
    return self;
}
-(NSString *)version{
    XYLog(@"========= 网易云 IM =========");
    return [[NIMSDK sharedSDK] sdkVersion];
}
-(BOOL)isAutoLogin{
    XYGIMLoginData *data = [XYGIMFileCore getLoginData];
    if (data) {
        
        NIMAutoLoginData *loginData = [[NIMAutoLoginData alloc] init];
        loginData.account = data.account;
        loginData.token = data.password;
        
        [[[NIMSDK sharedSDK] loginManager] autoLogin:loginData];
        
        return YES;
    }
    return NO;
}

-(void)registerWithUsername:(NSString *)aUsername password:(NSString *)aPassword completion:(void (^)(NSString *, XYError *))aCompletionBlock{
    //[[[NIMSDK sharedSDK] userManager] user]
}
-(void)loginWithUsername:(NSString *)aUsername password:(NSString *)aPassword completion:(void (^)(NSString *, XYError *))aCompletionBlock{
    NSString *pass = aPassword;
    if ([[NIMSDK sharedSDK] isUsingDemoAppKey]) {
        pass = aPassword.md5_32_String;
    }
    [[[NIMSDK sharedSDK] loginManager] login:aUsername token:pass completion:^(NSError * _Nullable error) {
        if(error==nil){
            aCompletionBlock(aUsername,nil);
            
            XYGIMLoginData *data = [[XYGIMLoginData alloc] init];
            data.account = aUsername;
            data.password = pass;
            [XYGIMFileCore saveLoginData:data];
            
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

#pragma mark NIMLoginManagerDelegate
-(void)onLogin:(NIMLoginStep)step{
    XYLog(@"<网易云> onLogin:%ld",step);
}
-(void)onAutoLoginFailed:(NSError *)error{
    XYLog(@"<网易云> onAutoLoginFailed:%@",error.description);
}

@end
