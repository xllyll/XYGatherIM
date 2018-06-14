//
//  XYGIMLocationMessageBody.m
//  XYGatherIM
//
//  Created by 杨卢银 on 2018/6/14.
//  Copyright © 2018年 杨卢银. All rights reserved.
//

#import "XYGIMLocationMessageBody.h"

@implementation XYGIMLocationMessageBody

-(instancetype)initWithLatitude:(double)aLatitude longitude:(double)aLongitude address:(NSString *)aAddress{
    self = [super init];
    if (self) {
        self.type = XYGIMMessageBodyTypeLocation;
        _latitude = aLatitude;
        _longitude = aLongitude;
        _address = aAddress;
    }
    return self;
}

@end
