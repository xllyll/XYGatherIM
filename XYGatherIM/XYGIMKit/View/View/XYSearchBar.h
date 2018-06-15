//
//  XYSearchBar.h
//  XYGatherIM
//
//  Created by 杨卢银 on 2018/6/14.
//  Copyright © 2018年 杨卢银. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XYColors.h"

#define SEARCH_TEXT_FIELD_HEIGHT 28

@interface XYSearchBar : UISearchBar

+ (NSInteger)defaultSearchBarHeight;

+ (instancetype)defaultSearchBar;

+ (instancetype)defaultSearchBarWithFrame:(CGRect)frame;

- (UITextField *)searchTextField;

- (UIButton *)searchCancelButton;

- (void)resignFirstResponderWithCancelButtonRemainEnabled;

- (void)configCancelButton;

@end
