//
//  XYGIMConvertToCommonEmoticonsHelper.h
//  XYGatherIM
//
//  Created by 杨卢银 on 2018/6/13.
//  Copyright © 2018年 杨卢银. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XYGIMConvertToCommonEmoticonsHelper : NSObject
+ (NSString *)convertToCommonEmoticons:(NSString *)text;

+ (NSString *)convertToSystemEmoticons:(NSString *)text;
@end
