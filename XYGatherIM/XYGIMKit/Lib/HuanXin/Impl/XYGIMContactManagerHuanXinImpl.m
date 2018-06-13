//
//  XYGIMContactManagerHuanXinImpl.m
//  XYGatherIM
//
//  Created by 杨卢银 on 2018/6/11.
//  Copyright © 2018年 杨卢银. All rights reserved.
//

#import "XYGIMContactManagerHuanXinImpl.h"
#import <Hyphenate/Hyphenate.h>

@interface XYGIMContactManagerHuanXinImpl()

@property (nonatomic,strong,readonly)   id<IEMContactManager> usermaner;

@end

@implementation XYGIMContactManagerHuanXinImpl

-(instancetype)init{
    self = [super init];
    if (self) {
        _usermaner = [[EMClient sharedClient] contactManager];
    }
    return self;
}
-(NSArray<XYGIMUser *> *)getContacts{
    return _usermaner.getContacts;
}
@end
