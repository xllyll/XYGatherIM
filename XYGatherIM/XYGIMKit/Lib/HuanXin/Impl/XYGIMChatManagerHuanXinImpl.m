//
//  XYGIMChatManagerHuanXinImpl.m
//  XYGatherIM
//
//  Created by 杨卢银 on 2018/6/13.
//  Copyright © 2018年 杨卢银. All rights reserved.
//

#import "XYGIMChatManagerHuanXinImpl.h"
#import <Hyphenate/Hyphenate.h>

@interface XYGIMChatManagerHuanXinImpl()
@property (strong , nonatomic) NSMutableArray *delegates;
@property (strong , nonatomic)id<IEMChatManager> chatManager;

@end
@implementation XYGIMChatManagerHuanXinImpl
-(instancetype)init{
    self = [super init];
    if (self) {
        _chatManager = [EMClient sharedClient].chatManager;
    }
    return self;
}
-(NSMutableArray *)delegates{
    if (!_delegates) {
        _delegates = [[NSMutableArray alloc] init];
    }
    return _delegates;
}

-(void)addDelegate:(id<XYGIMChatManagerDelegate>)aDelegate delegateQueue:(dispatch_queue_t)aQueue{
    [self.delegates addObject:aDelegate];
}
-(void)removeDelegate:(id<XYGIMChatManagerDelegate>)aDelegate{
    [self.delegates removeObject:aDelegate];
}
-(NSArray *)getAllConversations{
    NSMutableArray *rs = [NSMutableArray array];
    NSArray *alist = _chatManager.getAllConversations;
    for (int i = 0; i < alist.count; i++) {
        EMConversation *c = alist[i];
        XYGIMConversation *conversation = [[XYGIMConversation alloc] init];
        conversation.conversationId = c.conversationId;
        switch (c.type) {
            case EMConversationTypeChat:
                conversation.type = XYGIMConversationTypeChat;
                break;
            case EMConversationTypeGroupChat:
                conversation.type = XYGIMConversationTypeGroupChat;
                break;
            case EMConversationTypeChatRoom:
                conversation.type = XYGIMConversationTypeChatRoom;
                break;
                
            default:
                break;
        }
        XYGIMMessage *msg = [[XYGIMMessage alloc] initWithMessage:c.latestMessage];
        conversation.latestMessage = msg;
        conversation.unreadMessagesCount = c.unreadMessagesCount;
        conversation.ext = c.ext;
        [rs addObject:conversation];
    }
    return rs;
}
-(void)deleteConversation:(XYGIMConversation *)aConversation isDeleteMessages:(BOOL)aIsDeleteMessages completion:(void (^)(NSString *, XYError *))aCompletionBlock{
    [_chatManager deleteConversation:aConversation.conversationId isDeleteMessages:aIsDeleteMessages completion:^(NSString *atheConversationId, EMError *aError) {
        if (aError) {
            aCompletionBlock(nil,[XYError new]);
        }else{
            aCompletionBlock(atheConversationId,nil);
        }
    }];
}
-(void)deleteConversations:(NSArray<XYGIMConversation *> *)aConversations isDeleteMessages:(BOOL)aIsDeleteMessages completion:(void (^)(XYError *))aCompletionBlock{
    NSMutableArray *ids = [NSMutableArray array];
    for (XYGIMConversation *c in aConversations) {
        [ids addObject:c.conversationId];
    }
    [_chatManager deleteConversations:ids isDeleteMessages:aIsDeleteMessages completion:^(EMError *aError) {
        if (aError) {
            aCompletionBlock([XYError new]);
        }else{
            aCompletionBlock(nil);
        }
    }];
}
@end
