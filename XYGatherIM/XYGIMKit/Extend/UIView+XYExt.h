//
//  UIView+XYExt.h
//  XYGatherIM
//
//  Created by 杨卢银 on 2018/6/14.
//  Copyright © 2018年 杨卢银. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView  (XYExt)

@property (nonatomic) CGFloat left_LL;
@property (nonatomic) CGFloat top_LL;
@property (nonatomic) CGFloat right_LL;
@property (nonatomic) CGFloat bottom_LL;
@property (nonatomic) CGFloat width_LL;
@property (nonatomic) CGFloat height_LL;
@property (nonatomic) CGFloat centerX_LL;
@property (nonatomic) CGFloat centerY_LL;
@property (nonatomic) CGPoint origin_LL;
@property (nonatomic) CGSize  size_LL;

@property (nonatomic, getter=isVisible) BOOL visible;

- (UITapGestureRecognizer *)addTapGestureRecognizer:(SEL)action;

- (UITapGestureRecognizer *)addTapGestureRecognizer:(SEL)action target:(id)target;

- (UILongPressGestureRecognizer *)addLongPressGestureRecognizer:(SEL)action duration:(CGFloat)duration;

- (UILongPressGestureRecognizer *)addLongPressGestureRecognizer:(SEL)action target:(id)target duration:(CGFloat)duration;

//- (void)showActionSuccessDialog:(NSString *)title;
//
//- (void)showTextDialog:(NSString *)text;

- (void)removeAllSubviews;

@end
