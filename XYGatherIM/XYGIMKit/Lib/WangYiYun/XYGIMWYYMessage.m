//
//  XYGIMWYYMessage.m
//  XYGatherIM
//
//  Created by 杨卢银 on 2018/6/12.
//  Copyright © 2018年 杨卢银. All rights reserved.
//

#import "XYGIMWYYMessage.h"
#import <NIMSDK/NIMSDK.h>

@interface XYGIMWYYMessage()
{
    NIMMessage *_msg;
}


@end

@implementation XYGIMWYYMessage

-(void)setMessage:(id)message{
    [super setMessage:message];
    _msg = message;
    [self buildData];
}
-(void)buildData{
    self.messageId = _msg.messageId;
//    self.conversationId = _msg.
    self.from = _msg.from;
    self.localTime = _msg.timestamp;
    self.timestamp = _msg.timestamp;
    self.direction = [_msg.from isEqualToString:[NIMSDK sharedSDK].loginManager.currentAccount]?XYGIMMessageDirectionSend:XYGIMMessageDirectionReceive;
    self.conversationId = _msg.session.sessionId;
    self.text = _msg.text;
    
    switch (_msg.messageType) {
        case NIMMessageTypeText:{
            self.messageType = XYGIMMessageBodyTypeText;
            XYGIMTextMessageBody *textBody = [[XYGIMTextMessageBody alloc] initWithText:_msg.text];
            self.body = textBody;
            break;
        }
        case NIMMessageTypeImage:{
            self.messageType = XYGIMMessageBodyTypeImage;
            NIMImageObject *imgObjc =  _msg.messageObject;
            NSString *thumbPath = [imgObjc thumbPath];
            XYGIMImageMessageBody *imgBody = [[XYGIMImageMessageBody alloc] initWithPath:thumbPath thumbnailPath:thumbPath];
            self.body = imgBody;
            break;
        }
        case NIMMessageTypeFile:{
            self.messageType = XYGIMMessageBodyTypeFile;
            NIMFileObject *fileObject = _msg.messageObject;
            XYGIMFileMessageBody *fileBody = [[XYGIMFileMessageBody alloc] initWithLocalPath:fileObject.path displayName:fileObject.description];
            fileBody.remotePath = fileObject.url;
            fileBody.fileLength = fileObject.fileLength;
            self.body = fileBody;
            break;
        }
        case NIMMessageTypeAudio:{
        
            self.messageType = XYGIMMessageBodyTypeVoice;
            NIMAudioObject *audioOB = _msg.messageObject;
            NSString *path = [audioOB path];
            long ms = (audioOB.duration+500)/1000;//四舍五入
            XYGIMVoiceMessageBody *vbody = [[XYGIMVoiceMessageBody alloc] initWithLocalPath:path url:audioOB.url duration:(int)ms];
            self.body = vbody;
            break;
        }
        case NIMMessageTypeVideo:
            self.messageType = XYGIMMessageBodyTypeVideo;
            break;
        case NIMMessageTypeNotification:
            self.messageType = XYGIMMessageBodyTypeNotification;
            break;
        case NIMMessageTypeTip:
            self.messageType = XYGIMMessageBodyTypeCmd;
            break;
        case NIMMessageTypeLocation:{
            
            self.messageType = XYGIMMessageBodyTypeLocation;
         
            NIMLocationObject *locationObject = _msg.messageObject;
            
            XYGIMLocationMessageBody *lbody = [[XYGIMLocationMessageBody alloc] initWithLatitude:locationObject.latitude longitude:locationObject.longitude address:locationObject.title];
            self.body = lbody;
            break;
        }
        case NIMMessageTypeCustom:
            self.messageType = XYGIMMessageBodyTypeCustom;
            break;
        case NIMMessageTypeRobot:
            self.messageType = XYGIMMessageBodyTypeCustom;
            break;
        default:
            self.messageType = XYGIMMessageBodyTypeText;
            break;
    }
}

@end
