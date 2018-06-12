//
//  XYChatViewController.h
//  XYGatherIM
//
//  Created by 杨卢银 on 2018/4/9.
//  Copyright © 2018年 杨卢银. All rights reserved.
//

#import "XYGIMChatBaseViewController.h"

@interface XYGIMChatViewController : XYGIMChatBaseViewController

@property (copy, nonatomic) NSString *chatterName /**< 正在聊天的用户昵称 */;

@property (copy, nonatomic) NSString *chatterThumb /**< 正在聊天的用户头像 */;

@end
