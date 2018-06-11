//
//  XYGIMClient.m
//  XYGatherIM
//
//  Created by 杨卢银 on 2018/3/20.
//  Copyright © 2018年 杨卢银. All rights reserved.
//

#import "XYGIMClient.h"

@interface XYGIMClient()

@end

@implementation XYGIMClient

static XYGIMLibType _static_lib_type;

+(void)initIMType:(XYGIMLibType)libtype{
    _static_lib_type = libtype;
}

+(instancetype)sharedClient{
    static XYGIMClient* _sharedUtils = nil;
    static dispatch_once_t _once;
    dispatch_once(&_once, ^{
        _sharedUtils = [[self alloc] initSDK];
    });
    return _sharedUtils;
}
-(instancetype)initSDK{
    
    Class a = nil;
    
    switch (_static_lib_type) {
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
            
            a = NSClassFromString(@"XYHuanXinLibCore");
            
            break;
    }
    self = [[a alloc] init];
    if (self) {
        _libType = _static_lib_type;
    }
    return self;
}

-(NSString *)currentUser{
    return @"";
}
-(NSString *)version{
    
    return @"";
}
-(BOOL)isAutoLogin{
    return NO;
}
-(BOOL)isLoggedIn{
    return NO;
}
-(BOOL)isConnected{
    return NO;
}
- (void)applicationDidEnterBackground:(UIApplication *)application{
    
}
-(void)applicationWillEnterForeground:(UIApplication *)application{
    
}
-(void)registerWithUsername:(NSString *)aUsername password:(NSString *)aPassword completion:(void (^)(NSString *, XYError *))aCompletionBlock{
    
}
-(void)loginWithUsername:(NSString *)aUsername password:(NSString *)aPassword completion:(void (^)(NSString *, XYError *))aCompletionBlock{
    
}
-(void)loginOut:(void (^)(XYError *))aCompletionBlock{
    
}
@end
