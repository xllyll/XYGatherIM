//
//  XYGIMContactManagerImpl.m
//  XYGatherIM
//
//  Created by 杨卢银 on 2018/6/11.
//  Copyright © 2018年 杨卢银. All rights reserved.
//

#import "XYGIMContactManagerWangYiYunImpl.h"
#import <NIMSDK/NIMSDK.h>
#import "MJExtension.h"
@interface XYGIMContactManagerWangYiYunImpl()

@property (nonatomic,strong,readonly)   id<NIMUserManager> usermaner;

@end
@implementation XYGIMContactManagerWangYiYunImpl
-(instancetype)init{
    self = [super init];
    if (self) {
        _usermaner = [[NIMSDK sharedSDK] userManager];
    }
    return self;
}
-(NSArray<XYGIMUser *> *)getContacts{
    NSArray *list = _usermaner.myFriends;
    NSMutableArray *array = [NSMutableArray array];
    if (list) {
        for (NIMUser *u in list) {
            XYGIMUser *user = [[XYGIMUser alloc] init];
            user.userId = u.userId;
            user.alias = u.alias;
            user.ext = u.ext;
            
            NSDictionary *dic = u.userInfo.mj_keyValues;
            XYGIMUserInfo *info = [XYGIMUserInfo mj_objectWithKeyValues:dic];
            user.userInfo = info;
            
            [array addObject:user];
        }
    }
    return array;
}
@end
