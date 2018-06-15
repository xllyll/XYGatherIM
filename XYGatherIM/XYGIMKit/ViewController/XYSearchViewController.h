//
//  XYSearchViewController.h
//  XYGatherIM
//
//  Created by 杨卢银 on 2018/6/14.
//  Copyright © 2018年 杨卢银. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XYSearchResultDelegate.h"
#import "XYSearchControllerDelegate.h"
#import "XYSearchBar.h"

#define HIDE_ANIMATION_DURATION 0.3
#define SHOW_ANIMATION_DURATION 0.3

@interface XYSearchViewController : UIViewController

@property (nonatomic) UIViewController<XYSearchResultDelegate>* searchResultController;

@property (nonatomic, weak) id<XYSearchControllerDelegate> delegate;

@property (nonatomic) XYSearchBar *searchBar;

+ (instancetype)sharedInstance;

+ (void)destoryInstance;

- (void)showInViewController:(UIViewController *)controller fromSearchBar:(UISearchBar *)fromSearchBar ;

- (void)dismissSearchController;

- (void)dismissKeyboard;

@end
