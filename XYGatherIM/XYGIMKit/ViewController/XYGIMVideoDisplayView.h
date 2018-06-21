//
//  XYGIMVideoDisplayView.h
//  XYGatherIM
//
//  Created by 杨卢银 on 2018/6/21.
//  Copyright © 2018年 杨卢银. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XYGIMAssetDisplayView.h"
#import "XYGIMVideoPlaybackView.h"
#import "XYGIMChatAssetDisplayController.h"

typedef NS_ENUM(NSInteger, XYGIMVideoDownloadStyle) {
    kXYGIMVideoDownloadStyleNone,
    kXYGIMVideoDownloadStylePending,
    kXYGIMVideoDownloadStyleWaiting,
    kXYGIMVideoDownloadStyleDownloading,
    kXYGIMVideoDownloadStyleDownloadSuccess,
    kXYGIMVideoDownloadStyleFailed
};

typedef NS_ENUM(NSInteger, XYGIMVideoPlaybackStatus) {
    kXYGIMVideoPlaybackStatusPicture = 0, //没有播放源，仅仅显示视频第一帧图片
    kXYGIMVideoPlaybackStatusVideo, //开始播放
};
@interface XYGIMVideoDisplayView : UIView<XYGIMAssetDisplayView>

@property (nonatomic) XYGIMVideoPlaybackView *videoPlaybackView;

@property (nonatomic, weak) XYGIMChatAssetDisplayController *chatAssetDisplayController;

@property (nonatomic) BOOL needAnimation;

@property (nonatomic) XYGIMVideoPlaybackStatus videoPlaybackStatus;

@property (nonatomic) XYGIMVideoDownloadStyle videoDownloadStyle;

- (void)setDownloadProgress:(NSInteger)progress;

@end
