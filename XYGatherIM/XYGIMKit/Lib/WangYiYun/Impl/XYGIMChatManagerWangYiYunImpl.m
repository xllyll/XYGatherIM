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
        XYGIMConversation *conversation = [[XYGIMConversation alloc] init];
        conversation.conversationId = c.session.sessionId;
        switch (c.session.sessionType) {
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
        XYGIMMessage *msg = [[XYGIMMessage alloc] initWithMessage:c.lastMessage];
        conversation.latestMessage = msg;
        conversation.unreadMessagesCount = c.unreadCount;
        conversation.ext = c.localExt;
        [rs addObject:conversation];
    }
    return rs;
}
#pragma mark NIMChatManagerDelegate
/**
 *  即将发送消息回调
 *  @discussion 因为发消息之前可能会有个异步的准备过程,所以需要在收到这个回调时才将消息加入到datasource中
 *  @param message 当前发送的消息
 */
- (void)willSendMessage:(NIMMessage *)message{
    
}

/**
 *  发送消息进度回调
 *
 *  @param message  当前发送的消息
 *  @param progress 进度
 */
- (void)sendMessage:(NIMMessage *)message
           progress:(float)progress{
    
}

/**
 *  发送消息完成回调
 *
 *  @param message 当前发送的消息
 *  @param error   失败原因,如果发送成功则error为nil
 */
- (void)sendMessage:(NIMMessage *)message
didCompleteWithError:(nullable NSError *)error{
    
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
    
}


/**
 *  收到消息被撤回的通知
 *
 *  @param notification 被撤回的消息信息
 *  @discusssion 云信在收到消息撤回后，会先从本地数据库中找到对应消息并进行删除，之后通知上层消息已删除
 */
- (void)onRecvRevokeMessageNotification:(NIMRevokeMessageNotification *)notification{
    
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
