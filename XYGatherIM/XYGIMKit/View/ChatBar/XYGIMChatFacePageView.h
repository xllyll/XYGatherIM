//
//  XYGIMFacePageView.h
//  XYGatherIM
//
//  Created by 杨卢银 on 2018/4/9.
//  Copyright © 2018年 杨卢银. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol XYGIMChatFacePageViewDelegate <NSObject>

- (void)selectedFaceImageWithFaceID:(NSUInteger)faceID;

@end

@interface XYGIMChatFacePageView : UIView

@property (nonatomic, assign) NSUInteger columnsPerRow;

@property (nonatomic, copy) NSArray *datas;

@property (nonatomic, weak) id<XYGIMChatFacePageViewDelegate> delegate;

@end
