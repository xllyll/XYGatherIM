//
//  XYTipDelegate.h
//  XYGatherIM
//
//  Created by 杨卢银 on 2018/6/15.
//  Copyright © 2018年 杨卢银. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol XYTipDelegate <NSObject>

@optional

@property (nonatomic) BOOL canCancelByTouch;

- (void)didMoveToTipLayer;

- (void)willRemoveFromTipLayer;
- (void)didRemoveFromTipLayer;

- (UIOffset)tipViewCenterPositionOffset;

@end
