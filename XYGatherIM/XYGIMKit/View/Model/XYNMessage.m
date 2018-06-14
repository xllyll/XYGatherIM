//
//  XYNMessage.m
//  XYGatherIM
//
//  Created by 杨卢银 on 2018/6/13.
//  Copyright © 2018年 杨卢银. All rights reserved.
//

#import "XYNMessage.h"
#import "XYGIMChatUntiles.h"
#import "XYGIMConvertToCommonEmoticonsHelper.h"
#import "XYGIMEmotion.h"

@implementation XYNMessage

- (instancetype)initWithMessage:(XYGIMMessage *)message
{
    self = [super init];
    if (self) {
        
        _cellHeight = -1;
        _message = message;
        if ([_message isKindOfClass:[NSString class]]) {
            return self;
        }
        _firstMessageBody = message.body;
        _isMediaPlaying = NO;
        
        _nickname = message.from;
        _isSender = message.direction == XYGIMMessageDirectionSend ? YES : NO;
        
        switch (_message.messageType) {
            case XYGIMMessageBodyTypeText:
            {
                XYGIMTextMessageBody *textBody = (XYGIMTextMessageBody *)_firstMessageBody;
                // 表情映射。
                NSString *didReceiveText = [XYGIMConvertToCommonEmoticonsHelper convertToSystemEmoticons:textBody.text];
                self.text = didReceiveText;
            }
                break;
            case XYGIMMessageBodyTypeImage:
            {
                XYGIMImageMessageBody *imgMessageBody = (XYGIMImageMessageBody *)_firstMessageBody;
                NSData *imageData = [NSData dataWithContentsOfFile:imgMessageBody.localPath];
                if (imageData.length) {
                    self.image = [UIImage imageWithData:imageData];
                }
                
                if ([imgMessageBody.thumbnailLocalPath length] > 0) {
                    self.thumbnailImage = [UIImage imageWithContentsOfFile:imgMessageBody.thumbnailLocalPath];
                }
                else{
                    CGSize size = self.image.size;
                    self.thumbnailImage = size.width * size.height > 200 * 200 ? [self scaleImage:self.image toScale:sqrt((200 * 200) / (size.width * size.height))] : self.image;
                }
                
                self.thumbnailImageSize = self.thumbnailImage.size;
                self.imageSize = imgMessageBody.size;
                if (!_isSender) {
                    self.fileURLPath = imgMessageBody.remotePath;
                }
            }
                break;
            case XYGIMMessageBodyTypeLocation:
            {
                XYGIMLocationMessageBody *locationBody = (XYGIMLocationMessageBody *)_firstMessageBody;
                self.address = locationBody.address;
                self.latitude = locationBody.latitude;
                self.longitude = locationBody.longitude;
            }
                break;
            case XYGIMMessageBodyTypeVoice:
            {
                XYGIMVoiceMessageBody *voiceBody = (XYGIMVoiceMessageBody *)_firstMessageBody;
                self.mediaDuration = voiceBody.duration;
                self.isMediaPlayed = NO;
                if (message.ext) {
                    self.isMediaPlayed = [[message.ext objectForKey:@"isPlayed"] boolValue];
                }
                
                // 音频路径
                self.fileURLPath = voiceBody.remotePath;
            }
                break;
            case XYGIMMessageBodyTypeVideo:
            {
                XYGIMVideoMessageBody *videoBody = (XYGIMVideoMessageBody *)message.body;
                self.thumbnailImageSize = videoBody.thumbnailSize;
                if ([videoBody.thumbnailLocalPath length] > 0) {
                    NSData *thumbnailImageData = [NSData dataWithContentsOfFile:videoBody.thumbnailLocalPath];
                    if (thumbnailImageData.length) {
                        self.thumbnailImage = [UIImage imageWithData:thumbnailImageData];
                    }
                    self.image = self.thumbnailImage;
                }
                
                // 视频路径
                self.fileURLPath = videoBody.remotePath;
            }
                break;
            case XYGIMMessageBodyTypeFile:
            {
                XYGIMFileMessageBody *fileMessageBody = (XYGIMFileMessageBody *)_firstMessageBody;
                self.fileIconName = @"chat_item_file";
                self.fileName = fileMessageBody.displayName;
                self.fileSize = fileMessageBody.fileLength;
                
                if (self.fileSize < 1024) {
                    self.fileSizeDes = [NSString stringWithFormat:@"%fB", self.fileSize];
                }
                else if(self.fileSize < 1024 * 1024){
                    self.fileSizeDes = [NSString stringWithFormat:@"%.2fkB", self.fileSize / 1024];
                }
                else if (self.fileSize < 2014 * 1024 * 1024){
                    self.fileSizeDes = [NSString stringWithFormat:@"%.2fMB", self.fileSize / (1024 * 1024)];
                }
            }
                break;
            default:
                NSLog(@"");
                break;
        }
    }
    
    return self;
}

- (NSString *)messageId
{
    return _message.messageId;
}

- (XYGIMMessageStatus)messageStatus
{
    return _message.status;
}

- (XYGIMChatType)messageType
{
    return _message.chatType;
}

- (XYGIMMessageBodyType)bodyType
{
    return self.firstMessageBody.type;
}

- (BOOL)isMessageRead
{
    return _message.isReadAcked;
}

- (NSString *)fileLocalPath
{
    if (_firstMessageBody) {
        switch (_firstMessageBody.type) {
            case XYGIMMessageBodyTypeVideo:
            case XYGIMMessageBodyTypeImage:
            case XYGIMMessageBodyTypeVoice:
            case XYGIMMessageBodyTypeFile:
            {
                XYGIMFileMessageBody *fileBody = (XYGIMFileMessageBody *)_firstMessageBody;
                return fileBody.localPath;
            }
                break;
            default:
                break;
        }
    }
    return nil;
}

- (UIImage *)scaleImage:(UIImage *)image toScale:(float)scaleSize
{
    UIGraphicsBeginImageContext(CGSizeMake(image.size.width * scaleSize, image.size.height * scaleSize));
    [image drawInRect:CGRectMake(0, 0, image.size.width * scaleSize, image.size.height * scaleSize)];
    UIImage *scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return scaledImage;
}

#pragma mark fu_im

-(NSDictionary *)dictionary{
    NSMutableDictionary *messageDict = [NSMutableDictionary dictionary];
    
    if ([_message isKindOfClass:[NSString class]]) {
        messageDict[kXYGIMNMessageConfigurationOwnerKey] = @(XYGIMNMessageOwnerSystem);
        messageDict[kXYGIMNMessageConfigurationTextKey] = _message;
        messageDict[kXYGIMNMessageConfigurationTypeKey]  = @(XYGIMNMessageTypeSystem);
        return messageDict;
    }
    
    if (_message.direction==XYGIMMessageDirectionReceive) {
        messageDict[kXYGIMNMessageConfigurationOwnerKey] = @(XYGIMNMessageOwnerOther);
    }else{
        messageDict[kXYGIMNMessageConfigurationOwnerKey] = @(XYGIMNMessageOwnerSelf);
    }
    
    messageDict[kXYGIMNMessageConfigurationGroupKey] = @(self.messageType==XYGIMChatTypeChat?XYGIMNMessageChatSingle:XYGIMNMessageChatGroup);
    
    messageDict[kXYGIMNMessageConfigurationTypeKey] = @([self getMessageType]);
    switch (_message.body.type) {
        case XYGIMMessageBodyTypeText:
            messageDict[kXYGIMNMessageConfigurationTextKey] = _text;
            break;
        case XYGIMMessageBodyTypeImage:
            messageDict[kXYGIMNMessageConfigurationImageKey] = _thumbnailImage;
            if (_thumbnailImage==nil) {
                messageDict[kXYGIMNMessageConfigurationImageKey] = _thumbnailFileURLPath;
            }
            break;
        case XYGIMMessageBodyTypeLocation:
            messageDict[kXYGIMNMessageConfigurationLocationKey] = _address;
            break;
        case XYGIMMessageBodyTypeVoice:
            messageDict[kXYGIMNMessageConfigurationVoiceSecondsKey] = @(_mediaDuration);
            messageDict[kXYGIMNMessageConfigurationVoiceKey] = _fileURLPath;
            break;
        case XYGIMMessageBodyTypeVideo:
            messageDict[kXYGIMNMessageConfigurationVideoSecondsKey] = @(_mediaDuration);
            messageDict[kXYGIMNMessageConfigurationVideoKey] = _fileURLPath;
            messageDict[kXYGIMNMessageConfigurationImageKey] = _thumbnailImage;
            if (_thumbnailImage==nil) {
                messageDict[kXYGIMNMessageConfigurationImageKey] = _thumbnailFileURLPath;
            }
            break;
            
        default:
            break;
    }
    
    //    messageDict[kXYGIMNMessageConfigurationNicknameKey] = [[FUContactCore shareCore]getFriendByID:_nickname].getShowName;
    //    messageDict[kXYGIMNMessageConfigurationAvatarKey] = [[FUContactCore shareCore] getFriendByID:_nickname].friendUser.thumbnail;
    
    messageDict[kXYGIMNMessageConfigurationReadStateKey] = _isMessageRead?@(XYGIMNMessageReaded):@(XYGIMNMessageUnRead);
    messageDict[kXYGIMNMessageConfigurationSendStateKey] = @(XYGIMNMessageSendSuccess);
    messageDict[kXYGIMNMessageConfigurationKey] = self;
    return messageDict;
}

-(XYGIMNMessageType)getMessageType{
    XYGIMNMessageType type;
    switch (_message.body.type) {
        case XYGIMMessageBodyTypeText:{
            type = XYGIMNMessageTypeText;
            //            NSString *didReceiveText = [EaseConvertToCommonEmoticonsHelper convertToSystemEmoticons:((EMTextMessageBody *)self.message.body).text];
            //            latestMessageTitle = didReceiveText;
            if ([self.message.ext objectForKey:MESSAGE_ATTR_IS_BIG_EXPRESSION]) {
                //                latestMessageTitle = @"[动画表情]";
                NSLog(@"MS---动画表情");
                //NSDictionary *ext = _message.ext;
                type = XYGIMNMessageTypeImageExpress;
            }
            if ([self.message.ext objectForKey:K_EASE_MESSAGE_EXT_CALL_AUDIO]) {
                //latestMessageTitle = @"[动画表情]";
                NSLog(@"MS---[找你电话]视频通话");
                type = XYGIMNMessageTypeCallAudio;
            }
            if ([self.message.ext objectForKey:K_EASE_MESSAGE_EXT_CALL_VIDEO]) {
                //latestMessageTitle = @"[动画表情]";
                NSLog(@"MS---[找你视频]视频通话");
                type = XYGIMNMessageTypeCallVideo;
            }
        }
            break;
        case XYGIMMessageBodyTypeImage:
            type = XYGIMNMessageTypeImage;
            break;
        case XYGIMMessageBodyTypeLocation:
            type = XYGIMNMessageTypeLocation;
            break;
        case XYGIMMessageBodyTypeVoice:
            type = XYGIMNMessageTypeVoice;
            break;
        case XYGIMMessageBodyTypeVideo:
            type = XYGIMNMessageTypeVideo;
            break;
        default:
            
            break;
    }
    return type;
}
@end
