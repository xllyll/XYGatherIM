//
//  XYGIMImageBottomBar.h
//  XYGatherIM
//
//  Created by 杨卢银 on 2018/6/21.
//  Copyright © 2018年 杨卢银. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger, XYGIMImageBottomBarStyle) {
    kXYGIMImageBottomBarStyleHide,
    kXYGIMImageBottomBarStyleMore,
    kXYGIMImageBottomBarStyleDownloading,
    kXYGIMImageBottomBarStyleDownloadFullImage
};

@interface XYGIMImageBottomBar : UIView

@property (weak, nonatomic) IBOutlet UIButton *downloadButton;

@property (weak, nonatomic) IBOutlet UIButton *moreButton;

@property (nonatomic) XYGIMImageBottomBarStyle style;

- (void)setBottomBarStyle:(XYGIMImageBottomBarStyle)bottomBarStyle animated:(BOOL)animated;

- (void)setDownloadProgress:(NSInteger)progress;

- (void)setDownloadFullImageSize:(NSString *)sizeString;

@end
