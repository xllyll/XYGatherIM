//
//  XYGIMTextMessageBody.m
//  XYGatherIM
//
//  Created by 杨卢银 on 2018/6/14.
//  Copyright © 2018年 杨卢银. All rights reserved.
//

#import "XYGIMTextMessageBody.h"

@implementation XYGIMTextMessageBody

-(instancetype)initWithText:(NSString *)aText{
    self = [super init];
    if (self) {
        self.type = XYGIMMessageBodyTypeText;
        _text = aText;
    }
    return self;
}

@end
