//
//  XYUtils.h
//  XYGatherIM
//
//  Created by 杨卢银 on 2018/4/16.
//  Copyright © 2018年 杨卢银. All rights reserved.
//

@import UIKit;

#import "XYMacro.h"

NS_ASSUME_NONNULL_BEGIN

inline static long long adjustTimestampFromServer(long long timestamp) {
    if (timestamp > 140000000000) {
        timestamp /= 1000;
    }
    return timestamp;
}

@interface XYUtils : NSString

+(NSString *)md5:(NSString *)str;

+(NSString *)md5_32:(NSString*)string;

+ (instancetype)sharedUtils;

//服务器返回的时间戳单位可能是毫秒
+ (NSTimeInterval)adjustTimestampFromServer:(long long)timestamp;

+ (UIButton *)navigationBackButton;

@end

static inline UIViewAnimationOptions animationOptionsWithCurve(UIViewAnimationCurve curve) {
    switch (curve) {
        case UIViewAnimationCurveEaseInOut:
            return UIViewAnimationOptionCurveEaseInOut;
        case UIViewAnimationCurveEaseIn:
            return UIViewAnimationOptionCurveEaseIn;
        case UIViewAnimationCurveEaseOut:
            return UIViewAnimationOptionCurveEaseOut;
        case UIViewAnimationCurveLinear:
            return UIViewAnimationOptionCurveLinear;
    }
    
    return curve << 16;
}



NS_ASSUME_NONNULL_END


#import "XYUtils+Application.h"
#import "XYUtils+CGHelper.h"
#import "XYUtils+IPhone.h"
#import "XYUtils+Popover.h"
#import "XYUtils+Audio.h"
#import "XYUtils+Text.h"

