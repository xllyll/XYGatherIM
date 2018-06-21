//
//  XYGIMVideoPlaybackView.h
//  XYGatherIM
//
//  Created by 杨卢银 on 2018/6/21.
//  Copyright © 2018年 杨卢银. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVKit/AVKit.h>

@interface XYGIMVideoPlaybackView : UIView

@property (nonatomic, strong) AVPlayer* player;

- (void)setPlayer:(AVPlayer*)player;

- (void)setVideoFillMode:(NSString *)fillMode;
@end
