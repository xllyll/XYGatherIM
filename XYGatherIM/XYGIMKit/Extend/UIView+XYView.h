//
//  UIView+XYView.h
//  XYGatherIM
//
//  Created by 杨卢银 on 2018/4/16.
//  Copyright © 2018年 杨卢银. All rights reserved.
//

#import <UIKit/UIKit.h>
//** 沙盒路径 ***********************************************************************************
#define PATH_OF_APP_HOME    NSHomeDirectory()
#define PATH_OF_TEMP        NSTemporaryDirectory()
#define PATH_OF_DOCUMENT    [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0]
#define PATH_OF_CACHE       [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0]


#define K_WINDOW_FRAME [UIScreen mainScreen].bounds

#define K_FONT(size) [UIFont systemFontOfSize:size]

typedef NS_ENUM(NSInteger, XYViewAnimationType) {
    XYViewAnimationTypeNone,//默认从0开始
    XYViewAnimationTypeShake,//抖动动画
};

typedef enum tagBorderType
{
    FUBorderTypeDashed,
    FUBorderTypeSolid
    
}FUBorderType;

@interface UIView (XYView)<NSCoding>
/**
 *视图宽度
 */
@property (nonatomic,assign) CGFloat width;
/**
 *视图高度
 */
@property (nonatomic,assign) CGFloat height;

/**
 *视图X坐标
 */
@property (nonatomic,assign) CGFloat x;
/**
 *视图Y坐标
 */
@property (nonatomic,assign) CGFloat y;

/**
 *视图X坐标（最大）
 */
@property (nonatomic,assign) CGFloat maxX;
/**
 *视图Y坐标 （最大）
 */
@property (nonatomic,assign) CGFloat maxY;


/**
 * 小红点
 */
@property (nonatomic,copy) NSString *badgeString;


/**
 *设置为圆形视图
 */
-(void)setRoundView;

/**
 *设置为圆角视图<angle 角度>
 */
-(void)setRoundViewByAngle:(float)angle;

-(void)setRoundViewByAngle:(float)angle byRoundingCorners:(UIRectCorner)corners;

-(void)setShadow:(float)width color:(UIColor*)color;
-(void)setShadowBorderWidth:(CGFloat)width borderColor:(UIColor*)color;
/**
 * 设置view 的 边线
 */
-(void)setBorderWidth:(CGFloat)width borderColor:(UIColor*)color;


/**
 *设置为圆形视图
 */
-(void)setAnimationType:(XYViewAnimationType)animationType;

/**
 *  关闭键盘
 */
- (void)dismissKeyboard;


/**
 * 获得屏幕图像
 */
- (UIImage *)xy_screenshotImage;
- (UIImage *)xy_screenshotImageAtFrame:(CGRect)rect;


/**
 删除所有约束
 */
- (void)xy_removeAllAutoLayout;
/**
 *  将若干view等宽布局于容器containerView中
 @param views viewArray
 @param containerView 容器view
 @param LRpadding 距容器的左右/(上下)边距
 @param viewPadding 各view的左右/(上下)边距
 @param SPpadding 于父视图的边距
 @param horizontal 水平/垂直
 */
+(void)xy_makeEqualWidthViews:(NSArray *)views inView:(UIView *)containerView LRTBpadding:(CGFloat)LRTBpadding viewPadding:(CGFloat)viewPadding superViewPadding:(CGFloat)SPpadding isHorizontal:(BOOL)horizontal;


/**
 视图闪烁效果
 
 @param scale 放大缩小大小（0-1）
 @param duration 时间
 @param repeatCount 次数
 */
-(void)xy_flickerByScale:(CGFloat)scale duration:(CGFloat)duration repeatCount:(NSInteger)repeatCount;


@end
