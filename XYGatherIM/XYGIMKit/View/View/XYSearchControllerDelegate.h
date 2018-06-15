//
//  XYSearchControllerDelegate.h
//  XYGatherIM
//
//  Created by 杨卢银 on 2018/6/14.
//  Copyright © 2018年 杨卢银. All rights reserved.
//

#import <Foundation/Foundation.h>

@class XYSearchViewController;
@protocol XYSearchControllerDelegate <NSObject>

@optional
- (void)willDismissSearchController:(XYSearchViewController *)searchController;

- (void)didDismissSearchController:(XYSearchViewController *)searchController;

- (void)willPresentSearchController:(XYSearchViewController *)searchController;

- (void)didPresentSearchController:(XYSearchViewController *)searchController;

@end
