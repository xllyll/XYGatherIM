//
//  MainTabbarViewController.m
//  XYGatherIM
//
//  Created by 杨卢银 on 2018/6/11.
//  Copyright © 2018年 杨卢银. All rights reserved.
//

#import "MainTabbarViewController.h"
#import "BaseNavgationViewController.h"
#import "XYChatListViewController.h"
#import "XYContactViewController.h"
#import "XYMoreViewController.h"

@interface MainTabbarViewController ()

@property (strong , nonatomic) XYChatListViewController *chatListVC;

@property (strong , nonatomic) XYContactViewController  *contactVC;

@property (strong , nonatomic) XYMoreViewController     *moreVC;


@end

@implementation MainTabbarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    [self setup];
}




-(void)setup{
    [self buildViewControllers];
}

-(void)buildViewControllers{
    
    _chatListVC = [[XYChatListViewController alloc] init];
    
    BaseNavgationViewController *chatListNav = [[BaseNavgationViewController alloc] initWithRootViewController:_chatListVC];
    chatListNav.tabBarItem.title = @"会话";
    
    _contactVC = [[XYContactViewController alloc] init];
    BaseNavgationViewController *contactNav = [[BaseNavgationViewController alloc] initWithRootViewController:_chatListVC];
    contactNav.tabBarItem.title = @"联系人";
    
    
    _moreVC = [[XYMoreViewController alloc] init];
    BaseNavgationViewController *moreNav = [[BaseNavgationViewController alloc] initWithRootViewController:_moreVC];
    moreNav.tabBarItem.title = @"更多";

    [self addChildViewController:chatListNav];
    [self addChildViewController:contactNav];
    [self addChildViewController:moreNav];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
