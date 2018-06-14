//
//  XYGIMGaoDeLocationViewController.h
//  XYGatherIM
//
//  Created by 杨卢银 on 2018/6/14.
//  Copyright © 2018年 杨卢银. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XYNMessage.h"

@class XYGIMGaoDeLocationViewController;

@protocol XYGIMLocationViewDelegate <NSObject>
@optional

-(XYNMessage *)didFinishWithLocationLatitude:(double)latitude
                                   longitude:(double)longitude
                                        name:(NSString *)name
                                     address:(NSString *)address
                                   zoomLevel:(double)zoomLevel
                                    snapshot:(UIImage *)snapshot;

- (void)didCancelLocationViewController:(XYGIMGaoDeLocationViewController *)locationViewController;

//地图截图完成
- (void)asyncTakeCenterSnapshotDidComplete:(UIImage *)resultImage forMessageModel:(XYNMessage *)messageModel;

@end

@interface XYGIMGaoDeLocationViewController : UIViewController

@end
