//
//  XYGIMUser.h
//  XYGatherIM
//
//  Created by 杨卢银 on 2018/6/11.
//  Copyright © 2018年 杨卢银. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  用户资料，仅当用户选择托管信息到云信时有效
 */
@interface XYGIMUserInfo : NSObject

/**
 *  用户昵称
 */
@property (nullable,nonatomic,copy,readonly) NSString *nickName;

/**
 *  用户头像
 */
@property (nullable,nonatomic,copy,readonly) NSString *avatarUrl;
/**
 *  用户头像缩略图
 *  @discussion 仅适用于使用云信上传服务进行上传的资源，否则无效。
 */
@property (nullable,nonatomic,copy,readonly) NSString *thumbAvatarUrl;

/**
 *  用户签名
 */
@property (nullable,nonatomic,copy,readonly) NSString *sign;

/**
 *  用户性别
 */
@property (nonatomic,assign,readonly) NSInteger gender;

/**
 *  邮箱
 */
@property (nullable,nonatomic,copy,readonly) NSString *email;

/**
 *  生日
 */
@property (nullable,nonatomic,copy,readonly) NSString *birth;

/**
 *  电话号码
 */
@property (nullable,nonatomic,copy,readonly) NSString *mobile;

/**
 *  用户自定义扩展字段
 */
@property (nullable,nonatomic,copy,readonly) NSString *ext;

@end

@interface XYGIMUser : NSObject
/**
 *  用户Id
 */
@property (nullable,nonatomic,copy)   NSString    *userId;

/**
 *  备注名，长度限制为128个字符。
 */
@property (nullable,nonatomic,copy)   NSString    *alias;

/**
 *  扩展字段
 */
@property (nullable,nonatomic,copy)   NSString  *ext;

@property (nullable,nonatomic,strong) XYGIMUserInfo *userInfo;
@end
