//
//  XYGIMContactManagerImpl.m
//  XYGatherIM
//
//  Created by 杨卢银 on 2018/6/11.
//  Copyright © 2018年 杨卢银. All rights reserved.
//

#import "XYGIMContactManagerImpl.h"
#import <NIMSDK/NIMSDK.h>
@interface XYGIMContactManagerImpl()

@property (nonatomic,strong,readonly)   id<NIMUserManager> usermaner;
//@property (strong , nonatomic) NIMUsera
@end
@implementation XYGIMContactManagerImpl
-(instancetype)init{
    self = [super init];
    if (self) {
        _usermaner = [[NIMSDK sharedSDK] userManager];
    }
    return self;
}
@end
