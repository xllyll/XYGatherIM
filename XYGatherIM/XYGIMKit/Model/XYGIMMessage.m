//
//  XYGIMMessage.m
//  XYGatherIM
//
//  Created by 杨卢银 on 2018/6/11.
//  Copyright © 2018年 杨卢银. All rights reserved.
//

#import "XYGIMMessage.h"
#import "XYGIMClient.h"

@implementation XYGIMMessage
-(instancetype)init{
    self = [super init];
    if (self) {
        _timestamp = [[NSDate date] timeIntervalSince1970];
    }
    return self;
}
-(instancetype)initWithMessage:(id)aMessage{
    
    Class a = nil;
    switch ([XYGIMClient sharedClient].libType) {
        case XYGIMLibTypeHuanXin:
            a = NSClassFromString(@"XYGIMHXMessage");
            break;
        case XYGIMLibTypeRongYun:
            
            a = NSClassFromString(@"XYGIMRYMessage");
            break;
            
        case XYGIMLibTypeJiGuang:
            
            a = NSClassFromString(@"XYGIMJGMessage");
            break;
        case XYGIMLibTypeWangYiYun:
            
            a = NSClassFromString(@"XYGIMWYYMessage");
            
            break;
            
        default:
            
            a = NSClassFromString(@"XYHuanXinLibCore");
            
            break;
    }
    self = [[a alloc] init];
    if (self) {
        self.message = aMessage;
    }
    return self;
}
-(void)setMessage:(id)message{
    _message = message;
}
@end
