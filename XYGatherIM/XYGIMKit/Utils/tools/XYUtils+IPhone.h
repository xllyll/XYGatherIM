//
//  XYUtils+IPhone.h
//  XYGatherIM
//
//  Created by 杨卢银 on 2018/6/15.
//  Copyright © 2018年 杨卢银. All rights reserved.
//

#import "XYUtils.h"
#import "Reachability.h"
#import <AudioToolbox/AudioToolbox.h>
#import <CoreTelephony/CTCarrier.h>
#import <CoreTelephony/CTTelephonyNetworkInfo.h>

#define URL_MAIL_SCHEME @"mailto"

#define URL_HTTP_SCHEME @"http"

#define URL_HTTPS_SCHEME @"https"

typedef NS_ENUM(NSInteger, XYNetconnectionType) {
    XYNetconnectionTypeNone = 0,
    XYNetconnectionType2G,
    XYNetconnectionType3G,
    XYNetconnectionType4G,
    XYNetconnectionTypeWifi,
    XYNetconnectionTypeOther
};

@interface XYUtils (IPhone)
+ (CGFloat)systemVersion;

//当前手机是否支持PhotoKit照片库框架
+ (BOOL)canUsePhotiKit;

//拨打电话
+ (void)callPhoneNumber:(NSString *)phone;

//复制字符串到系统剪贴板
+ (void)copyToPasteboard:(NSString *)string;

+ (NSString *)appName;

+ (NSString *)getApplicationScheme;

//获取当前网络类型
+ (XYNetconnectionType)getNetconnectionType;

+ (void)setNetworkActivityIndicatorVisible:(BOOL)visible;

//保存图片到系统相册
+ (void)saveImageToPhotoAlbum:(UIImage *)image;

//保存视频到系统相册
+ (void)saveVideoToPhotoAlbum:(NSString *)videoPath;

+ (NSString *)deviceModelName;
@end
