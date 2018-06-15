//
//  XYUtils+Application.h
//  XYGatherIM
//
//  Created by 杨卢银 on 2018/6/14.
//  Copyright © 2018年 杨卢银. All rights reserved.
//

#import "XYUtils.h"
#import "AppDelegate.h"

@interface XYUtils (Application)
+ (UIViewController *)rootViewController;

+ (UIWindow *)currentWindow;

+ (UIWindow *)popOverWindow;

+ (void)addViewToPopOverWindow:(UIView *)view;

+ (void)removeViewFromPopOverWindow:(UIView *)view;

+ (AppDelegate *)appDelegate;

+ (UIViewController *)viewControllerForView:(UIView *)view;

+ (void)removeViewControllerFromParentViewController:(UIViewController *)viewController;

+ (void)addViewController:(UIViewController *)viewController  toViewController:(UIViewController *)parentViewController;

+ (void)startObserveRunLoop;

+ (void)stopObserveRunLoop;
@end
