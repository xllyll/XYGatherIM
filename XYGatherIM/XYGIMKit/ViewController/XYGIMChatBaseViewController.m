//
//  XYChatBaseViewController.m
//  XYGatherIM
//
//  Created by 杨卢银 on 2018/6/11.
//  Copyright © 2018年 杨卢银. All rights reserved.
//

#import "XYGIMChatBaseViewController.h"
#import "UITableView+XYGIMNCellRegister.h"

@interface XYGIMChatBaseViewController ()

@end

@implementation XYGIMChatBaseViewController


-(instancetype)initWithConversationChatter:(NSString *)conversationChatter conversationType:(XYGIMConversationType)conversationType{
    self = [super initWithNibName:nil bundle:nil];
    if (self) {
        _conversation = [[XYGIMClient sharedClient].chatManager getConversation:conversationChatter type:conversationType createIfNotExist:YES];
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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
#pragma mark - Getters

- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - kMinHeight - 64) style:UITableViewStylePlain];
        
        _tableView.estimatedRowHeight = 66;
        _tableView.delegate = self.chatViewModel;
        _tableView.dataSource = self.chatViewModel;
        //
        [_tableView registerXYGIMNChatMessageCellClass];
        
        _tableView.backgroundColor = self.view.backgroundColor;
        
        _tableView.contentInset = UIEdgeInsetsMake(8, 0, 0, 0);
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        
        
    }
    return _tableView;
}
- (XYGIMChatBar *)chatBar {
    if (!_chatBar) {
        
        CGRect rect = CGRectMake(0, self.view.frame.size.height - kMinHeight - (self.navigationController.navigationBar.isTranslucent ? 0 : 64), self.view.frame.size.width, kMinHeight);
        
        _chatBar = [[XYGIMChatBar alloc] initWithFrame:rect rootVC:self isSingleChat:YES];
        [_chatBar setSuperViewHeight:[UIScreen mainScreen].bounds.size.height - (self.navigationController.navigationBar.isTranslucent ? 0 : 64)];
        
    }
    return _chatBar;
}


@end
