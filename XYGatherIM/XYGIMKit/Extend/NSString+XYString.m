//
//  NSString+XYString.m
//  XYGatherIM
//
//  Created by 杨卢银 on 2018/4/16.
//  Copyright © 2018年 杨卢银. All rights reserved.
//

#import "NSString+XYString.h"
#import "XYUtils.h"

@implementation NSString (XYString)

-(NSString *)md5String{
    
    return [XYUtils md5:self];
    
}
-(NSString *)md5_32_String{
    
    return [XYUtils md5_32:self];
}

@end
