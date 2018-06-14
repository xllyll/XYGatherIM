//
//  XYGIMLocationMessageBody.h
//  XYGatherIM
//
//  Created by 杨卢银 on 2018/6/14.
//  Copyright © 2018年 杨卢银. All rights reserved.
//

#import "XYGIMMessageBody.h"

/**
 位置消息体
 */
@interface XYGIMLocationMessageBody : XYGIMMessageBody
/*!
 *  \~chinese
 *  纬度
 *
 *  \~english
 *  Location latitude
 */
@property (nonatomic) double latitude;

/*!
 *  \~chinese
 *  经度
 *
 *  \~english
 *  Loctaion longitude
 */
@property (nonatomic) double longitude;

/*!
 *  \~chinese
 *  地址信息
 *
 *  \~english
 *  Address
 */
@property (nonatomic, copy) NSString *address;

/*!
 *  \~chinese
 *  初始化位置消息体
 *
 *  @param aLatitude   纬度
 *  @param aLongitude  经度
 *  @param aAddress    地理位置信息
 *
 *  @result 位置消息体实例
 */
- (instancetype)initWithLatitude:(double)aLatitude
                       longitude:(double)aLongitude
                         address:(NSString *)aAddress;
@end
