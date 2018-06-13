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
#import "XYGIMClient.h"

@interface MainTabbarViewController ()<XYGIMChatManagerDelegate>

@property (strong , nonatomic) XYChatListViewController *chatListVC;

@property (strong , nonatomic) XYContactViewController  *contactVC;

@property (strong , nonatomic) XYMoreViewController     *moreVC;


@end

@implementation MainTabbarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    [self setup];
    
    [[XYGIMClient sharedClient].chatManager addDelegate:self delegateQueue:nil];
}

-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    [[XYGIMClient sharedClient].chatManager removeDelegate:self];
}


-(void)setup{
    [self buildViewControllers];
}

-(void)buildViewControllers{
    
    self.tabBar.tintColor  = [UIColor colorWithRed:26.0/255.0 green:178.0/255.0 blue:10.0/255.0 alpha:1.0];
    
    _chatListVC = [[XYChatListViewController alloc] init];
    
    BaseNavgationViewController *chatListNav = [[BaseNavgationViewController alloc] initWithRootViewController:_chatListVC];
    chatListNav.tabBarItem.title = @"会话";
    chatListNav.tabBarItem.image = [UIImage imageNamed:@"tabbar_mainframe"];
    chatListNav.tabBarItem.selectedImage = [UIImage imageNamed:@"tabbar_mainframeHL"];
    
    _contactVC = [[XYContactViewController alloc] init];
    BaseNavgationViewController *contactNav = [[BaseNavgationViewController alloc] initWithRootViewController:_contactVC];
    contactNav.tabBarItem.title = @"联系人";
    contactNav.tabBarItem.image = [UIImage imageNamed:@"tabbar_contacts"];
    contactNav.tabBarItem.selectedImage = [UIImage imageNamed:@"tabbar_contactsHL"];
    
    _moreVC = [[XYMoreViewController alloc] init];
    BaseNavgationViewController *moreNav = [[BaseNavgationViewController alloc] initWithRootViewController:_moreVC];
    moreNav.tabBarItem.title = @"更多";
    moreNav.tabBarItem.image = [UIImage imageNamed:@"tabbar_me"];
    moreNav.tabBarItem.selectedImage = [UIImage imageNamed:@"tabbar_meHL"];
    self.viewControllers = @[chatListNav,contactNav,moreNav];
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
-(void)XYGIM_onRecvMessages:(NSArray<XYGIMMessage *> *)messages{
    NSLog(@"");
    [_chatListVC reloadData];
}
@end
