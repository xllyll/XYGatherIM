//
//  XYLoginViewController.m
//  XYGatherIM
//
//  Created by 杨卢银 on 2018/4/16.
//  Copyright © 2018年 杨卢银. All rights reserved.
//

#import "XYLoginViewController.h"
#import "XYRegisterViewController.h"
#import "XYGIMClient.h"
#import "MainTabbarViewController.h"


@interface XYLoginViewController ()

@property (weak, nonatomic) IBOutlet UITextField *userTF;

@property (weak, nonatomic) IBOutlet UITextField *passTF;

@property (weak, nonatomic) IBOutlet UIButton *loginBT;

@end

@implementation XYLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self dismissAllKeyBorad];
}
-(void)dismissAllKeyBorad{
    [_userTF resignFirstResponder];
    [_passTF resignFirstResponder];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (IBAction)loginSelect:(UIButton *)sender {
    [self dismissAllKeyBorad];
    
    [[XYGIMClient sharedClient] loginWithUsername:_userTF.text password:_passTF.text completion:^(NSString *aUsername, XYError *aError) {
        if (aUsername!=nil) {
            NSLog(@"登录成功✅");
            MainTabbarViewController *main = [[MainTabbarViewController alloc] init];
            [self presentViewController:main animated:YES completion:^{
                
            }];
        }else{
            NSLog(@"登录失败❌");
        }
    }];
}
- (IBAction)registerSelect:(UIButton *)sender {
    XYRegisterViewController *vc = [[XYRegisterViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

@end
