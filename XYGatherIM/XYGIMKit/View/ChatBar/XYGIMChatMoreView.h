//
//  XYGIMChatMoreView.h
//  XYGatherIM
//
//  Created by 杨卢银 on 2018/4/9.
//  Copyright © 2018年 杨卢银. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *  moreItem类型
 */
typedef NS_ENUM(NSUInteger, XYGIMChatMoreItemType){
    XYGIMChatMoreItemAlbum = 0           /**< 显示拍照 */,
    XYGIMChatMoreItemCamera               /**< 显示相册 */,
    XYGIMChatMoreItemVideo                /**< 显示视频 */,
    XYGIMChatMoreItemLocation             /**< 显示地理位置 */,
    XYGIMChatMoreItemCallAudio            /**< 显示语音通话 */,
    XYGIMChatMoreItemCallVideo            /**< 显示视频通话 */,
    XYGIMChatMoreItemLuckyMoney           /**< 显示红包 */,
    XYGIMChatMoreItemAudio                /**< 显示音频 */,
};

@protocol XYGIMChatMoreViewDataSource;
@protocol XYGIMChatMoreViewDelegate;
/**
 *  更多view
 */
@interface XYGIMChatMoreView : UIView
@property (weak, nonatomic) id<XYGIMChatMoreViewDelegate> delegate;
@property (weak, nonatomic) id<XYGIMChatMoreViewDataSource> dataSource;

@property (assign, nonatomic) NSUInteger numberPerLine;
@property (assign, nonatomic) UIEdgeInsets edgeInsets;

-(void)reloadView;

- (void)reloadData;
@end
@protocol XYGIMChatMoreViewDelegate <NSObject>

@optional
/**
 *  moreView选中的index
 */
- (void)moreView:(XYGIMChatMoreView *)moreView selectIndex:(XYGIMChatMoreItemType)itemType;

@end

@protocol XYGIMChatMoreViewDataSource <NSObject>

@required
/**
 *  获取数组中一共有多少个titles
 */

- (NSArray *)titlesOfMoreView:(XYGIMChatMoreView *)moreView;

/**
 *  获取moreView展示的所有图片
 */
- (NSArray *)imageNamesOfMoreView:(XYGIMChatMoreView *)moreView;

@end
