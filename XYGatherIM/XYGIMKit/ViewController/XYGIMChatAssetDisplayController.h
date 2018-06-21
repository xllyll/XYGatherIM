//
//  XYGIMChatAssetDisplayController.h
//  XYGatherIM
//
//  Created by 杨卢银 on 2018/6/21.
//  Copyright © 2018年 杨卢银. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XYNMessage.h"
#import "XYGIMVideoDownloadStatusHUD.h"
#import "XYGIMAssetDisplayView.h"



@protocol XYGIMChatImagePreviewDelegate <NSObject>

- (void)didFinishWithMessageModel:(XYNMessage *)model targetView:(UIView<XYGIMAssetDisplayView> *)assetView scrollToTop:(BOOL)scrollToTop;

@end
@interface XYGIMChatAssetDisplayController : UIViewController

@property (nonatomic, weak) id<XYGIMChatImagePreviewDelegate> delegate;
@property (nonatomic) NSArray<XYNMessage *> *allAssets;
@property (nonatomic) XYNMessage *curShowMessageModel;

@property (nonatomic) CGRect originalWindowFrame;

- (void)HUDDidTapped:(XYGIMVideoDownloadStatusHUD *)HUD;

@end
