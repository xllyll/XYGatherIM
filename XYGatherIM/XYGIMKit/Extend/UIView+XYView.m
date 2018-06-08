//
//  UIView+XYView.m
//  XYGatherIM
//
//  Created by 杨卢银 on 2018/4/16.
//  Copyright © 2018年 杨卢银. All rights reserved.
//

#import "UIView+XYView.h"
#import "Masonry.h"

@implementation UIView (XYView)

//***************************************************************************************************************
//************************************       视图大小位置设置     **********************************************
//***************************************************************************************************************
-(CGFloat)height{
    return self.frame.size.height;
}
-(CGFloat)width{
    return self.frame.size.width;
}
-(void)setHeight:(CGFloat)height{
    CGRect rect   = self.frame;
    rect.size.height = height;
    self.frame = rect;
}
-(void)setWidth:(CGFloat)width{
    CGRect rect   = self.frame;
    rect.size.width= width;
    self.frame = rect;
}
-(CGFloat)x{
    return self.frame.origin.x;
}
-(CGFloat)y{
    return self.frame.origin.y;
}
-(void)setX:(CGFloat)x{
    CGRect rect   = self.frame;
    rect.origin.x= x;
    self.frame = rect;
}
-(void)setY:(CGFloat)y{
    CGRect rect   = self.frame;
    rect.origin.y= y;
    self.frame = rect;
}
-(void)setMaxX:(CGFloat)maxX{
    CGRect rect   = self.frame;
    rect.origin.x= maxX-self.frame.size.width;
    self.frame = rect;
}
-(void)setMaxY:(CGFloat)maxY{
    CGRect rect   = self.frame;
    rect.origin.y= maxY-self.frame.size.height;
    self.frame = rect;
}
-(CGFloat)maxX{
    return self.frame.origin.x+self.frame.size.width;
}
-(CGFloat)maxY{
    return self.frame.origin.y+self.frame.size.height;
}
//***************************************************************************************************************
//************************************          小红点 设置        **********************************************
//***************************************************************************************************************

-(NSString *)badgeString{
    UIView *view = (UIView*)[self viewWithTag:111111];
    UILabel *label = (UILabel*)[view viewWithTag:111112];
    return label.text;
}
-(void)setBadgeString:(NSString *)badgeString{
    UIView *view = (UIView*)[self viewWithTag:111111];
    
    if (badgeString) {
        if (view==nil) {
            UIView *view = [[UIView alloc]initWithFrame:CGRectMake(self.width-20, -5, 25, 25)];
            UILabel *label = [[UILabel alloc]initWithFrame:view.bounds];
            label.text = badgeString;
            view.backgroundColor = [UIColor redColor];
            [self addSubview:view];
            [view addSubview:label];
            view.tag = 111111;
            label.tag= 111112;
            label.textAlignment = NSTextAlignmentCenter;
            label.textColor = [UIColor whiteColor];
            [view setRoundView];
        }else{
            UILabel *label = (UILabel*)[view viewWithTag:111112];
            label.text = badgeString;
        }
        
    }else{
        [view removeFromSuperview];
        view = nil;
    }
}


//***************************************************************************************************************
//************************************          视图形态设置        **********************************************
//***************************************************************************************************************
-(void)setRoundView{
    self.layer.cornerRadius = self.bounds.size.height/2.0;
    self.clipsToBounds = YES;
    //self.layer.masksToBounds = YES;
}
-(void)setRoundViewByAngle:(float)angle{
    self.layer.cornerRadius = angle;
    self.clipsToBounds = YES;
    //self.layer.masksToBounds = YES;
}

-(void)setRoundViewByAngle:(float)angle byRoundingCorners:(UIRectCorner)corners{
    
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:corners cornerRadii:CGSizeMake(angle, angle)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = self.bounds;
    maskLayer.path = maskPath.CGPath;
    self.layer.mask = maskLayer;
    
}
-(void)setBorderWidth:(CGFloat)width borderColor:(UIColor *)color{
    self.layer.borderWidth = width;
    self.layer.borderColor = color.CGColor;
}
-(void)setShadow:(float)width color:(UIColor *)color{
    
    self.layer.masksToBounds=NO;//这行去掉
    self.layer.shadowColor = color.CGColor;
    self.layer.shadowOffset =CGSizeMake(width, width);
    self.layer.shadowOpacity=1;
    self.layer.shadowRadius =0;
    if (width>0) {
        self.clipsToBounds = NO;
    }else{
        self.clipsToBounds = YES;
    }
}
-(void)setShadowBorderWidth:(CGFloat)width borderColor:(UIColor *)color{
    
}
-(void)setAnimationType:(XYViewAnimationType)animationType{
    
    switch (animationType) {
        case XYViewAnimationTypeNone:
            
            break;
        case XYViewAnimationTypeShake:
            [self shakeAnimate];
            break;
            
        default:
            break;
    }
}
//抖动动画
-(void)shakeAnimate{
    CGFloat t =5.0;
    CGAffineTransform translateRight  =CGAffineTransformTranslate(CGAffineTransformIdentity, t,0.0);
    CGAffineTransform translateLeft =CGAffineTransformTranslate(CGAffineTransformIdentity,-t,0.0);
    self.transform = translateLeft;
    [UIView animateWithDuration:0.07 delay:0.0 options:UIViewAnimationOptionAutoreverse|UIViewAnimationOptionRepeat animations:^{
        [UIView setAnimationRepeatCount:2.0];
        self.transform = translateRight;
    } completion:^(BOOL finished){
        if(finished){
            [UIView animateWithDuration:0.05 delay:0.0 options:UIViewAnimationOptionBeginFromCurrentState animations:^{
                self.transform =CGAffineTransformIdentity;
            } completion:NULL];
        }
    }];
}
- (void)dismissKeyboard{
    for (UIView *txtview in self.subviews) {
        if ([txtview isMemberOfClass:[UITextField class]]) {
            
            [(UITextField*)txtview resignFirstResponder];
            
        }
    }
    
}

//获得屏幕图像
- (UIImage *)xy_screenshotImage
{
    
    //UIGraphicsBeginImageContext(self.frame.size);
    //UIGraphicsBeginImageContext(self.bounds.size);//模糊
    
    UIGraphicsBeginImageContextWithOptions(self.bounds.size, NO, 0.0);//原图
    CGContextRef context = UIGraphicsGetCurrentContext();
    [self.layer renderInContext:context];
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return theImage;
}

//获得某个范围内的屏幕图像
- (UIImage *)xy_screenshotImageAtFrame:(CGRect)r
{
    UIGraphicsBeginImageContext(self.frame.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSaveGState(context);
    UIRectClip(r);
    [self.layer renderInContext:context];
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return  theImage;//[self getImageAreaFromImage:theImage atFrame:r];
}

-(void)xy_flickerByScale:(CGFloat)scale duration:(CGFloat)duration repeatCount:(NSInteger)repeatCount{
    
    CAKeyframeAnimation* animation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    
    animation.duration = duration;// 动画时间
    animation.repeatCount = repeatCount;
    NSMutableArray *values = [NSMutableArray array];
    
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0, 1.0, 1.0)]];
    
    // 这三个数字，我只研究了前两个，所以最后一个数字我还是按照它原来写1.0；前两个是控制view的大小的；
    
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0+scale, 1.0+scale, 1.0)]];
    
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0-scale, 1.0-scale, 1.0)]];
    
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0, 1.0, 1.0)]];
    
    animation.values = values;
    
    [self.layer addAnimation:animation forKey:nil];
    
}

- (void)xy_removeAllAutoLayout{
    [self removeConstraints:self.constraints];
    for (NSLayoutConstraint *constraint in self.superview.constraints) {
        if ([constraint.firstItem isEqual:self]) {
            [self.superview removeConstraint:constraint];
        }
    }
}
/**
 *  将若干view等宽布局于容器containerView中
 @param views viewArray
 @param containerView 容器view
 @param LRpadding 距容器的左右/(上下)边距
 @param viewPadding 各view的左右/(上下)边距
 @param SPpadding 于父视图的边距
 @param horizontal 水平/垂直
 */
+(void)xy_makeEqualWidthViews:(NSArray *)views inView:(UIView *)containerView LRTBpadding:(CGFloat)LRTBpadding viewPadding:(CGFloat)viewPadding superViewPadding:(CGFloat)SPpadding isHorizontal:(BOOL)horizontal
{
    UIView *lastView;
    for (UIView *view in views) {
        [containerView addSubview:view];
        if (lastView) {
            if (horizontal) {
                [view mas_makeConstraints:^(MASConstraintMaker *make) {
                    //make.top.bottom.equalTo(containerView);
                    make.top.equalTo(containerView.mas_top).offset(SPpadding);
                    make.bottom.equalTo(containerView.mas_bottom).offset(-SPpadding);
                    make.left.equalTo(lastView.mas_right).offset(viewPadding);
                    make.width.equalTo(lastView);
                }];
            }else{
                [view mas_makeConstraints:^(MASConstraintMaker *make) {
                    //make.left.right.equalTo(containerView);
                    make.left.equalTo(containerView.mas_left).offset(SPpadding);
                    make.right.equalTo(containerView.mas_right).offset(-SPpadding);
                    make.top.equalTo(lastView.mas_bottom).offset(viewPadding);
                    make.height.equalTo(lastView);
                }];
            }
        }else
        {
            if (horizontal) {
                [view mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.left.equalTo(containerView).offset(LRTBpadding);
                    //make.top.bottom.equalTo(containerView);
                    make.top.equalTo(containerView.mas_top).offset(SPpadding);
                    make.bottom.equalTo(containerView.mas_bottom).offset(-SPpadding);
                }];
            }else{
                [view mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.top.equalTo(containerView).offset(LRTBpadding);
                    //make.left.right.equalTo(containerView);
                    make.left.equalTo(containerView.mas_left).offset(SPpadding);
                    make.right.equalTo(containerView.mas_right).offset(-SPpadding);
                }];
            }
        }
        lastView=view;
    }
    [lastView mas_makeConstraints:^(MASConstraintMaker *make) {
        if (horizontal) {
            make.right.equalTo(containerView).offset(-LRTBpadding);
        }else{
            make.bottom.equalTo(containerView).offset(-LRTBpadding);
        }
    }];
}
@end
