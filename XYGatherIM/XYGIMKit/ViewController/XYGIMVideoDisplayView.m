//
//  XYGIMVideoDisplayView.m
//  XYGatherIM
//
//  Created by 杨卢银 on 2018/6/21.
//  Copyright © 2018年 杨卢银. All rights reserved.
//

#import "XYGIMVideoDisplayView.h"
#import "XYGIMVideoDownloadStatusHUD.h"
#import "XYUtils.h"
@interface XYGIMVideoDisplayView ()

@property (nonatomic) XYGIMVideoDownloadStatusHUD *HUD;

@end
@implementation XYGIMVideoDisplayView

@synthesize imageView = _imageView;
@synthesize messageModel = _messageModel;
@synthesize messageBodyType = _messageBodyType;
@synthesize assetIndex = _assetIndex;

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        _videoDownloadStyle = kXYGIMVideoDownloadStyleNone;
        _messageBodyType = XYGIMMessageBodyTypeVideo;
        _assetIndex = -1;
        
        self.backgroundColor = [UIColor blackColor];
        
        self.videoPlaybackView = [[XYGIMVideoPlaybackView alloc] initWithFrame:self.bounds];
        [self addSubview:self.videoPlaybackView];
        _videoPlaybackView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        
        /* Specifies that the player should preserve the video’s aspect ratio and
         fit the video within the layer’s bounds. */
        [self.videoPlaybackView setVideoFillMode:AVLayerVideoGravityResizeAspect];
        
        _imageView = [[UIImageView alloc] initWithFrame:self.bounds];
        _imageView.backgroundColor = [UIColor blackColor];
        _imageView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        _imageView.contentMode = UIViewContentModeScaleAspectFit;
        [self addSubview:_imageView];
        _imageView.hidden = YES;
    }
    
    return self;
}


- (XYGIMVideoDownloadStatusHUD *)HUD {
    if (!_HUD) {
        _HUD = [[XYGIMVideoDownloadStatusHUD alloc] initWithFrame:CGRectMake(0, 0, 45, 45)];
        _HUD.center = CGPointMake(self.bounds.size.width/2, self.bounds.size.height/2);
        _HUD.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin;
        _HUD.backgroundColor = [UIColor clearColor];
        
        [_HUD setText:@"轻触载入" forStatus:kXYGIMVideoDownloadHUDStatusPending];
        [_HUD setText:@"下载失败" forStatus:kXYGIMVideoDownloadHUDStatusFailed];
        
        UITapGestureRecognizer *tapGR = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapGesture:)];
        tapGR.numberOfTapsRequired = 1;
        tapGR.numberOfTouchesRequired = 1;
        [_HUD addGestureRecognizer:tapGR];
    }
    
    return _HUD;
}

- (void)handleTapGesture:(UITapGestureRecognizer *)tap {
    [self.chatAssetDisplayController HUDDidTapped:_HUD];
}

- (void)setMessageModel:(XYNMessage *)messageModel {
    _messageModel = messageModel;
    _needAnimation = YES;
    self.imageView.image = messageModel.thumbnailImage;
    
    self.videoDownloadStyle = kXYGIMVideoDownloadStyleNone;
}

- (void)setVideoPlaybackStatus:(XYGIMVideoPlaybackStatus)videoPlaybackStatus {
    _videoPlaybackStatus = videoPlaybackStatus;
    switch (_videoPlaybackStatus) {
        case kXYGIMVideoPlaybackStatusPicture:
            _imageView.hidden = NO;
            break;
        case kXYGIMVideoPlaybackStatusVideo:
            _imageView.hidden = YES;
            break;
        default:
            break;
    }
}

- (void)setVideoDownloadStyle:(XYGIMVideoDownloadStyle)style {
    if (_videoDownloadStyle == style)
        return;
    _videoDownloadStyle = style;
    
    switch (style) {
        case kXYGIMVideoDownloadStylePending:
            if (!self.HUD.superview) {
                [self addSubview:self.HUD];
            }
            self.HUD.status = kXYGIMVideoDownloadHUDStatusPending;
            break;
        case kXYGIMVideoDownloadStyleWaiting:
            if (!self.HUD.superview) {
                [self addSubview:self.HUD];
                [_HUD playZoomAnimation];
            }
            self.HUD.status = kXYGIMVideoDownloadHUDStatusWaiting;
            break;
        case kXYGIMVideoDownloadStyleDownloading: {
            NSInteger progress = self.messageModel.fileDownloadProgress;
            BOOL needAnimation = NO;
            if (!self.HUD.superview) {
                needAnimation = YES;
                [self addSubview:self.HUD];
            }
            
            if (progress == 0) {
                _videoDownloadStyle = kXYGIMVideoDownloadStyleWaiting;
                self.HUD.status = kXYGIMVideoDownloadHUDStatusWaiting;
            }else if (progress >= 100) {
                _videoDownloadStyle = kXYGIMVideoDownloadStyleDownloadSuccess;
                self.HUD.status = kXYGIMVideoDownloadHUDStatusSuccess;
                [_HUD removeFromSuperview];
            }else {
                _HUD.status = kXYGIMVideoDownloadHUDStatusDownloading;
                if (needAnimation) {
                    [_HUD playQuickProgressAnimationTo:progress];
                }else {
                    _HUD.progress = progress;
                }
            }
        }
            break;
        case kXYGIMVideoDownloadStyleDownloadSuccess:
            [_HUD removeFromSuperview];
            break;
        case kXYGIMVideoDownloadStyleFailed:
            if (!self.HUD.superview) {
                [self addSubview:self.HUD];
            }
            _HUD.status = kXYGIMVideoDownloadHUDStatusFailed;
            break;
        case kXYGIMVideoDownloadStyleNone:
            [_HUD removeFromSuperview];
            break;
    }
    
    _needAnimation = NO;
}

- (void)setDownloadProgress:(NSInteger)progress {
    self.HUD.progress = progress;
}

- (void)setHidden:(BOOL)hidden {
    [super setHidden:hidden];
    
    if (hidden) {
        if (_videoDownloadStyle == kXYGIMVideoDownloadStyleWaiting ||
            _videoDownloadStyle == kXYGIMVideoDownloadStyleDownloading) {
            self.videoDownloadStyle = kXYGIMVideoDownloadStyleNone;
        }
    }
}


//FIXME: 虽然设置了autoresizingMask，可是在偶然的情况下，屏幕旋转时_HUD位置跑偏
//
- (void)layoutSubviews {
    [super layoutSubviews];
    
    _HUD.center = CGPointMake(self.bounds.size.width/2, self.bounds.size.height/2);
    _imageView.frame = self.bounds;
}

@end
