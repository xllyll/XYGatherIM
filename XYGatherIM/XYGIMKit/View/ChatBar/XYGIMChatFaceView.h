//
//  XYGIMChatFaceView.h
//  XYGatherIM
//
//  Created by 杨卢银 on 2018/4/9.
//  Copyright © 2018年 杨卢银. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, XYGIMShowFaceViewType) {
    XYGIMShowEmojiFace = 0,
    XYGIMShowRecentFace,
    XYGIMShowGifFace,
};
@protocol XYGIMChatFaceViewDelegate <NSObject>

- (void)faceViewSendFace:(NSString *)faceName;

@end

@interface XYGIMChatFaceView : UIView

@property (weak, nonatomic) id<XYGIMChatFaceViewDelegate> delegate;

@property (assign, nonatomic) XYGIMShowFaceViewType faceViewType;

-(void)reloadView;
@end
