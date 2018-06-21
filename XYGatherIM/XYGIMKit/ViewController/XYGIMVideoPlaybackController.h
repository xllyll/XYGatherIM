//
//  XYGIMVideoPlaybackController.h
//  XYGatherIM
//
//  Created by 杨卢银 on 2018/6/21.
//  Copyright © 2018年 杨卢银. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XYGIMVideoPlaybackView.h"

@protocol XYGIMVideoPlaybackDelegate <NSObject>
@optional

/* --------------------------------------------------------------
 **  Called when an asset fails to prepare for playback for any of
 **  the following reasons:
 **
 **  1) values of asset keys did not load successfully,
 **  2) the asset keys did load successfully, but the asset is not
 **     playable
 **  3) the item did not become ready to play.
 ** ----------------------------------------------------------- */
- (void)playerPrepareToPlayFailed:(NSURL *)videoURL;

- (void)playerReadyToPlay:(NSURL *)videoURL;

- (void)playerDidPlayToEnd:(NSURL *)videoURL;

- (void)playerCurrentItemDidChangedTo:(NSURL *)videoURL;

- (void)playerDidPlayFailed:(NSURL *)videoURL;

- (void)playerRateDidChanged:(NSURL *)videoURL currentRate:(float)rate;

- (void)playerScrubberWillChange:(NSURL *)videoURL;

@end
@interface XYGIMVideoPlaybackController : UIViewController
@property (nonatomic, weak) id<XYGIMVideoPlaybackDelegate> delegate;

@property (nonatomic) XYGIMVideoPlaybackView *playbackView;

@property (nonatomic) NSURL *videoURL;

- (void)play;

/**
 *  暂停，视频进度不变
 */
- (void)pause;

/**
 *  停止播放，进度回退到0，但是各种事件、监听依然存在
 */
- (void)stop;

- (void)willStop;

- (BOOL)isPlaying;

- (void)initVideoBottomBarWithDuration:(CGFloat)duration;

- (void)setBackgroundViewVisible:(BOOL)visible;

- (void)hideControlView:(BOOL)animated;

- (void)showControlView:(BOOL)animated;

- (BOOL)isControlViewHidden;
@end
