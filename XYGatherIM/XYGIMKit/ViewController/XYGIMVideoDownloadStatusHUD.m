//
//  XYGIMAssetDisplayView.m
//  XYGatherIM
//
//  Created by 杨卢银 on 2018/6/21.
//  Copyright © 2018年 杨卢银. All rights reserved.
//

#import "XYGIMVideoDownloadStatusHUD.h"
#import "XYUtils.h"
#import "XYConfig.h"

#define HUD_STROKE_COLOR [UIColor whiteColor]
#define HUD_PROGRESS_FILL_COLOR [UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1]
#define HUD_FILL_COLOR [UIColor colorWithWhite:0 alpha:0.4]

@implementation XYGIMVideoDownloadStatusHUD
{
    CGFloat HUD_RADIUS;
    UIImageView *imageView;
    UILabel *label;
    NSMutableDictionary *statusDict;
    BOOL isQuickAnimating;
    NSInteger trueProgress;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        HUD_RADIUS = CGRectGetWidth(frame)/2;
        
        imageView = [[UIImageView alloc] initWithFrame:self.bounds];
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        imageView.backgroundColor = [UIColor clearColor];
        imageView.tintColor = [UIColor whiteColor];
        [self addSubview:imageView];
        
        label = [[UILabel alloc] initWithFrame:CGRectMake(-20, CGRectGetHeight(frame) + 8, CGRectGetWidth(frame) + 40, 15)];
        label.textColor = [UIColor whiteColor];
        label.font = [UIFont systemFontOfSize:14];
        label.textAlignment = NSTextAlignmentCenter;
        label.backgroundColor = [UIColor clearColor];
        [self addSubview:label];
    }
    
    return self;
}

- (void)setFrame:(CGRect)frame {
    [super setFrame:frame];
    HUD_RADIUS = CGRectGetWidth(frame)/2;
}

- (void)setStatus:(XYGIMVideoDownloadHUDStatus)status {
    _status = status;
    
    switch (status) {
        case kXYGIMVideoDownloadHUDStatusPending:
        case kXYGIMVideoDownloadHUDStatusSuccess:
            imageView.image = [UIImage imageNamed:@"video_icon_play"];
            imageView.transform = CGAffineTransformIdentity;
            label.text = statusDict[@(status)];
            [self.layer removeAllAnimations];
            break;
        case kXYGIMVideoDownloadHUDStatusFailed: {
            UIImage *errorImage = [UIImage imageNamed:@"SignUpError"];
            errorImage = [errorImage imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
            imageView.image = errorImage;
            imageView.transform = CGAffineTransformMakeScale(0.6, 0.6);
            
            label.text = statusDict[@(status)];
            [self.layer removeAllAnimations];
        }
            break;
        case kXYGIMVideoDownloadHUDStatusWaiting: {
            imageView.image = nil;
            label.text = nil;
            CABasicAnimation *rotationAnimation = (CABasicAnimation *)[self.layer animationForKey:ROTATION_ANIMATION_KEY];
            if (!rotationAnimation) {
                rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
                rotationAnimation.toValue = [NSNumber numberWithFloat: M_PI * 2.0];
                rotationAnimation.duration = 1;
                rotationAnimation.cumulative = YES;
                rotationAnimation.repeatCount = HUGE_VALF;
                rotationAnimation.removedOnCompletion = NO;
                
                [self.layer addAnimation:rotationAnimation forKey:ROTATION_ANIMATION_KEY];
            }
        }
            break;
        default:
            imageView.image = nil;
            label.text = nil;
            [self.layer removeAllAnimations];
            break;
    }
    
    [self setNeedsDisplay];
}

- (void)setProgress:(NSInteger)progress {
    if (isQuickAnimating) {
        trueProgress = progress;
        return;
    }
    _progress = progress;
    [self setNeedsDisplay];
}


- (void)drawRect:(CGRect)rect {
    if (_status == kXYGIMVideoDownloadHUDStatusPending ||
        _status == kXYGIMVideoDownloadHUDStatusSuccess)
        return;
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetStrokeColorWithColor(context, HUD_STROKE_COLOR.CGColor);
    CGContextSetFillColorWithColor(context, HUD_FILL_COLOR.CGColor);
    CGContextSetLineWidth(context, 1);
    
    if (_status == kXYGIMVideoDownloadHUDStatusWaiting) {
        CGContextAddArc(context, HUD_RADIUS, HUD_RADIUS, HUD_RADIUS - 1, DEGREES_TO_RADIANS(-90), DEGREES_TO_RADIANS(-90 + 30), 1);
        CGContextStrokePath(context);
        CGContextFillPath(context);
    }else if(_status == kXYGIMVideoDownloadHUDStatusDownloading) {
        CGContextAddEllipseInRect(context, CGRectMake(1, 1, HUD_RADIUS * 2 - 2, HUD_RADIUS * 2 - 2));
        CGContextStrokePath(context);
        CGContextFillPath(context);
        
        CGContextMoveToPoint(context, HUD_RADIUS, HUD_RADIUS);
        CGContextSetFillColorWithColor(context, HUD_PROGRESS_FILL_COLOR.CGColor);
        CGFloat endDegree = -90 + _progress *3.6;
        CGContextAddArc(context, HUD_RADIUS, HUD_RADIUS, HUD_RADIUS-4, DEGREES_TO_RADIANS(-90), DEGREES_TO_RADIANS(endDegree), 0);
        CGContextFillPath(context);
    }else if (_status == kXYGIMVideoDownloadHUDStatusFailed) {
        CGContextAddEllipseInRect(context, CGRectMake(1, 1, HUD_RADIUS * 2 - 2, HUD_RADIUS * 2 - 2));
        CGContextStrokePath(context);
        CGContextFillPath(context);
    }
}

- (void)setText:(NSString *)text forStatus:(XYGIMVideoDownloadHUDStatus)status {
    if (!statusDict) {
        statusDict = [NSMutableDictionary dictionary];
    }
    
    statusDict[@(status)] = text;
}


- (void)playZoomAnimation {
    self.transform = CGAffineTransformMakeScale(0.5, 0.5);
    [UIView animateWithDuration:DEFAULT_DURATION animations:^{
        self.transform =  CGAffineTransformMakeScale(1, 1);
    }];
}

- (void)playQuickProgressAnimationTo:(NSInteger)finalProgress {
    if (finalProgress >= 10 && finalProgress <= 100) {
        self.progress = 0;
        isQuickAnimating = YES;
        [NSTimer scheduledTimerWithTimeInterval:0.01 target:self selector:@selector(drawProgress:) userInfo:@(finalProgress) repeats:YES];
    }
}

- (void)drawProgress:(NSTimer *)timer {
    NSInteger finalProgress = trueProgress > 0 ? trueProgress :[timer.userInfo integerValue];
    
    _progress += 1;
    if (_progress >= finalProgress) {
        _progress = finalProgress;
        [timer invalidate];
        isQuickAnimating = NO;
        trueProgress = 0;
    }
    
    [self setNeedsDisplay];
}

@end
