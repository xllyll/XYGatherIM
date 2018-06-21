//
//  XYGIMAssetDisplayView.h
//  XYGatherIM
//
//  Created by 杨卢银 on 2018/6/21.
//  Copyright © 2018年 杨卢银. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, XYGIMVideoDownloadHUDStatus) {
    kXYGIMVideoDownloadHUDStatusPending,
    kXYGIMVideoDownloadHUDStatusWaiting,
    kXYGIMVideoDownloadHUDStatusDownloading,
    kXYGIMVideoDownloadHUDStatusSuccess,
    kXYGIMVideoDownloadHUDStatusFailed
};


#define ROTATION_ANIMATION_KEY @"rotationAnimation"

@interface XYGIMVideoDownloadStatusHUD : UIView

@property (nonatomic) NSInteger progress;

@property (nonatomic) XYGIMVideoDownloadHUDStatus status;

- (void)setText:(NSString *)text forStatus:(XYGIMVideoDownloadHUDStatus)status;

- (void)playZoomAnimation;

- (void)playQuickProgressAnimationTo:(NSInteger)finalProgress;

@end
