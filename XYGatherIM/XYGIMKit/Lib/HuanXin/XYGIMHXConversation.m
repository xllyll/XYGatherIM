//
//  XYGIMHXConversation.m
//  XYGatherIM
//
//  Created by 杨卢银 on 2018/6/13.
//  Copyright © 2018年 杨卢银. All rights reserved.
//

#import "XYGIMHXConversation.h"
#import <Hyphenate/Hyphenate.h>

@interface XYGIMHXConversation ()
{
    EMConversation *_hx_conversation;
}
@end

@implementation XYGIMHXConversation

-(void)setConversation:(id)conversation{
    [super setConversation:conversation];
    _hx_conversation = (EMConversation*)conversation;
}
-(void)markAllMessagesAsRead:(XYError *__autoreleasing *)pError{
    EMError *error;
    [_hx_conversation markAllMessagesAsRead:&error];
}
@end
