//
//  XYGIMContactManager.h
//  XYGatherIM
//
//  Created by 杨卢银 on 2018/6/11.
//  Copyright © 2018年 杨卢银. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XYGIMUser.h"

@protocol XYGIMContactManager <NSObject>
#pragma mark - Contact Operations

/*!
 *  \~chinese
 *  获取本地存储的所有好友
 *
 *  @result 好友列表<NSString>
 *
 *  \~english
 *  Get all contacts from local database
 *
 *  @result Contact list<String>
 */
- (NSArray<XYGIMUser*> *)getContacts;

@end
