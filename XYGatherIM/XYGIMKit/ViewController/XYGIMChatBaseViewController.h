//
//  XYChatBaseViewController.h
//  XYGatherIM
//
//  Created by 杨卢银 on 2018/6/11.
//  Copyright © 2018年 杨卢银. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XYGIMChatBar.h"
#import "XYGIMChatViewModel.h"

@interface XYGIMChatBaseViewController : UIViewController

@property (strong, nonatomic) UITableView *tableView;

@property (strong, nonatomic) XYGIMChatBar *chatBar;

@property (nonatomic, strong) XYGIMChatViewModel *chatViewModel;

@property (assign, nonatomic) XYGIMNMessageChat messageChatType;

@end
