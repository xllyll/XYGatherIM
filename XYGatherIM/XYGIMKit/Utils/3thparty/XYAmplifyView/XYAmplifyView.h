//
//  XYAmplifyView.h
//  FindU
//
//  Created by 杨卢银 on 2017/3/30.
//  Copyright © 2017年 杨卢银. All rights reserved.
//

#import <UIKit/UIKit.h>


/**
 图片点击查看
 */
@interface XYAmplifyView : UIView


-(instancetype)initWithFrame:(CGRect)frame andTapImgView:(UIImageView *)tapview andSuperView:(UIView *)superView imageHD:(NSString *)imageHD;

-(instancetype)initWithFrame:(CGRect)frame andTapview:(UIView *)tapview andSuperView:(UIView *)superView imageHD:(NSString *)imageHD;

- (instancetype)initWithFrame:(CGRect)frame andGesture:(UITapGestureRecognizer *)tap andSuperView:(UIView *)superView;

- (instancetype)initWithFrame:(CGRect)frame andGesture:(UITapGestureRecognizer *)tap andSuperView:(UIView *)superView imageHD:(NSString*)imageHD;

@end
