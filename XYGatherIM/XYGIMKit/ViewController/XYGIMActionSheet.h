//
//  XYGIMActionSheet.h
//  XYGatherIM
//
//  Created by 杨卢银 on 2018/6/21.
//  Copyright © 2018年 杨卢银. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger, XYGIMActionStyle) {
    kXYGIMActionStyleDefault = 0,
    //    kXYGIMActionStyleCancel,
    kXYGIMActionStyleDestructive
};


@class XYGIMActionSheetAction;

typedef void (^ACTION_BLOCK)(XYGIMActionSheetAction *action);

@interface XYGIMActionSheetAction  : NSObject

@property (nonatomic, copy) NSString *title;

@property (nonatomic) XYGIMActionStyle style;

@property (nonatomic, copy) ACTION_BLOCK handler;

+ (instancetype)actionWithTitle:(NSString *)title handler:(ACTION_BLOCK)handler;

+ (instancetype)actionWithTitle:(NSString *)title handler:(ACTION_BLOCK)handler style:(XYGIMActionStyle)style;

@end

extern XYGIMActionSheetAction *LL_ActionSheetSeperator;

@interface XYGIMActionSheet : UIView

- (instancetype)initWithTitle:(NSString *)title;

- (void)addAction:(XYGIMActionSheetAction *)action;

- (void)addActions:(NSArray<XYGIMActionSheetAction *> *)actions;

- (void)showInWindow:(UIWindow *)window;

- (void)hideInWindow:(UIWindow *)window;

@end
