//
//  XYProgressHUD.h
//  XYGatherIM
//
//  Created by 杨卢银 on 2018/4/16.
//  Copyright © 2018年 杨卢银. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *  状态指示器对应状态
 */
typedef NS_ENUM(NSUInteger, XYProgressState){
    XYProgressSuccess /**< 成功 */,
    XYProgressError /**< 出错,失败 */,
    XYProgressShort /**< 时间太短失败 */,
    XYProgressMessage /**< 自定义失败提示 */,
};

/**
 *  录音加载的指示器
 */
@interface XYProgressHUD : UIView
#pragma mark - Class Methods

/**
 *  上次成功录音时长
 */
+ (NSTimeInterval)seconds;

/**
 *  显示录音指示器
 */
+ (void)show;

/**
 *  隐藏录音指示器,使用自带提示语句
 *
 *  @param message 提示信息
 */
+ (void)dismissWithMessage:(NSString *)message;

/**
 *  隐藏hud,带有录音状态
 *
 *  @param progressState 录音状态
 */
+ (void)dismissWithProgressState:(XYProgressState)progressState;

/**
 *  修改录音的subTitle显示文字
 *
 *  @param str 需要显示的文字
 */
+ (void)changeSubTitle:(NSString *)str;
@end
