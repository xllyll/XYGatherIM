//
//  XYGIMConversation.m
//  XYGatherIM
//
//  Created by 杨卢银 on 2018/6/13.
//  Copyright © 2018年 杨卢银. All rights reserved.
//

#import "XYGIMConversation.h"
#import "NSDate+XYDate.h"
#import "XYGIMClient.h"

@implementation XYGIMConversation

-(instancetype)initWithConversation:(id)conversation{
    Class a = nil;
    
    switch ([XYGIMClient sharedClient].libType) {
        case XYGIMLibTypeHuanXin:
            a = NSClassFromString(@"XYGIMHXConversation");
            break;
        case XYGIMLibTypeRongYun:
            a = NSClassFromString(@"XYGIMRYConversation");
            break;
        case XYGIMLibTypeJiGuang:
            a = NSClassFromString(@"XYGIMJGConversation");
            break;
        case XYGIMLibTypeWangYiYun:
            a = NSClassFromString(@"XYGIMWYYConversation");
            break;
        default:
            break;
    }
    self = [[a alloc] init];
    if (self) {
        self.conversation = conversation;
    }
    return self;
}
-(void)setConversation:(id)conversation{
    _conversation = conversation;
}
-(NSString *)showTime{
    NSString *s = [[NSDate dateWithTimeIntervalInMilliSecondSince1970:_latestMessage.timestamp] formattedTime];
    if ([XYGIMClient sharedClient].libType == XYGIMLibTypeWangYiYun) {
        
    }
    return s;
}

-(void)markAllMessagesAsRead:(XYError *__autoreleasing *)pError{
    
}

@end
