//
//  XYGIMChatBar.h
//  XYGatherIM
//
//  Created by 杨卢银 on 2018/4/9.
//  Copyright © 2018年 杨卢银. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

#define kMaxHeight 90.0f
#define kMinHeight 49.0f
#define kFunctionViewHeight 210.0f
/**
 *  functionView 类型
 */
typedef NS_ENUM(NSUInteger, XYGIMFunctionViewShowType){
    XYGIMFunctionViewShowNothing /**< 不显示functionView */,
    XYGIMFunctionViewShowFace    /**< 显示表情View */,
    XYGIMFunctionViewShowVoice   /**< 显示录音view */,
    XYGIMFunctionViewShowMore    /**< 显示更多view */,
    XYGIMFunctionViewShowKeyboard /**< 显示键盘 */,
};

@protocol XYGIMChatBarDelegate;





@interface XYGIMChatBar : UIView

@property (copy, nonatomic) NSString *chatterId;

@property (assign, nonatomic) CGFloat superViewHeight;

-(instancetype)initWithFrame:(CGRect)frame rootVC:(UIViewController*)rootVC isSingleChat:(BOOL)issingle;

@property (weak, nonatomic) id<XYGIMChatBarDelegate> delegate;

-(void)reloadView:(CGRect)rect;

-(void)dismissView;


/**
 *  结束输入状态
 */
- (void)endInputing;


@property (strong, nonatomic) UIViewController *rootViewController;


@end


/**
 *  XMChatBar代理事件,发送图片,地理位置,文字,语音信息等
 */
@protocol XYGIMChatBarDelegate <NSObject>


@optional


/**
 *  chatBarFrame改变回调
 */
- (void)chatBarFrameDidChange:(XYGIMChatBar *)chatBar frame:(CGRect)frame;


/**
 *  发送图片信息,支持多张图片
 */
- (void)chatBar:(XYGIMChatBar *)chatBar sendPictures:(NSArray *)pictures;
- (void)chatBar:(XYGIMChatBar *)chatBar sendImageDatas:(NSArray *)imagesDatas;
/**
 *  发送视频信息
 */
- (void)chatBar:(XYGIMChatBar *)chatBar sendVideo:(NSURL *)video_url;

/**
 *  发送地理位置信息
 */
- (void)chatBar:(XYGIMChatBar *)chatBar sendLocation:(CLLocationCoordinate2D)locationCoordinate locationText:(NSString *)locationText;

/**
 *  发送普通的文字信息,可能带有表情
 */
- (void)chatBar:(XYGIMChatBar *)chatBar sendMessage:(NSString *)message;

/**
 *  发送语音信息
 */
- (void)chatBar:(XYGIMChatBar *)chatBar sendVoice:(NSString *)voiceFileName seconds:(NSTimeInterval)seconds;
/**
 *  发送即时语音信息
 */
- (void)chatBar:(XYGIMChatBar *)chatBar sendCall:(NSString *)callURL isCaller:(BOOL)isCaller;



@end
