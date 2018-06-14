//
//  XYGIMTextMessageBody.h
//  XYGatherIM
//
//  Created by 杨卢银 on 2018/6/14.
//  Copyright © 2018年 杨卢银. All rights reserved.
//

#import "XYGIMMessageBody.h"

@interface XYGIMTextMessageBody : XYGIMMessageBody
/**
 *  \~chinese
 *  文本内容
 *
 *  \~english
 *  Text content
 */
@property (nonatomic, copy, readonly) NSString *text;

/**
 *  \~chinese
 *  初始化文本消息体
 *
 *  @param aText   文本内容
 *
 *  @result 文本消息体实例
 */
- (instancetype)initWithText:(NSString *)aText;
@end
