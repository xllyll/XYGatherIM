//
//  XYGIMImageMessageBody.m
//  XYGatherIM
//
//  Created by 杨卢银 on 2018/6/14.
//  Copyright © 2018年 杨卢银. All rights reserved.
//

#import "XYGIMImageMessageBody.h"

@implementation XYGIMImageMessageBody

-(instancetype)initWithData:(NSData *)aData thumbnailData:(NSData *)aThumbnailData{
    self = [super init];
    if (self) {
        self.type = XYGIMMessageBodyTypeImage;
    }
    return self;
}
-(instancetype)initWithPath:(NSString *)aPath thumbnailPath:(NSString *)aThumbnailPath{
    self = [super init];
    if (self) {
        self.type = XYGIMMessageBodyTypeImage;
        self.localPath = aPath;
        self.thumbnailLocalPath = aThumbnailPath;
    }
    return self;
}
@end
