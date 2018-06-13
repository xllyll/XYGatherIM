//
//  XYGIMHXMessage.m
//  XYGatherIM
//
//  Created by 杨卢银 on 2018/6/13.
//  Copyright © 2018年 杨卢银. All rights reserved.
//

#import "XYGIMHXMessage.h"
#import <Hyphenate/Hyphenate.h>

@interface XYGIMHXMessage ()
{
    EMMessage *_msg;
}
@end

@implementation XYGIMHXMessage

-(void)setMessage:(id)message{
    [super setMessage:message];
    _msg = message;
}

@end
