//
//  XYGIMChatVideoMessageCell.h
//  XYGatherIM
//
//  Created by 杨卢银 on 2018/6/12.
//  Copyright © 2018年 杨卢银. All rights reserved.
//

#import "XYGIMChatMessageCell.h"

@interface XYGIMChatVideoMessageCell : XYGIMChatMessageCell

- (void)setUploadProgress:(CGFloat)uploadProgress;

- (void)setDownloadProgress:(CGFloat)downloadProgress;

- (void)dismissProgress;

- (void)showVideo;


- (void)willExitFullScreenShow;

- (void)didExitFullScreenShow;
@end
