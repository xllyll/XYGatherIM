//
//  XYGIMGaoDeLocationViewController.m
//  XYGatherIM
//
//  Created by 杨卢银 on 2018/6/14.
//  Copyright © 2018年 杨卢银. All rights reserved.
//

#import "XYGIMGaoDeLocationViewController.h"
#define DEFAULT_SEARCH_AREA_SPAN_METER 1000

#define MAP_VIEW_SPAN_METER_PER_POINT 1.2

#define TABLE_VIEW_HEIGHT_MIN_FACTOR 0.416
#define TABLE_VIEW_HEIGHT_MAX_FACTOR 0.7

typedef NS_ENUM(NSInteger, XYGIMAroundSearchTableStyle) {
    kXYGIMAroundSearchTableStyleBeginSearch,  //开始附件POI搜索
    kXYGIMAroundSearchTableStyleReGeocodeComplete, //逆地理解析完成
    kXYGIMAroundSearchTableStylePOIPageSearchComplete,   //POI完成一页搜索
    kXYGIMAroundSearchTableStylePOIAllPageSearchComplete, //POI搜索全部结束
};

//只有当一次移动距离超过下面宏定义的距离后，才加载附近地点，单位米
#define MOVE_DISTANCE_RESPONCE_THREASHOLD 50

@interface XYGIMGaoDeLocationViewController ()

@end

@implementation XYGIMGaoDeLocationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
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
