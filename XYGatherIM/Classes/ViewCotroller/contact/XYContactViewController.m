//
//  XYContactViewController.m
//  XYGatherIM
//
//  Created by 杨卢银 on 2018/6/11.
//  Copyright © 2018年 杨卢银. All rights reserved.
//

#import "XYContactViewController.h"
#import "XYGIMClient.h"

@interface XYContactViewController ()
@property (strong , nonatomic)NSArray *friends;
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
}
-(void)loadData{
    _friends = [XYGIMClient sharedClient].contactManager.getContacts;
    XYLog(@"");
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
