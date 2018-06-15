//
//  XYLocationSearchResultController.h
//  XYGatherIM
//
//  Created by 杨卢银 on 2018/6/14.
//  Copyright © 2018年 杨卢银. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "XYSearchResultDelegate.h"
#import "XYGIMGaoDeLocationViewController.h"
#import "XYSearchViewController.h"

@interface XYLocationSearchResultController : UIViewController<XYSearchResultDelegate>

@property (nonatomic, weak) XYGIMGaoDeLocationViewController *gaodeViewController;

@property (nonatomic, weak) XYSearchViewController *searchViewController;


@end
