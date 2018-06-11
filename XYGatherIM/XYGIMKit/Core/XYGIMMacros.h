//
//  XYGIMMacros.h
//  XYGatherIM
//
//  Created by 杨卢银 on 2018/4/16.
//  Copyright © 2018年 杨卢银. All rights reserved.
//

#ifndef XYGIMMacros_h
#define XYGIMMacros_h

/// 沙盒 / 通知
#define kUSERDEFAULTS [NSUserDefaults standardUserDefaults]
#define kNSNOTIFICATIONS [NSNotificationCenter defaultCenter]




/* ****************************************************************************************************************** */
/** DEBUG LOG **/
#ifdef DEBUG
#define XYLog(FORMAT, ...) fprintf(stderr,"<XYGIMSDK> %s:%d \t%s\n",[[[NSString stringWithUTF8String:__FILE__] lastPathComponent] UTF8String], __LINE__, [[NSString stringWithFormat:FORMAT, ##__VA_ARGS__] UTF8String]);
#else
#define XYLog(FORMAT, ...) nil
#endif

/* ****************************************************************************************************************** */

// 当前版本
#define FSystemVersion          ([[[UIDevice currentDevice] systemVersion] floatValue])
#define DSystemVersion          ([[[UIDevice currentDevice] systemVersion] doubleValue])
#define SSystemVersion          ([[UIDevice currentDevice] systemVersion])

// 当前语言
#define CURRENTLANGUAGE         ([[NSLocale preferredLanguages] objectAtIndex:0])

// 是否Retina屏
#define isRetina                ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? \
CGSizeEqualToSize(CGSizeMake(640, 960), \
[[UIScreen mainScreen] currentMode].size) : \
NO)

// 是否iPhone5
#define isiPhone5               ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? \
CGSizeEqualToSize(CGSizeMake(640, 1136), \
[[UIScreen mainScreen] currentMode].size) : \
NO)
// 是否iPhone5
#define isiPhone4               ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? \
CGSizeEqualToSize(CGSizeMake(640, 960), \
[[UIScreen mainScreen] currentMode].size) : \
NO)

// 是否IOS7
#define IsIOS7                  ([[[UIDevice currentDevice]systemVersion]floatValue] >= 7.0)
// 是否IOS6
#define IsIOS6                  ([[[UIDevice currentDevice]systemVersion]floatValue] < 7.0)
#define IsIOS11                  ([[[UIDevice currentDevice]systemVersion]floatValue] == 11.0)


#define SCREEN_WIDTH ([[UIScreen mainScreen] bounds].size.width)
#define SCREEN_HEIGHT ([[UIScreen mainScreen] bounds].size.height)
#define SCREEN_MAX_LENGTH (MAX(SCREEN_WIDTH, SCREEN_HEIGHT))
#define SCREEN_MIN_LENGTH (MIN(SCREEN_WIDTH, SCREEN_HEIGHT))
// 是否iPad
#define IsPad                   (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
#define IS_IPHONE               (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
#define IS_IPHONE_X             (IS_IPHONE && SCREEN_MAX_LENGTH == 812)
// UIView - viewWithTag
#define VIEWWITHTAG(_OBJECT, _TAG)\
\
[_OBJECT viewWithTag : _TAG]

#endif /* XYGIMMacros_h */
