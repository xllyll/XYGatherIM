//
//  ViewController.m
//  XYGatherIM
//
//  Created by 杨卢银 on 2018/3/20.
//  Copyright © 2018年 杨卢银. All rights reserved.
//

#import "ViewController.h"
#import "XYLoginViewController.h"
#import "XYGIMClient.h"
#import "MainTabbarViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
//    for(int a= 0;a<3;a++){
//        for (int i = 0; i < 155; i++) {
//            printf("INSERT INTO map_role_permissions (permission_id,role_id) VALUES(%d,%d);\n",i+1,a+1);
//        }
//    }
    [self performSelector:@selector(setup) withObject:nil afterDelay:2];
}
- (void)setup{
    
    if ([[XYGIMClient sharedClient] isAutoLogin]) {
        MainTabbarViewController *main = [[MainTabbarViewController alloc] init];
        [self presentViewController:main animated:YES completion:^{
            
        }];
        return;
    }
    
    XYLoginViewController *loginVC = [[XYLoginViewController alloc] init];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:loginVC];
    
    [self presentViewController:nav animated:YES completion:^{
        
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
