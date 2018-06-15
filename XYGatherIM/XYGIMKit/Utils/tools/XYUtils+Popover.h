//
//  XYUtils+Popover.h
//  XYGatherIM
//
//  Created by 杨卢银 on 2018/6/15.
//  Copyright © 2018年 杨卢银. All rights reserved.
//

#import "XYUtils.h"
#import "MBProgressHUD.h"
#import "XYTipView.h"

NS_ASSUME_NONNULL_BEGIN

@interface XYUtils (Popover) <MBProgressHUDDelegate>

+ (void)showMessageAlertWithTitle:(nullable NSString *)title message:(NSString *)message;

+ (void)showMessageAlertWithTitle:(nullable NSString *)title message:(NSString *)message actionTitle:(NSString *)actionTitle;

+ (void)showMessageAlertWithTitle:(nullable NSString *)title message:(NSString *)message actionTitle:(NSString *)actionTitle actionHandler:(void (^ __nullable)(void))actionHandler;

+ (void)showConfirmAlertWithTitle:(nullable NSString *)title message:(NSString *)message yesTitle:(NSString *)yesTitle yesAction:(void (^ __nullable)(void))yesAction;

+ (void)showConfirmAlertWithTitle:(nullable NSString *)title message:(NSString *)message yesTitle:(NSString *)yesTitle yesAction:(void (^ __nullable)(void))yesAction cancelTitle:(NSString *)cancelTitle cancelAction:(void (^ __nullable)(void))cancelAction;

+ (void)showConfirmAlertWithTitle:(NSString *)title message:(NSString *)message firstActionTitle:(NSString *)firstActionTitle firstAction:(void (^ __nullable)(void))firstAction secondActionTitle:(NSString *)secondActionTitle secondAction:(void (^ __nullable)(void))secondAction;


+ (void)showTipView:(nonnull UIView<XYTipDelegate> *)view;

+ (void)hideTipView:(nonnull UIView<XYTipDelegate> *)tipView;

+ (UIViewController *)mostFrontViewController;

#pragma mark - HUD -

+ (MBProgressHUD *)showActionSuccessHUD:(NSString *)title inView:(nullable UIView *)view;

+ (MBProgressHUD *)showActionSuccessHUD:(NSString *)title;

+ (MBProgressHUD *)showTextHUD:(NSString *)text inView:(nullable UIView *)view;

+ (MBProgressHUD *)showTextHUD:(NSString *)text;

+ (MBProgressHUD *)showCircleProgressHUDInView:(UIView *)view;

+ (MBProgressHUD *)showActivityIndicatiorHUDWithTitle:(nullable NSString *)title inView:(nullable UIView *)view;

+ (MBProgressHUD *)showActivityIndicatiorHUDWithTitle:(nullable NSString *)title;

+ (void)hideHUD:(MBProgressHUD *)HUD animated:(BOOL)animated;

//阻止屏幕上某个区域响应用户手势
//+ (void)blockUserInteractionInWindowRect:(CGRect)region;


@end


NS_ASSUME_NONNULL_END
