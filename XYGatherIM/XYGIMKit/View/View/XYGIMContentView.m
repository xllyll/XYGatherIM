//
//  XYGIMContentView.m
//  XYGatherIM
//
//  Created by 杨卢银 on 2018/6/12.
//  Copyright © 2018年 杨卢银. All rights reserved.
//

#import "XYGIMContentView.h"

@implementation XYGIMContentView

- (instancetype)init {
    if ([super init]) {
        CAShapeLayer *maskLayer = [CAShapeLayer layer];
        maskLayer.fillColor = [UIColor grayColor].CGColor;
        //左下角的四分之一拉伸
        maskLayer.contentsCenter = CGRectMake(0.3, 0.3, 0.5, 0.5);
        //maskLayer.contentsCenter = CGRectMake(.7f, .7f, .1f, .1f);
        maskLayer.contentsScale = [UIScreen mainScreen].scale;
        self.layer.mask = maskLayer;
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.maskView.frame = CGRectInset(self.bounds, 0, 0);
}

- (void)layoutSublayersOfLayer:(CALayer *)layer {
    [super layoutSublayersOfLayer:layer];
    self.layer.mask.frame = CGRectInset(self.bounds, 0, 0);
}

@end
