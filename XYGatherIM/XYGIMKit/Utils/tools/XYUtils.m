//
//  XYUtils.m
//  XYGatherIM
//
//  Created by 杨卢银 on 2018/4/16.
//  Copyright © 2018年 杨卢银. All rights reserved.
//

#import "XYUtils.h"
#include <CommonCrypto/CommonDigest.h>

@implementation XYUtils

/**
 *  MD5加密（16位）
 *
 *  @param string 字符串
 *
 *  @return md5加密字符串
 */
+(NSString *)md5:(NSString *)string
{
    //NSData *data = [string dataUsingEncoding:NSUTF8StringEncoding];
    
    //提取32位MD5散列的中间16位
    NSString *md5_32Bit_String=[self getMd5_32Bit_String:string];
    NSString *result = [[md5_32Bit_String substringToIndex:24] substringFromIndex:8];//即9～25位
    
    return result;
}

+(NSString *)md5_32:(NSString *)string{
    NSString *md5_32Bit_String=[self getMd5_32Bit_String:string];
    return md5_32Bit_String;
}
+(NSString *)getMd5_32Bit_String:(NSString *)srcString{
    const char *cStr = [srcString UTF8String];
    unsigned char digest[CC_MD5_DIGEST_LENGTH];
    //CC_MD5( cStr, strlen(cStr), digest );
    CC_MD5( cStr, (CC_LONG)strlen(cStr), digest);
    NSMutableString *result = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH *2];
    for(int i =0; i < CC_MD5_DIGEST_LENGTH; i++)
        [result appendFormat:@"%02x", digest[i]];
    
    return result;
}


+ (instancetype)sharedUtils {
    static XYUtils *_instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[XYUtils alloc] init];
    });
    
    return _instance;
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

+ (NSTimeInterval)adjustTimestampFromServer:(long long)timestamp {
    if (timestamp > 140000000000) {
        timestamp /= 1000;
    }
    return timestamp;
}


+ (UIButton *)navigationBackButton {
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setImage:[UIImage imageNamed:@"barbuttonicon_back"] forState:UIControlStateNormal];
    
    [btn setTitle:@"返回" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
    
    btn.titleLabel.font = [UIFont systemFontOfSize:15.8];
    btn.backgroundColor = [UIColor clearColor];
    btn.frame = CGRectMake(0, 0, 47, 50);
    
    return btn;
}

@end
