//
//  XYHuanXinLibCore.m
//  XYGatherIM
//
//  Created by 杨卢银 on 2018/3/20.
//  Copyright © 2018年 杨卢银. All rights reserved.
//

#import "XYHuanXinLibCore.h"
#import <Hyphenate/Hyphenate.h>

@interface XYHuanXinLibCore()

@property (strong, nonatomic) EMClient *client;

@end

@implementation XYHuanXinLibCore

-(instancetype)init{
    self = [super init];
    if (self) {
        
        //AppKey:注册的AppKey，详细见下面注释。
        //apnsCertName:推送证书名（不需要加后缀），详细见下面注释。
        EMOptions *options = [EMOptions optionsWithAppkey:@"easemob-demo#chatdemoui"];
        NSString *apnsCertName = nil;
#if DEBUG
        apnsCertName = @"chatdemoui_dev";
#else
        apnsCertName = @"chatdemoui";
#endif
        options.apnsCertName = apnsCertName;
        
        _client = [EMClient sharedClient];
        
        EMError *error = [_client initializeSDKWithOptions:options];
        if(error==nil){
            XYLog(@"环信IM 初始化成功");
        }
        
    }
    return self;
}

-(NSString *)version{
    return _client.version;
}
// APP进入后台
- (void)applicationDidEnterBackground:(UIApplication *)application{
    [[EMClient sharedClient] applicationDidEnterBackground:application];
}
// APP将要从后台返回
- (void)applicationWillEnterForeground:(UIApplication *)application{
    [[EMClient sharedClient] applicationWillEnterForeground:application];
}

-(void)loginWithUsername:(NSString *)aUsername password:(NSString *)aPassword completion:(void (^)(NSString *, XYError *))aCompletionBlock{
    
    [_client loginWithUsername:aUsername password:aPassword completion:^(NSString *theUserName, EMError *aError) {
        if(aError==nil){
            aCompletionBlock(theUserName,nil);
        }else{
            XYLog(@"%@", aError.errorDescription);
            XYError *e = [XYError new];
            aCompletionBlock(nil,e);
        }
    }];
}
-(void)logOutWithCompletion:(void (^)(XYError *))aCompletionBlock{
    [_client logout:YES completion:^(EMError *aError) {
        if(aError==nil){
            aCompletionBlock(nil);
        }else{
            XYLog(@"%@", aError.errorDescription);
            XYError *e = [XYError new];
            aCompletionBlock(e);
        }
    }];
}
@end
