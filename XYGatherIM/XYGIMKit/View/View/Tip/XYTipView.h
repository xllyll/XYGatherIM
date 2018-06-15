//
//  XYTipView.h
//  XYGatherIM
//
//  Created by 杨卢银 on 2018/6/15.
//  Copyright © 2018年 杨卢银. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XYTipDelegate.h"
@interface XYTipView : UIView

+ (void)showTipView:(nonnull UIView<XYTipDelegate> *)view;

+ (void)hideTipView:(nonnull UIView<XYTipDelegate> *)tipView;

@end
