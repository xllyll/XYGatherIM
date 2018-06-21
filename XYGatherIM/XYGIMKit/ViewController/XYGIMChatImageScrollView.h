//
//  XYGIMChatImageScrollView.h
//  XYGatherIM
//
//  Created by 杨卢银 on 2018/6/21.
//  Copyright © 2018年 杨卢银. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XYNMessage.h"
#import "XYGIMAssetDisplayView.h"


#define MinimumZoomScale 1
#define MaximumZoomScale 2

@interface XYGIMChatImageScrollView : UIScrollView<XYGIMAssetDisplayView>

@property (nonatomic) CGSize imageSize;

- (void)layoutImageView:(CGSize)size;

- (void)setDownloadFailImage;

- (BOOL)shouldZoom;

@end
