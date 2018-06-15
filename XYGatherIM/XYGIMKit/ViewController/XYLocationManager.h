//
//  XYLocationManager.h
//  XYGatherIM
//
//  Created by 杨卢银 on 2018/6/15.
//  Copyright © 2018年 杨卢银. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MAMapKit/MAMapKit.h>
#import <AMapSearchKit/AMapSearchKit.h>

@interface XYLocationManager : NSObject

+ (instancetype)sharedManager;

- (void)takeSnapshotAtCoordinate:(CLLocationCoordinate2D)coordinate2D spanSize:(CGSize)size withCompletionBlock:(void (^)(UIImage *resultImage, CGRect rect))block;

- (void)reGeocodeFromCoordinate:(CLLocationCoordinate2D)coordinate2D completeCallback:(void (^)(AMapReGeocode *address, CLLocationCoordinate2D coordinate2D))completeCallback;

- (void)getLocationNameAndAddressFromReGeocode:(AMapReGeocode *)reGeoCode name:(NSString **)name address:(NSString **)address;

- (UIImage *)takeCenterSnapshotFromMapView:(MAMapView *)mapView;

- (void)takeCenterSnapshotFromMapView:(MAMapView *)mapView withCompletionBlock:(void (^)(UIImage *resultImage, CGRect rect))block;

-(void)navigationFromCurrentLocationToLocationUsingAppleMap:(CLLocationCoordinate2D)toCoordinate2D
                                            destinationName:(NSString *)destinationName;

-(void)navigationUsingGaodeMapFromLocation:(CLLocationCoordinate2D)fromCoordinate2D
                                toLocation:(CLLocationCoordinate2D)toCoordinate2D
                           destinationName:(NSString *)destinationName;

@end
