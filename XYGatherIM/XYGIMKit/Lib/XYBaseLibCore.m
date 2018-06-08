//
//  XYBaseLibCore.m
//  XYGatherIM
//
//  Created by 杨卢银 on 2018/3/20.
//  Copyright © 2018年 杨卢银. All rights reserved.
//

#import "XYBaseLibCore.h"

@implementation XYBaseLibCore

-(instancetype)init{
    self = [super init];
    if (self) {
    }
    return self;
}
-(NSString *)version{
    return @"未知版本";
}



// APP进入后台
- (void)applicationDidEnterBackground:(UIApplication *)application{
    
}
// APP将要从后台返回
- (void)applicationWillEnterForeground:(UIApplication *)application{
    
}


-(void)loginWithUsername:(NSString *)aUsername password:(NSString *)aPassword completion:(void (^)(NSString *, XYError *))aCompletionBlock{
    
}
@end
