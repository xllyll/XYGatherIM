//
//  XYGIMClient.m
//  XYGatherIM
//
//  Created by 杨卢银 on 2018/3/20.
//  Copyright © 2018年 杨卢银. All rights reserved.
//

#import "XYGIMClient.h"
#import "XYBaseLibCore.h"

@interface XYGIMClient()

@property(strong , nonatomic) XYBaseLibCore *libCore;

@end

@implementation XYGIMClient

+(instancetype)sharedClient{
    static XYGIMClient* _sharedUtils = nil;
    static dispatch_once_t _once;
    dispatch_once(&_once, ^{
        _sharedUtils = [[self alloc] init];
    });
    return _sharedUtils;
}

-(void)initWithType:(XYGIMLibType)libType{
    if (_libCore==nil) {
        //_libCore = [[XYBaseLibCore alloc] init];
        
        Class a = nil;
        
        switch (libType) {
            case XYGIMLibTypeHuanXin:
                a = NSClassFromString(@"XYHuanXinLibCore");
                break;
            case XYGIMLibTypeRongYun:
                
                a = NSClassFromString(@"XYRongYunLibCore");
                break;
                
            case XYGIMLibTypeJiGuang:
                
                a = NSClassFromString(@"XYJiGuangLibCore");
                break;
            case XYGIMLibTypeWangYiYun:
                
                a = NSClassFromString(@"XYWangYiYunLibCore");
                break;
                
            default:
                break;
        }
        
        _libCore = [[a alloc] init];
    }
}
-(NSString *)version{
    
    return _libCore.version;
}

// APP进入后台
- (void)applicationDidEnterBackground:(UIApplication *)application{
    [_libCore applicationDidEnterBackground:application];
}
// APP将要从后台返回
- (void)applicationWillEnterForeground:(UIApplication *)application{
    [_libCore applicationWillEnterForeground:application];
}

-(void)loginWithUsername:(NSString *)aUsername password:(NSString *)aPassword completion:(void (^)(NSString *, XYError *))aCompletionBlock{
    [_libCore loginWithUsername:aUsername password:aPassword completion:aCompletionBlock];
}
@end
