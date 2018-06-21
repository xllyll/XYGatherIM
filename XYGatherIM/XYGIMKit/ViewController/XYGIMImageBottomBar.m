//
//  XYGIMImageBottomBar.m
//  XYGatherIM
//
//  Created by 杨卢银 on 2018/6/21.
//  Copyright © 2018年 杨卢银. All rights reserved.
//

#import "XYGIMImageBottomBar.h"
#import "XYUtils.h"
#import "UIColor+XYExt.h"
#import "XYConfig.h"

@implementation XYGIMImageBottomBar

- (void)awakeFromNib {
    [super awakeFromNib];
    self.downloadButton.layer.borderColor = UIColorRGB(90, 90, 90).CGColor;
    self.downloadButton.layer.borderWidth = 1;
    self.downloadButton.layer.cornerRadius = 3;
    self.downloadButton.backgroundColor = [UIColor colorWithWhite:0 alpha:0.4];
    self.downloadButton.alpha = 0;
    
}

- (void)setBottomBarStyle:(XYGIMImageBottomBarStyle)bottomBarStyle animated:(BOOL)animated {
    _style = bottomBarStyle;
    
    [UIView animateWithDuration:animated ? DEFAULT_DURATION : 0
                     animations:^{
                         switch (bottomBarStyle) {
                             case kXYGIMImageBottomBarStyleHide:
                                 self.moreButton.alpha = 0;
                                 self.downloadButton.alpha = 0;
                                 break;
                                 
                             case kXYGIMImageBottomBarStyleMore:
                                 self.moreButton.alpha = 1;
                                 self.downloadButton.alpha = 0;
                                 break;
                                 
                             case kXYGIMImageBottomBarStyleDownloading:
                                 self.moreButton.alpha = 0;
                                 self.downloadButton.alpha = 1;
                                 break;
                                 
                             case kXYGIMImageBottomBarStyleDownloadFullImage:
                                 self.moreButton.alpha = 1;
                                 self.downloadButton.alpha = 1;
                                 break;
                         }
                         
                     }];
    
}

- (void)setDownloadProgress:(NSInteger)progress {
    NSString *str = progress >= 100 ? @"已完成" : [NSString stringWithFormat:@"%ld%%", (long)progress];
    
    [self.downloadButton setTitle:str forState:UIControlStateNormal];
}

- (void)setDownloadFullImageSize:(NSString *)sizeString {
    [self.downloadButton setTitle:[NSString stringWithFormat:@"查看原图(%@)", sizeString] forState:UIControlStateNormal];
}

@end
