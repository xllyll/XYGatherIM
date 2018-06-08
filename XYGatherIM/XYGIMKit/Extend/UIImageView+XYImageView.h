//
//  UIImageView+XYImageView.h
//  XYGatherIM
//
//  Created by 杨卢银 on 2018/4/16.
//  Copyright © 2018年 杨卢银. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImageView (XYImageView)

/**
 *  设置图片
 *
 *  @param imageUrlString 图片链接
 *  @param placeimage     默认图片
 */
- (void)xy_setImageURL:(NSString*)imageUrlString placeholderImage:(UIImage *)placeimage;

- (void)xy_setImageURLByLoading:(NSString*)imageUrlString placeholderImage:(UIImage *)placeimage;


@end
