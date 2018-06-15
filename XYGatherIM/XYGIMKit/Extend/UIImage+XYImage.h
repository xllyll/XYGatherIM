//
//  UIImage+XYImage.h
//  XYGatherIM
//
//  Created by 杨卢银 on 2018/4/16.
//  Copyright © 2018年 杨卢银. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (XYImage)

+ (UIImage *)imageWithView:(UIView *)view;

+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size;

+ (UIImage *)imageWithColor:(UIColor *)color;

- (UIImage *)resizableImage;

- (UIImage *)resizeImageToSize:(CGSize)size;

- (UIImage *)resizeImageToSize:(CGSize)size opaque:(BOOL)opaque scale:(CGFloat)scale;

- (UIImage *)createWithImageInRect:(CGRect)rect;

- (UIImage *)getGrayImage;

- (UIImage *)darkenImage;

- (UIImage *) partialImageWithPercentage:(float)percentage vertical:(BOOL)vertical grayscaleRest:(BOOL)grayscaleRest;

- (CGSize)pixelSize;

- (NSInteger)imageFileSize;

@end
