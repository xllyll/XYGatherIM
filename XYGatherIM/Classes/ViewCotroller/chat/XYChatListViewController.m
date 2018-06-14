//
//  XYChatListViewController.m
//  XYGatherIM
//
//  Created by 杨卢银 on 2018/6/11.
//  Copyright © 2018年 杨卢银. All rights reserved.
//

#import "XYChatListViewController.h"
#import "XYGIMClient.h"
#import "XYChatListTableViewCell.h"
#import "NSDate+XYDate.h"
#import "XYGIMChatViewController.h"

@interface XYChatListViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (strong , nonatomic) NSArray<XYGIMConversation*> *conversations;

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation XYChatListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setup];
}
- (void)setup{
    self.title = @"会话";
    _tableView.delegate = self;
    UIView *v = [[UIView alloc] init];
    v.backgroundColor = [UIColor clearColor];
    _tableView.tableFooterView = v;
    _tableView.dataSource = self;
    [_tableView registerNib:[UINib nibWithNibName:@"XYChatListTableViewCell" bundle:nil] forCellReuseIdentifier:@"CELL"];
    //[self reloadData];
    
}
-(void)reloadData{
    _conversations = [XYGIMClient sharedClient].chatManager.getAllConversations;
    [self getUnreadMessageCount];
    [self.tableView reloadData];
    
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self reloadData];
}
-(NSInteger)getUnreadMessageCount{
    NSInteger count = 0;
    for (XYGIMConversation *c in _conversations) {
        count += c.unreadMessagesCount;
    }
    if (count>0) {
        self.navigationController.tabBarItem.badgeValue = [NSString stringWithFormat:@"%d",(int)count];
    }else{
        self.navigationController.tabBarItem.badgeValue = nil;
    }
    return count;
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
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _conversations.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    XYChatListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CELL"];
    XYGIMConversation *c = _conversations[indexPath.row];
    cell.nameLabel.text = c.conversationId;
    cell.timeLabel.text = [c showTime];
    cell.badgeValue = c.unreadMessagesCount;
    if (c.type==XYGIMConversationTypeGroupChat) {
        cell.headerImageView.image = [UIImage imageNamed:@"add_friend_icon_addgroup"];
    }
    if (c.type==XYGIMConversationTypeChat) {
        cell.headerImageView.image = [UIImage imageNamed:@"user"];
    }
    cell.messageLabel.text = c.latestMessage.text;
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 72.0;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    XYGIMConversation *c = _conversations[indexPath.row];
    
    XYGIMChatViewController *vc = [[XYGIMChatViewController alloc] initWithConversationChatter:c.conversationId conversationType:c.type];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}
@end
