//
//  XYGIMWYYConversation.m
//  XYGatherIM
//
//  Created by 杨卢银 on 2018/6/13.
//  Copyright © 2018年 杨卢银. All rights reserved.
//

#import "XYGIMWYYConversation.h"
#import <NIMSDK/NIMSDK.h>

@interface XYGIMWYYConversation()
{
    NIMRecentSession *_recentSession;
}
@end

@implementation XYGIMWYYConversation

-(instancetype)init{
    self = [super init];
    if (self) {
        
        
    }
    return self;
}

-(void)setConversation:(id)conversation{
    [super setConversation:conversation];
    _recentSession = (NIMRecentSession*)conversation;
}
-(void)markAllMessagesAsRead:(XYError *__autoreleasing *)pError{
    [[NIMSDK sharedSDK].conversationManager markAllMessagesReadInSession:_recentSession.session];
}
/**
 *  \~chinese
 *  将消息设置为已读
 *
 *  @param aMessageId   要设置消息的ID
 *  @param pError       错误信息
 *
 */
- (void)markMessageAsReadWithId:(NSString *)aMessageId
                          error:(XYError **)pError{
    [[NIMSDK sharedSDK].conversationManager markAllMessagesReadInSession:_recentSession.session];
}
#pragma mark - Load Messages Methods
/**
 *  \~chinese
 *  获取指定ID的消息
 *
 *  @param aMessageId       消息ID
 *  @param pError           错误信息
 *
 */
- (XYGIMMessage *)loadMessageWithId:(NSString *)aMessageId error:(XYError *__autoreleasing *)pError{
    NSArray *mesgs = [[NIMSDK sharedSDK].conversationManager messagesInSession:_recentSession.session messageIds:@[aMessageId]];
    if (mesgs && mesgs.count>0) {
        XYGIMMessage *msg = [[XYGIMMessage alloc] initWithMessage:mesgs.firstObject];
        return msg;
    }
    return nil;
}
/**
 *  \~chinese
 *  从数据库获取指定数量的消息，取到的消息按时间排序，并且不包含参考的消息，如果参考消息的ID为空，则从最新消息取
 *
 *  @param aMessageId       参考消息的ID
 *  @param count            获取的条数
 *  @param aDirection       消息搜索方向
 *  @param aCompletionBlock 完成的回调
 */
- (void)loadMessagesStartFromId:(NSString *)aMessageId count:(int)aCount searchDirection:(XYGIMMessageSearchDirection)aDirection completion:(void (^)(NSArray *, XYError *))aCompletionBlock{
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NIMMessage *msg = nil;
        if (aMessageId==nil) {
            msg = _recentSession.lastMessage;
        }else{
            NSArray *mesgs = [[NIMSDK sharedSDK].conversationManager messagesInSession:_recentSession.session messageIds:@[aMessageId]];
            if (mesgs && mesgs.count>0) {
                msg = [mesgs firstObject];
            }
        }
        // 处理耗时操作的代码块...
        NSMutableArray *list = [NSMutableArray array];
        if (msg==nil) {
            
        }else{
            
            NSArray *msglsit = [[NIMSDK sharedSDK].conversationManager messagesInSession:_recentSession.session message:msg limit:aCount];
            
            for (NIMMessage *m in msglsit) {
                XYGIMMessage *msg = [[XYGIMMessage alloc] initWithMessage:m];
                [list addObject:msg];
            }
            XYGIMMessage *xymsg = [[XYGIMMessage alloc] initWithMessage:msg];
            [list addObject:xymsg];
        }
        //通知主线程刷新
        dispatch_async(dispatch_get_main_queue(), ^{
            
            //回调或者说是通知主线程刷新，
            aCompletionBlock(list,nil);
        });
        
    });
    
    
}
@end
