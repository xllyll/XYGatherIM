//
//  NSDate+XYDate.h
//  XYGatherIM
//
//  Created by 杨卢银 on 2018/6/13.
//  Copyright © 2018年 杨卢银. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (XYDate)

/**标准时间日期描述*/
-(NSString *)formattedTime;

+ (NSDate *)dateWithTimeIntervalInMilliSecondSince1970:(double)timeIntervalInMilliSecond;

/**标准时间日期描述*/
+ (NSString *)formattedDateDescription:(NSDate*)date;

@end
