//
//  XYGIMFileMessageBody.m
//  XYGatherIM
//
//  Created by 杨卢银 on 2018/6/14.
//  Copyright © 2018年 杨卢银. All rights reserved.
//

#import "XYGIMFileMessageBody.h"

@implementation XYGIMFileMessageBody

-(instancetype)initWithLocalPath:(NSString *)aLocalPath displayName:(NSString *)aDisplayName{
    self = [super init];
    if (self) {
        self.type = XYGIMMessageBodyTypeFile;
        self.localPath = aLocalPath;
    }
    return self;
}
-(instancetype)initWithData:(NSData *)aData displayName:(NSString *)aDisplayName{
    self = [super init];
    if (self) {
        self.data = aData;
        self.displayName = aDisplayName;
    }
    return self;
}

@end
