//
//  UITableView+FUNCellRegister.m
//  FUContact
//
//  Created by 杨卢银 on 16/6/30.
//  Copyright © 2016年 杨卢银. All rights reserved.
//

#import "UITableView+XYGIMNCellRegister.h"
#import "XYGIMChatTextMessageCell.h"
#import "XYGIMChatImageMessageCell.h"
#import "XYGIMChatImageExpressMessageCell.h"
#import "XYGIMChatVoiceMessageCell.h"
#import "XYGIMChatSystemMessageCell.h"
#import "XYGIMChatLocationMessageCell.h"
#import "XYGIMChatVideoMessageCell.h"
#import "XYGIMChatVideoCallMessageCell.h"
#import "XYGIMChatAudioCallMessageCell.h"

@implementation UITableView(XYGIMNCellRegister)

-(void)registerXYGIMNChatMessageCellClass{
    
    [self registerClass:[XYGIMChatVideoCallMessageCell class] forCellReuseIdentifier:@"XYGIMChatMessageCell_OwnerSelf_CallVideoMessage_GroupCell"];
    [self registerClass:[XYGIMChatVideoCallMessageCell class] forCellReuseIdentifier:@"XYGIMChatMessageCell_OwnerSelf_CallVideoMessage_SingleCell"];
    [self registerClass:[XYGIMChatVideoCallMessageCell class] forCellReuseIdentifier:@"XYGIMChatMessageCell_OwnerOther_CallVideoMessage_GroupCell"];
    [self registerClass:[XYGIMChatVideoCallMessageCell class] forCellReuseIdentifier:@"XYGIMChatMessageCell_OwnerOther_CallVideoMessage_SingleCell"];
    
    [self registerClass:[XYGIMChatAudioCallMessageCell class] forCellReuseIdentifier:@"XYGIMChatMessageCell_OwnerSelf_CallAudioMessage_GroupCell"];
    [self registerClass:[XYGIMChatAudioCallMessageCell class] forCellReuseIdentifier:@"XYGIMChatMessageCell_OwnerSelf_CallAudioMessage_SingleCell"];
    [self registerClass:[XYGIMChatAudioCallMessageCell class] forCellReuseIdentifier:@"XYGIMChatMessageCell_OwnerOther_CallAudioMessage_GroupCell"];
    [self registerClass:[XYGIMChatAudioCallMessageCell class] forCellReuseIdentifier:@"XYGIMChatMessageCell_OwnerOther_CallAudioMessage_SingleCell"];
    
    [self registerClass:[XYGIMChatImageMessageCell class] forCellReuseIdentifier:@"XYGIMChatMessageCell_OwnerSelf_ImageMessage_GroupCell"];
    [self registerClass:[XYGIMChatImageMessageCell class] forCellReuseIdentifier:@"XYGIMChatMessageCell_OwnerSelf_ImageMessage_SingleCell"];
    [self registerClass:[XYGIMChatImageMessageCell class] forCellReuseIdentifier:@"XYGIMChatMessageCell_OwnerOther_ImageMessage_GroupCell"];
    [self registerClass:[XYGIMChatImageMessageCell class] forCellReuseIdentifier:@"XYGIMChatMessageCell_OwnerOther_ImageMessage_SingleCell"];
    
    
    [self registerClass:[XYGIMChatImageExpressMessageCell class] forCellReuseIdentifier:@"XYGIMChatMessageCell_OwnerSelf_ImageExpressMessage_GroupCell"];
    [self registerClass:[XYGIMChatImageExpressMessageCell class] forCellReuseIdentifier:@"XYGIMChatMessageCell_OwnerSelf_ImageExpressMessage_SingleCell"];
    [self registerClass:[XYGIMChatImageExpressMessageCell class] forCellReuseIdentifier:@"XYGIMChatMessageCell_OwnerOther_ImageExpressMessage_GroupCell"];
    [self registerClass:[XYGIMChatImageExpressMessageCell class] forCellReuseIdentifier:@"XYGIMChatMessageCell_OwnerOther_ImageExpressMessage_SingleCell"];
    
    
    [self registerClass:[XYGIMChatLocationMessageCell class] forCellReuseIdentifier:@"XYGIMChatMessageCell_OwnerSelf_LocationMessage_GroupCell"];
    [self registerClass:[XYGIMChatLocationMessageCell class] forCellReuseIdentifier:@"XYGIMChatMessageCell_OwnerSelf_LocationMessage_SingleCell"];
    [self registerClass:[XYGIMChatLocationMessageCell class] forCellReuseIdentifier:@"XYGIMChatMessageCell_OwnerOther_LocationMessage_GroupCell"];
    [self registerClass:[XYGIMChatLocationMessageCell class] forCellReuseIdentifier:@"XYGIMChatMessageCell_OwnerOther_LocationMessage_SingleCell"];
    
    [self registerClass:[XYGIMChatVideoMessageCell class] forCellReuseIdentifier:@"XYGIMChatMessageCell_OwnerSelf_VideoMessage_GroupCell"];
    [self registerClass:[XYGIMChatVideoMessageCell class] forCellReuseIdentifier:@"XYGIMChatMessageCell_OwnerSelf_VideoMessage_SingleCell"];
    [self registerClass:[XYGIMChatVideoMessageCell class] forCellReuseIdentifier:@"XYGIMChatMessageCell_OwnerOther_VideoMessage_GroupCell"];
    [self registerClass:[XYGIMChatVideoMessageCell class] forCellReuseIdentifier:@"XYGIMChatMessageCell_OwnerOther_VideoMessage_SingleCell"];
    
    
    
    [self registerClass:[XYGIMChatVoiceMessageCell class] forCellReuseIdentifier:@"XYGIMChatMessageCell_OwnerSelf_VoiceMessage_GroupCell"];
    [self registerClass:[XYGIMChatVoiceMessageCell class] forCellReuseIdentifier:@"XYGIMChatMessageCell_OwnerSelf_VoiceMessage_SingleCell"];
    [self registerClass:[XYGIMChatVoiceMessageCell class] forCellReuseIdentifier:@"XYGIMChatMessageCell_OwnerOther_VoiceMessage_GroupCell"];
    [self registerClass:[XYGIMChatVoiceMessageCell class] forCellReuseIdentifier:@"XYGIMChatMessageCell_OwnerOther_VoiceMessage_SingleCell"];
    
    
    
    
    
    [self registerClass:[XYGIMChatTextMessageCell class] forCellReuseIdentifier:@"XYGIMChatMessageCell_OwnerSelf_TextMessage_GroupCell"];
    [self registerClass:[XYGIMChatTextMessageCell class] forCellReuseIdentifier:@"XYGIMChatMessageCell_OwnerSelf_TextMessage_SingleCell"];
    [self registerClass:[XYGIMChatTextMessageCell class] forCellReuseIdentifier:@"XYGIMChatMessageCell_OwnerOther_TextMessage_GroupCell"];
    [self registerClass:[XYGIMChatTextMessageCell class] forCellReuseIdentifier:@"XYGIMChatMessageCell_OwnerOther_TextMessage_SingleCell"];
    
    [self registerClass:[XYGIMChatSystemMessageCell class] forCellReuseIdentifier:@"XYGIMChatMessageCell_OwnerSystem_SystemMessage_"];
    [self registerClass:[XYGIMChatSystemMessageCell class] forCellReuseIdentifier:@"XYGIMChatMessageCell_OwnerSystem_SystemMessage_SingleCell"];
    [self registerClass:[XYGIMChatSystemMessageCell class] forCellReuseIdentifier:@"XYGIMChatMessageCell_OwnerSystem_SystemMessage_GroupCell"];
    

    
    
}

@end
