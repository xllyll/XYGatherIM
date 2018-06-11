//
//  XYGIMFileCore+WangYiYun.h
//  XYGatherIM
//
//  Created by 杨卢银 on 2018/6/11.
//  Copyright © 2018年 杨卢银. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XYGIMFileCore.h"
#import "XYGIMLoginData.h"

@interface XYGIMFileCore (WangYiYun)

+(void)saveLoginData:(XYGIMLoginData*)loginData;

+(XYGIMLoginData*)getLoginData;

@end
