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


-(NSString *)showTime{
    NSString *s = [[NSDate dateWithTimeIntervalInMilliSecondSince1970:_latestMessage.timestamp] formattedTime];
    if ([XYGIMClient sharedClient].libType == XYGIMLibTypeWangYiYun) {
        
    }
    return s;
}

@end
