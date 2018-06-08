//
//  XYGIMClient.h
//  XYGatherIM
//
//  Created by 杨卢银 on 2018/3/20.
//  Copyright © 2018年 杨卢银. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XYError.h"

typedef enum XYGIMLibType
{
    XYGIMLibTypeHuanXin   = 0,/**< 环信IMSDK*/
    
    XYGIMLibTypeRongYun   = 1,/**< 融云IMSDK*/
    
    XYGIMLibTypeJiGuang   = 2, /**< 极光IMSDK*/
    
    XYGIMLibTypeWangYiYun = 3 /**< 极光IMSDK*/
    
} XYGIMLibType;

@interface XYGIMClient : NSObject

+(instancetype)sharedClient;
/**
 初始化方法

 @param libType 聊天服务类型
 */
-(void)initWithType:(XYGIMLibType)libType;

/**
 聊天服务类型
 */
@property(assign,nonatomic)XYGIMLibType libType;
/**
 聊天服务版本
 */
@property(copy ,readonly ,nonatomic)NSString *version;


#pragma mark FFF
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
