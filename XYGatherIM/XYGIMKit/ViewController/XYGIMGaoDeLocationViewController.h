//
//  XYGIMGaoDeLocationViewController.h
//  XYGatherIM
//
//  Created by 杨卢银 on 2018/6/14.
//  Copyright © 2018年 杨卢银. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XYNMessage.h"
#import "XYNavigationController.h"
#import <MAMapKit/MAMapKit.h>
#import <AMapLocationKit/AMapLocationKit.h>
#import <AMapSearchKit/AMapSearchKit.h>

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

@property (nonatomic, weak) id<XYGIMLocationViewDelegate> delegate;

- (void)didRowWithModelSelected:(AMapPOI *)poiModel;

@end
