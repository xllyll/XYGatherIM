//
//  XYGIMAssetDisplayView.h
//  XYGatherIM
//
//  Created by 杨卢银 on 2018/6/21.
//  Copyright © 2018年 杨卢银. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XYNMessage.h"

@protocol XYGIMAssetDisplayView <NSObject>

@property (nonatomic) UIImageView *imageView;

@property (nonatomic) XYNMessage *messageModel;

@property (nonatomic) NSInteger assetIndex;

@property (nonatomic) XYGIMMessageBodyType messageBodyType;

@end
