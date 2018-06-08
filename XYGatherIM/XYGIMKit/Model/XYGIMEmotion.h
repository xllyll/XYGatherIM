//
//  XYGIMEmotion.h
//  XYGatherIM
//
//  Created by 杨卢银 on 2018/4/9.
//  Copyright © 2018年 杨卢银. All rights reserved.
//

#import <UIKit/UIKit.h>

#define EASEUI_EMOTION_DEFAULT_EXT @"em_emotion"

#define MESSAGE_ATTR_IS_BIG_EXPRESSION @"em_is_big_expression"
#define MESSAGE_ATTR_EXPRESSION_ID @"em_expression_id"

typedef NS_ENUM(NSUInteger, XYGIMEmotionType) {
    XYGIMEmotionDefault = 0,//默认表情
    XYGIMEmotionPng,//
    XYGIMEmotionGif//大表情或者Gif表情
};

@interface XYGIMEmotion : NSObject


/*!
 @property
 @brief 表情类型
 */
@property (nonatomic, assign) XYGIMEmotionType emotionType;

/*!
 @property
 @brief 表情文字
 */
@property (nonatomic, copy) NSString *emotionTitle;

/*!
 @property
 @brief 表情Id
 */
@property (nonatomic, copy) NSString *emotionId;

/*!
 @property
 @brief 表情本地缩略图地址
 */
@property (nonatomic, copy) NSString *emotionThumbnail;

/*!
 @property
 @brief 表情本地原始图片地址
 */
@property (nonatomic, copy) NSString *emotionOriginal;

/*!
 @property
 @brief 表情本地原始网络地址
 */
@property (nonatomic, copy) NSString *emotionOriginalURL;

- (id)initWithName:(NSString*)emotionTitle
         emotionId:(NSString*)emotionId
  emotionThumbnail:(NSString*)emotionThumbnail
   emotionOriginal:(NSString*)emotionOriginal
emotionOriginalURL:(NSString*)emotionOriginalURL
       emotionType:(XYGIMEmotionType)emotionType;

@end
