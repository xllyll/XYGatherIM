//
//  NSString+XYString.h
//  XYGatherIM
//
//  Created by 杨卢银 on 2018/4/16.
//  Copyright © 2018年 杨卢银. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (XYString)

/**
 *  MD5 加密字符串
 *
 *  @return MD5
 */
-(NSString *)md5String;
/**
 *  MD5 加密字符串(32)
 *
 *  @return MD5
 */
-(NSString *)md5_32_String;

@end
