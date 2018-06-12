//
//  XYContactViewController.m
//  XYGatherIM
//
//  Created by 杨卢银 on 2018/6/11.
//  Copyright © 2018年 杨卢银. All rights reserved.
//

#import "XYContactViewController.h"
#import "XYGIMClient.h"
#import "XYContactTableViewCell.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "XYGIMChatViewController.h"

@interface XYContactViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (strong , nonatomic)NSArray *friends;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@end

@implementation XYContactViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setup];
    [self loadData];
}
- (void)setup{
    self.title = @"联系人";
    
    _tableView.dataSource = self;
    _tableView.delegate = self;
    UIView *v = [[UIView alloc] init];
    v.backgroundColor = [UIColor clearColor];
    _tableView.tableFooterView = v;
    
}
-(void)loadData{
    _friends = [XYGIMClient sharedClient].contactManager.getContacts;
    XYLog(@"");
    [_tableView reloadData];
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
    return 2;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section==0) {
        return 0;
    }
    return _friends.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0) {
        return nil;
    }
    
    XYContactTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (!cell) {
        cell  = [[XYContactTableViewCell alloc] initWithReuseIdentifier:@"Cell"];
    }
    XYGIMUser *u = _friends[indexPath.row];
    [cell.imageView sd_setImageWithURL:[NSURL URLWithString:u.userInfo.avatarUrl] placeholderImage:nil];
    cell.textLabel.text = u.userId;
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    XYGIMUser *u = _friends[indexPath.row];
    XYGIMChatViewController *vc = [[XYGIMChatViewController alloc] init];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}
@end
