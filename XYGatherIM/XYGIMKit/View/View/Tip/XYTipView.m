//
//  XYTipView.m
//  XYGatherIM
//
//  Created by 杨卢银 on 2018/6/15.
//  Copyright © 2018年 杨卢银. All rights reserved.
//

#import "XYTipView.h"
#import "XYUtils.h"

@interface XYTipView ()

@property (nonatomic) NSMutableSet<UIView<XYTipDelegate> *> *aXYTipViews;

@end
@implementation XYTipView

+ (instancetype)sharedInstance {
    static XYTipView *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[XYTipView alloc] initWithFrame:SCREEN_FRAME];
    });
    
    return instance;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        _aXYTipViews = [NSMutableSet set];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapHandler:)];
        tap.numberOfTapsRequired = 1;
        tap.numberOfTouchesRequired = 1;
        [self addGestureRecognizer:tap];
    }
    
    return self;
}

- (void)tapHandler:(UITapGestureRecognizer *)tap {
    NSSet<UIView<XYTipDelegate> *> *tipViews = [self.aXYTipViews copy];
    for (UIView<XYTipDelegate> *tipView in tipViews) {
        SAFE_SEND_MESSAGE(tipView, canCancelByTouch) {
            BOOL canCancel = [tipView canCancelByTouch];
            
            if (canCancel) {
                [self removeTipView:tipView];
            }
        }
    }
    
}

- (void)removeTipView:(UIView<XYTipDelegate> *)tipView {
    [_aXYTipViews removeObject:tipView];
    
    SAFE_SEND_MESSAGE(tipView, willRemoveFromTipLayer) {
        [tipView willRemoveFromTipLayer];
    }
    
    [tipView removeFromSuperview];
    
    SAFE_SEND_MESSAGE(tipView, didRemoveFromTipLayer) {
        [tipView didRemoveFromTipLayer];
    }
    
    if (_aXYTipViews.count == 0)
        [self removeFromSuperview];
    
}


+ (void)showTipView:(nonnull UIView<XYTipDelegate> *)view {
    XYTipView *containerView = [XYTipView sharedInstance];
    if (!containerView.superview) {
        [[XYUtils currentWindow] addSubview:containerView];
    }
    [containerView.superview bringSubviewToFront:containerView];
    
    [containerView.aXYTipViews addObject:view];
    
    [containerView addSubview:view];
    SAFE_SEND_MESSAGE(view, didMoveToTipLayer) {
        [view didMoveToTipLayer];
    }
    
    view.center = containerView.center;
    SAFE_SEND_MESSAGE(view, tipViewCenterPositionOffset) {
        UIOffset offset = [view tipViewCenterPositionOffset];
        view.center = CGPointMake(view.center.x + offset.horizontal, view.center.y + offset.vertical);
    }
    
}

+ (void)hideTipView:(nonnull UIView<XYTipDelegate> *)tipView {
    XYTipView *containerView = [XYTipView sharedInstance];
    [containerView removeTipView:tipView];
}

@end
