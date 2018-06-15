//
//  XYUtils+CGHelper.h
//  XYGatherIM
//
//  Created by 杨卢银 on 2018/6/14.
//  Copyright © 2018年 杨卢银. All rights reserved.
//

#import "XYUtils.h"
@import ImageIO;

extern CGFloat SCREEN_WIDTH;
extern CGFloat SCREEN_HEIGHT;
extern CGSize SCREEN_SIZE;

extern CGRect SCREEN_FRAME;
extern CGPoint SCREEN_CENTER;

OBJC_EXTERN CGFloat CGPointDistanceBetween(CGPoint point1, CGPoint point2);

@interface XYUtils (CGHelper)

+ (CGFloat)screenScale;

+ (CGRect)screenFrame;

+ (CGFloat)screenWidth;

+ (CGFloat)screenHeight;

+ (CGFloat)pixelAlignForFloat:(CGFloat)position;

+ (CGPoint)pixelAlignForPoint:(CGPoint)point;

+ (CGSize)convertPointSizeToPixelSize:(CGSize)pointSize;

+ (CALayer *)lineWithLength:(CGFloat)length atPoint:(CGPoint)point;

+ (UIColor *)colorAtPoint:(CGPoint)point fromImageView:(UIImageView *)imageView;

+ (CGSize)GIFDimensionalSize:(CGImageSourceRef)imgSourceRef;

@end
