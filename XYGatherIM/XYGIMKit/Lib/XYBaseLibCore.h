//
//  XYBaseLibCore.h
//  XYGatherIM
//
//  Created by 杨卢银 on 2018/3/20.
//  Copyright © 2018年 杨卢银. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XYError.h"
#import "XYGIMConfig.h"

@interface XYBaseLibCore : NSObject

@property(copy,readonly,nonatomic)NSString *version;

// APP进入后台
- (void)applicationDidEnterBackground:(UIApplication *)application;
// APP将要从后台返回
- (void)applicationWillEnterForeground:(UIApplication *)application;


/**
 * 登录
 */
- (void)loginWithUsername:(NSString *)aUsername
                 password:(NSString *)aPassword
               completion:(void (^)(NSString *aUsername, XYError *aError))aCompletionBlock;

@end
