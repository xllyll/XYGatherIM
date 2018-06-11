//
//  XYRegisterViewController.m
//  XYGatherIM
//
//  Created by 杨卢银 on 2018/4/16.
//  Copyright © 2018年 杨卢银. All rights reserved.
//

#import "XYRegisterViewController.h"
#import "XYGIMClient.h"

@interface XYRegisterViewController ()

@property (weak, nonatomic) IBOutlet UITextField *usernameTF;

@property (weak, nonatomic) IBOutlet UITextField *passwordTF;


@end

@implementation XYRegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)registerSelect:(id)sender {
    [[XYGIMClient sharedClient] registerWithUsername:_usernameTF.text password:_passwordTF.text completion:^(NSString *aUsername, XYError *aError) {
        
    }];
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
