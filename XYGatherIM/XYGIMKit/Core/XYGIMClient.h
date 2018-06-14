//
//  XYGIMClient.h
//  XYGatherIM
//
//  Created by 杨卢银 on 2018/3/20.
//  Copyright © 2018年 杨卢银. All rights reserved.
//  address : https://github.com/xllyll/XYGatherIM
//

#import <UIKit/UIKit.h>
#import "XYError.h"
#import "XYGIMChatManager.h"
#import "XYGIMContactManager.h"
#import "XYGIMConfig.h"

typedef enum XYGIMLibType
{
    XYGIMLibTypeHuanXin   = 0,/**< 环信IMSDK*/
    
    XYGIMLibTypeRongYun   = 1,/**< 融云IMSDK*/
    
    XYGIMLibTypeJiGuang   = 2, /**< 极光IMSDK*/
    
    XYGIMLibTypeWangYiYun = 3 /**< 极光IMSDK*/
    
} XYGIMLibType;

@interface XYGIMClient : NSObject
+(void)initIMType:(XYGIMLibType)libtype;
+(instancetype)sharedClient;


/**
 聊天服务类型
 */
@property(assign,nonatomic)XYGIMLibType libType;

/**
 当前用户
 */
@property(copy,nonatomic)NSString *currentUsername;
/**
 聊天服务版本
 */
@property(copy ,readonly ,nonatomic)NSString *version;

@property (assign , nonatomic) BOOL isAutoLogin;
/*!
 *  \~chinese
 *  用户是否已登录
 *
 *  \~english
 *  If a user logged in
 */
@property (nonatomic, readonly) BOOL isLoggedIn;

/*!
 *  \~chinese
 *  是否连上聊天服务器
 *
 *  \~english
 *  Connection status to Hyphenate IM server
 */
@property (nonatomic, readonly) BOOL isConnected;


@property (assign , nonatomic) id<XYGIMContactManager> contactManager;
@property (assign , nonatomic) id<XYGIMChatManager> chatManager;

#pragma mark FFF
// APP进入后台
- (void)applicationDidEnterBackground:(UIApplication *)application;
// APP将要从后台返回
- (void)applicationWillEnterForeground:(UIApplication *)application;


/**
 注册

 @param aUsername 用户名
 @param aPassword 用户密码
 @param aCompletionBlock 回调
 */
- (void)registerWithUsername:(NSString *)aUsername
                    password:(NSString *)aPassword
                  completion:(void (^)(NSString *aUsername, XYError *aError))aCompletionBlock;
/**
 * 登录
 */
- (void)loginWithUsername:(NSString *)aUsername
                 password:(NSString *)aPassword
               completion:(void (^)(NSString *aUsername, XYError *aError))aCompletionBlock;

- (void)loginOut:(void (^)(XYError *aError))aCompletionBlock;
@end
