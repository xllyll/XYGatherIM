//
//  XYGIMUser.h
//  XYGatherIM
//
//  Created by 杨卢银 on 2018/6/11.
//  Copyright © 2018年 杨卢银. All rights reserved.
//

#import <Foundation/Foundation.h>

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
@end
