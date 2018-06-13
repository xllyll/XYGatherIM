//
//  XYChatListViewController.m
//  XYGatherIM
//
//  Created by 杨卢银 on 2018/6/11.
//  Copyright © 2018年 杨卢银. All rights reserved.
//

#import "XYChatListViewController.h"
#import "XYGIMClient.h"

@interface XYChatListViewController ()

@property (strong , nonatomic) NSArray<XYGIMConversation*> *conversations;

@end

@implementation XYChatListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setup];
}
- (void)setup{
    self.title = @"会话";
    
    _conversations = [XYGIMClient sharedClient].chatManager.getAllConversations;
    
    NSLog(@"");
    
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
