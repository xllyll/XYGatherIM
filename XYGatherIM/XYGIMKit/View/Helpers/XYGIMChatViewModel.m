//
//  XYGIMChatViewModel.m
//  FUContact
//
//  Created by 杨卢银 on 16/6/30.
//  Copyright © 2016年 杨卢银. All rights reserved.
//

#import "XYGIMChatViewModel.h"

#import "XYGIMChatTextMessageCell.h"
#import "XYGIMChatImageMessageCell.h"
#import "XYGIMChatVoiceMessageCell.h"
#import "XYGIMChatSystemMessageCell.h"
#import "XYGIMChatLocationMessageCell.h"
#import "XYGIMChatNotConnectCell.h"
#import "XYGIMChatVoiceMessageCell.h"

#import "XYGIMAudioPlayer.h"
#import "XYGIMMessageStateManager.h"

#import "UITableView+FDTemplateLayoutCell.h"
#import "XYGIMChatMessageCell+XYGIMNCellIdentifier.h"
#import "XYGIMNChatServer.h"


@interface XYGIMChatViewModel ()<XYGIMNChatServerDelegate>

@property (nonatomic, strong) NSMutableArray *dataArray;

@property (nonatomic, weak) UIViewController<XYGIMChatMessageCellDelegate> *parentVC;

@property (nonatomic, strong) id<XYGIMNChatServer> chatServer;

@end

@implementation XYGIMChatViewModel

- (instancetype)initWithParentVC:(UIViewController<XYGIMChatMessageCellDelegate> *)parentVC {
    if ([super init]) {
        _dataArray = [NSMutableArray array];
        _parentVC = parentVC;
    }
    return self;
}

- (void)dealloc {
    
    [[XYGIMMessageStateManager shareManager] cleanState];
//    [(FUNChatServerExample *)self.chatServer cancelTimer];
}
-(void)setState:(NSInteger)state{
    _state = state;
}
#pragma mark - UITableViewDataSource & UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (_state==1) {
        return self.dataArray.count+1;
    }
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    if (_state == 1 && indexPath.row == 0) {
        XYGIMChatNotConnectCell *cell = [tableView dequeueReusableCellWithIdentifier:@"NOTCONNECTCELL"];
        if (!cell) {
            cell = [[XYGIMChatNotConnectCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"NOTCONNECTCELL"];
        }
        return cell;
    }
    NSDictionary *message;
    if (_state==1){
        message = self.dataArray[indexPath.row-1];
    }else{
        message = self.dataArray[indexPath.row];
    }
    
    
    NSString *identifier = [XYGIMChatMessageCell cellIdentifierForMessageConfiguration:@{kXYGIMNMessageConfigurationGroupKey:message[kXYGIMNMessageConfigurationGroupKey],kXYGIMNMessageConfigurationOwnerKey:message[kXYGIMNMessageConfigurationOwnerKey],kXYGIMNMessageConfigurationTypeKey:message[kXYGIMNMessageConfigurationTypeKey]}];
    
    XYGIMChatMessageCell *messageCell = [tableView dequeueReusableCellWithIdentifier:identifier];
    [messageCell configureCellWithData:message];
    
    messageCell.messageReadState = [[XYGIMMessageStateManager shareManager] messageReadStateForIndex:indexPath.row];
    messageCell.messageSendState = [[XYGIMMessageStateManager shareManager] messageSendStateForIndex:indexPath.row];
    messageCell.delegate = self.parentVC;
    
    return messageCell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSDictionary *message = self.dataArray[indexPath.row];
    NSString *identifier = [XYGIMChatMessageCell cellIdentifierForMessageConfiguration:message];
    
    return [tableView fd_heightForCellWithIdentifier:identifier cacheByIndexPath:indexPath configuration:^(XYGIMChatMessageCell *cell) {
        [cell configureCellWithData:message];
    }];
    
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    //设置正确的voiceMessageCell播放状态
    NSDictionary *message = self.dataArray[indexPath.row];
    if ([message[kXYGIMNMessageConfigurationTypeKey] integerValue] == XYGIMNMessageTypeVoice) {
        if (indexPath.row == [[XYGIMAudioPlayer sharePlayer] index]) {
            [(XYGIMChatVoiceMessageCell *)cell setVoiceMessageState:[[XYGIMAudioPlayer sharePlayer] audioPlayerState]];
        }
    }
    
}

#pragma mark - XMNChatServerDelegate

- (void)recieveMessage:(NSDictionary *)message {
    //    NSMutableDictionary *messageDict = [NSMutableDictionary dictionaryWithDictionary:message];
    //    [self addMessage:messageDict];
    //    [self.delegate reloadAfterReceiveMessage:messageDict];
}

#pragma mark - Public Methods

- (void)addMessage:(NSDictionary *)message {
    [self.dataArray addObject:message];
}

- (void)sendMessage:(NSDictionary *)message{
    
    __weak __typeof(&*self) wself = self;
    [[XYGIMMessageStateManager shareManager] setMessageSendState:XYGIMNMessageSendStateSending forIndex:[self.dataArray indexOfObject:message]];
    [self.delegate messageSendStateChanged:XYGIMNMessageSendStateSending withProgress:0.0f forIndex:[self.dataArray indexOfObject:message]];
    [self.chatServer sendMessage:message withProgressBlock:^(CGFloat progress) {
        __strong __typeof(wself)self = wself;
        [self.delegate messageSendStateChanged:XYGIMNMessageSendStateSending withProgress:progress forIndex:[self.dataArray indexOfObject:message]];
    } completeBlock:^(XYGIMNMessageSendState sendState) {
        __strong __typeof(wself)self = wself;
        [[XYGIMMessageStateManager shareManager] setMessageSendState:sendState forIndex:[self.dataArray indexOfObject:message]];
        [self.delegate messageSendStateChanged:sendState withProgress:1.0f forIndex:[self.dataArray indexOfObject:message]];
    }];
}

- (void)removeMessageAtIndex:(NSUInteger)index {
    if (index < self.dataArray.count) {
        [self.dataArray removeObjectAtIndex:index];
    }
}

- (NSDictionary *)messageAtIndex:(NSUInteger)index {
    if (index < self.dataArray.count) {
        return self.dataArray[index];
    }
    return nil;
}


#pragma mark - Setters

- (void)setChatServer:(id<XYGIMNChatServer>)chatServer {
    if (_chatServer == chatServer) {
        return;
    }
    _chatServer = chatServer;
    
}

#pragma mark - Getters

- (NSUInteger)messageCount {
    return self.dataArray.count;
}
@end
