//
//  UIColor+XYExt.h
//  XYGatherIM
//
//  Created by 杨卢银 on 2018/6/14.
//  Copyright © 2018年 杨卢银. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (XYExt)

#define UIColorRGBA(_red, _green, _blue, _alpha) [UIColor colorWithRed:((_red)/255.0) \
green:((_green)/255.0) blue:((_blue)/255.0) alpha:(_alpha)]

#define UIColorRGB(red, green, blue) UIColorRGBA(red, green, blue, 1)

#define UIColorHexRGB(rgbString) [UIColor colorWithHexRGB:(rgbString)]

#define UIColorHexRGBA(rgbaString) [UIColor colorWithHexRGBA:(rgbaString)]



+ (instancetype)colorWithHexRGBA:(NSString *)rgba;

+ (instancetype)colorWithHexRGB:(NSString *)rgb;

+ (instancetype)colorWithHexARGB:(NSString *)argb;

+ (UIColor *)randomColor;

+ (UIColor *)randomColorWithAlpha:(CGFloat)alpha;

@end
