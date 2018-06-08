//
//  XYGIMEmotion.m
//  XYGatherIM
//
//  Created by 杨卢银 on 2018/4/9.
//  Copyright © 2018年 杨卢银. All rights reserved.
//

#import "XYGIMEmotion.h"

@implementation XYGIMEmotion

- (id)initWithName:(NSString*)emotionTitle
         emotionId:(NSString*)emotionId
  emotionThumbnail:(NSString*)emotionThumbnail
   emotionOriginal:(NSString*)emotionOriginal
emotionOriginalURL:(NSString*)emotionOriginalURL
       emotionType:(XYGIMEmotionType)emotionType{
    self = [super init];
    if (self) {
        _emotionId = emotionId;
        _emotionTitle = emotionTitle;
        _emotionType = emotionType;
        _emotionOriginal = emotionOriginal;
        _emotionThumbnail = emotionThumbnail;
        _emotionOriginalURL = emotionOriginalURL;
    }
    return self;
}

@end
