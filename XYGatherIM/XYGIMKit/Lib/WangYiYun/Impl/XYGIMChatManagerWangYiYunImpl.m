//
//  XYGIMChatManagerWangYiYunImpl.m
//  XYGatherIM
//
//  Created by 杨卢银 on 2018/6/13.
//  Copyright © 2018年 杨卢银. All rights reserved.
//

#import "XYGIMChatManagerWangYiYunImpl.h"
#import <NIMSDK/NIMSDK.h>

@interface XYGIMChatManagerWangYiYunImpl()<NIMChatManagerDelegate>

@property (strong , nonatomic) NSMutableArray *delegates;


@property (strong , nonatomic) id<NIMChatManager> chatManager;

@property (strong , nonatomic) id<NIMConversationManager> conversationManager;

@property (strong , nonatomic) id<NIMResourceManager> resourceManager;

@end


@implementation XYGIMChatManagerWangYiYunImpl

-(instancetype)init{
    self = [super init];
    if (self) {
        
    }
    return self;
}
-(id<NIMConversationManager>)conversationManager{
    _conversationManager = [[NIMSDK sharedSDK] conversationManager];
    return _conversationManager;
}
-(id<NIMChatManager>)chatManager{
    _chatManager = [[NIMSDK sharedSDK] chatManager];
    return _chatManager;
}
-(id<NIMResourceManager>)resourceManager{
    _resourceManager = [[NIMSDK sharedSDK] resourceManager];
    return _resourceManager;
}
-(NSMutableArray *)delegates{
    if (!_delegates) {
        _delegates = [[NSMutableArray alloc] init];
    }
    return _delegates;
}

-(void)addDelegate:(id<XYGIMChatManagerDelegate>)aDelegate delegateQueue:(dispatch_queue_t)aQueue{
    [self.delegates addObject:aDelegate];
    if (_delegates.count>0) {
        [self.chatManager addDelegate:self];
    }
}
-(void)removeDelegate:(id<XYGIMChatManagerDelegate>)aDelegate{
    [self.delegates removeObject:aDelegate];
}
-(NSArray *)getAllConversations{
    
    NSArray<NIMRecentSession*> *slist = self.conversationManager.allRecentSessions;
    NSMutableArray *rs = [[NSMutableArray alloc] init];
    for (int i =0 ; i < slist.count; i++) {
        NIMRecentSession *c = slist[i];
        
        XYGIMConversation *conversation = [self buildConversation:c];
        
        [rs addObject:conversation];
    }
    return rs;
}
-(NIMMessage *)buildNIMMessageConversation:(XYGIMMessage*)aMessage{
    NIMMessage *message = [[NIMMessage alloc] init];
    message.text = aMessage.text;
    switch (aMessage.messageType) {
        case XYGIMMessageBodyTypeText:
            aMessage.messageType = NIMMessageTypeText;
            break;
        case XYGIMMessageBodyTypeVoice:{
            aMessage.messageType = NIMMessageTypeAudio;
            XYGIMVoiceMessageBody *voiceBody = (XYGIMVoiceMessageBody*)aMessage.body;
            NIMAudioObject *audioObject = [[NIMAudioObject alloc] initWithSourcePath:voiceBody.localPath];
            message.messageObject = audioObject;
            break;
        }
        case XYGIMMessageBodyTypeImage:{
            aMessage.messageType = NIMMessageTypeImage;
            XYGIMImageMessageBody *imgBody = (XYGIMImageMessageBody*)aMessage.body;
            NIMImageObject *imageObjc = [[NIMImageObject alloc] initWithData:imgBody.data extension:[imgBody.displayName componentsSeparatedByString:@"."].lastObject];
            message.messageObject = imageObjc;
            break;
        }
        case XYGIMMessageBodyTypeLocation:{
            aMessage.messageType = NIMMessageTypeLocation;
            XYGIMLocationMessageBody *body = (XYGIMLocationMessageBody*)aMessage.body;
            NIMLocationObject *locationObject = [[NIMLocationObject alloc] initWithLatitude:body.latitude longitude:body.longitude title:body.address];
            message.messageObject=locationObject;
            break;
        }
        default:
            break;
    }
    return message;
}
-(XYGIMConversation *)buildConversation:(NIMRecentSession*)aSession{
    XYGIMConversation *conversation = [[XYGIMConversation alloc] initWithConversation:aSession];
    conversation.conversationId = aSession.session.sessionId;
    switch (aSession.session.sessionType) {
        case NIMSessionTypeP2P:
            conversation.type = XYGIMConversationTypeChat;
            break;
        case NIMSessionTypeTeam:
            conversation.type = XYGIMConversationTypeGroupChat;
            break;
        case NIMSessionTypeChatroom:
            conversation.type = XYGIMConversationTypeChatRoom;
            break;
            
        default:
            break;
    }
    XYGIMMessage *msg = [[XYGIMMessage alloc] initWithMessage:aSession.lastMessage];
    conversation.latestMessage = msg;
    conversation.unreadMessagesCount = aSession.unreadCount;
    conversation.ext = aSession.localExt;
    return conversation;
}
-(NIMSession*)getSession:(NSString *)aConversationId type:(XYGIMConversationType)aType{
    NIMSession *session = nil;
    if (aType==XYGIMConversationTypeChat) {
        session = [NIMSession session:aConversationId type:NIMSessionTypeP2P];
    }
    if (aType==XYGIMConversationTypeGroupChat) {
        session = [NIMSession session:aConversationId type:NIMSessionTypeTeam];
    }
    if (aType==XYGIMConversationTypeChatRoom) {
        session = [NIMSession session:aConversationId type:NIMSessionTypeChatroom];
    }
    return session;
}
-(XYGIMConversation *)getConversation:(NSString *)aConversationId type:(XYGIMConversationType)aType createIfNotExist:(BOOL)aIfCreate{
    
    NIMSession *session = [self getSession:aConversationId type:aType];
    NIMRecentSession *rs = [_conversationManager recentSessionBySession:session];
    XYGIMConversation *c = [self buildConversation:rs];
    if (rs==nil) {
        rs = [[NIMRecentSession alloc] init];
        c.conversationId = session.sessionId;
        switch (session.sessionType) {
            case NIMSessionTypeP2P:
                c.type = XYGIMConversationTypeChat;
                break;
            case NIMSessionTypeTeam:
                c.type = XYGIMConversationTypeGroupChat;
                break;
            case NIMSessionTypeChatroom:
                c.type = XYGIMConversationTypeChatRoom;
                break;
                
            default:
                break;
        }
    }
    
    return c;
}

/**
 *  \~chinese
 *  发送消息已读回执
 *
 *  异步方法
 *
 *  @param aMessage             消息
 *  @param aCompletionBlock     完成的回调
 *
 */
- (void)sendMessageReadAck:(XYGIMMessage *)aMessage
                completion:(void (^)(XYGIMMessage *, XYError *))aCompletionBlock{
    
}

/**
 *  \~chinese
 *  撤回消息
 *
 *  异步方法
 *
 *  @param aMessage             消息
 *  @param aCompletionBlock     完成的回调
 *
 */
- (void)recallMessage:(XYGIMMessage *)aMessage
           completion:(void (^)(XYGIMMessage *, XYError *))aCompletionBlock{
    
}

/**
 *  \~chinese
 *  发送消息
 *
 *  @param aMessage         消息
 *  @param aProgressBlock   附件上传进度回调block
 *  @param aCompletionBlock 发送完成回调block
 */
- (void)sendMessage:(XYGIMMessage *)aMessage
           progress:(void (^)(int))aProgressBlock
         completion:(void (^)(XYGIMMessage *, XYError *))aCompletionBlock{
    XYLog(@"<网易云>发送消息");
    NIMMessage *msg = [self buildNIMMessageConversation:aMessage];
    NSError *error;
    NIMSession *session;
    switch (aMessage.chatType) {
        case XYGIMChatTypeChat:
            session = [self getSession:aMessage.to type:XYGIMConversationTypeChat];
            break;
        case XYGIMChatTypeGroupChat:
            session = [self getSession:aMessage.to type:XYGIMConversationTypeGroupChat];
            break;
        case XYGIMChatTypeChatRoom:
            session = [self getSession:aMessage.to type:XYGIMConversationTypeChatRoom];
            break;
            
        default:
            break;
    }
    BOOL send = [_chatManager sendMessage:msg toSession:session error:&error];
    if (send == YES) {
        XYLog(@"发送成功--");
    }else{
        XYLog(@"发送失败--%@",error.description);
    }
}

/**
 *  \~chinese
 *  重发送消息
 *
 *  @param aMessage         消息
 *  @param aProgressBlock   附件上传进度回调block
 *  @param aCompletionBlock 发送完成回调block
 */
- (void)resendMessage:(XYGIMMessage *)aMessage
             progress:(void (^)(int))aProgressBlock
           completion:(void (^)(XYGIMMessage *, XYError *))aCompletionBlock{
    
}
-(void)deleteConversation:(XYGIMConversation *)aConversation isDeleteMessages:(BOOL)aIsDeleteMessages completion:(void (^)(NSString *, XYError *))aCompletionBlock{
    //NIMSession *session = [NIMSession session:<#(nonnull NSString *)#> type:<#(NIMSessionType)#>]
    NIMRecentSession *recent = aConversation.conversation;
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        // 处理耗时操作的代码块...
        if (aIsDeleteMessages==YES) {
            NIMDeleteMessagesOption *option = [[NIMDeleteMessagesOption alloc] init];
            option.removeSession = YES;
            option.removeTable = YES;
            [_conversationManager deleteAllmessagesInSession:recent.session option:option];
        }
        [_conversationManager deleteRecentSession:recent];
        //通知主线程刷新
        dispatch_async(dispatch_get_main_queue(), ^{
            //回调或者说是通知主线程刷新，
            aCompletionBlock(aConversation.conversationId,nil);
        });
        
    });
    
    
}
-(void)deleteConversations:(NSArray<XYGIMConversation *> *)aConversations isDeleteMessages:(BOOL)aIsDeleteMessages completion:(void (^)(XYError *))aCompletionBlock{
    
}
-(void)downloadMessageThumbnail:(XYGIMMessage *)aMessage progress:(void (^)(int))aProgressBlock completion:(void (^)(XYGIMMessage *, XYError *))aCompletionBlock{
    NSString *path = @"";
    NSString *filepath = @"";
    NIMMessage *msg = aMessage.message;
    if ([msg.messageObject isKindOfClass:[NIMImageObject class]]) {
        NIMImageObject *imgOb = msg.messageObject;
        path = imgOb.thumbUrl;
        filepath = imgOb.thumbPath;
    }
    [self.resourceManager download:path filepath:filepath progress:^(float progress) {
        int p = (int)(progress*100);
        XYLog(@"<网易云--下载>---  %.2f === %d",progress,p)
        aProgressBlock(p);
    } completion:^(NSError * _Nullable error) {
        if (!error) {
            aCompletionBlock(aMessage,nil);
        }else{
            aCompletionBlock(nil,[XYError new]);
        }
    }];
}
-(void)downloadMessageAttachment:(XYGIMMessage *)aMessage progress:(void (^)(int))aProgressBlock completion:(void (^)(XYGIMMessage *, XYError *))aCompletionBlock{
    NSString *path = @"";
    NSString *filepath = @"";
    NIMMessage *msg = aMessage.message;
    if ([msg.messageObject isKindOfClass:[NIMVideoObject class]]) {
        NIMVideoObject *videoOb = msg.messageObject;
        path = videoOb.url;
        filepath = videoOb.path;
    }
    if ([msg.messageObject isKindOfClass:[NIMImageObject class]]) {
        NIMImageObject *imgOb = msg.messageObject;
        path = imgOb.url;
        filepath = imgOb.path;
    }
    [self.resourceManager download:path filepath:filepath progress:^(float progress) {
        int p = (int)(progress*100);
        XYLog(@"<网易云--附件下载>---  %.2f === %d",progress,p)
        aProgressBlock(p);
    } completion:^(NSError * _Nullable error) {
        if (!error) {
            aCompletionBlock(aMessage,nil);
        }else{
            aCompletionBlock(nil,[XYError new]);
        }
    }];
}
#pragma mark NIMChatManagerDelegate
/**
 *  即将发送消息回调
 *  @discussion 因为发消息之前可能会有个异步的准备过程,所以需要在收到这个回调时才将消息加入到datasource中
 *  @param message 当前发送的消息
 */
- (void)willSendMessage:(NIMMessage *)message{
    XYLog(@"<网易云>即将发送消息回调");
}

/**
 *  发送消息进度回调
 *
 *  @param message  当前发送的消息
 *  @param progress 进度
 */
- (void)sendMessage:(NIMMessage *)message
           progress:(float)progress{
    XYLog(@"<网易云>发送消息进度回调 %.2f",progress);
}

/**
 *  发送消息完成回调
 *
 *  @param message 当前发送的消息
 *  @param error   失败原因,如果发送成功则error为nil
 */
- (void)sendMessage:(NIMMessage *)message didCompleteWithError:(nullable NSError *)error{
    XYLog(@"<网易云>当前发送的消息 %@",error?@"失败":@"成功");
}


/**
 *  收到消息回调
 *
 *  @param messages 消息列表,内部为NIMMessage
 */
- (void)onRecvMessages:(NSArray<NIMMessage *> *)messages{
    XYLog(@"网易云---收到消息回调:%d",(int)messages.count);
    NSMutableArray *list = [NSMutableArray array];
    for(NIMMessage *m in messages){
        XYGIMMessage *msg = [[XYGIMMessage alloc] initWithMessage:m];
        [list addObject:msg];
    }
    for (id delegate in _delegates) {
        [delegate XYGIM_onRecvMessages:list];
    }
}


/**
 *  收到消息回执
 *
 *  @param receipts 消息回执数组
 *  @discussion 当上层收到此消息时所有的存储和 model 层业务都已经更新，只需要更新 UI 即可。
 */
- (void)onRecvMessageReceipts:(NSArray<NIMMessageReceipt *> *)receipts{
    XYLog(@"<网易云> 收到消息回执");
}


/**
 *  收到消息被撤回的通知
 *
 *  @param notification 被撤回的消息信息
 *  @discusssion 云信在收到消息撤回后，会先从本地数据库中找到对应消息并进行删除，之后通知上层消息已删除
 */
- (void)onRecvRevokeMessageNotification:(NIMRevokeMessageNotification *)notification{
    XYLog(@"<网易云> 收到消息被撤回的通知");
}


/**
 *  收取消息附件回调
 *  @param message  当前收取的消息
 *  @param progress 进度
 *  @discussion 附件包括:图片,视频的缩略图,语音文件
 */
- (void)fetchMessageAttachment:(NIMMessage *)message
                      progress:(float)progress{
    
}


/**
 *  收取消息附件完成回调
 *
 *  @param message 当前收取的消息
 *  @param error   错误返回,如果收取成功,error为nil
 */
- (void)fetchMessageAttachment:(NIMMessage *)message
          didCompleteWithError:(nullable NSError *)error{
    
}
@end
