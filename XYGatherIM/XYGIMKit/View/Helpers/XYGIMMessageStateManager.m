//
//  XYGIMMessageStateManager.m
//  XYGatherIM
//
//  Created by 杨卢银 on 2018/6/12.
//  Copyright © 2018年 杨卢银. All rights reserved.
//

#import "XYGIMMessageStateManager.h"

@interface XYGIMMessageStateManager()

@property (nonatomic, strong) NSMutableDictionary *messageReadStateDict;
@property (nonatomic, strong) NSMutableDictionary *messageSendStateDict;

@end

@implementation XYGIMMessageStateManager

+ (instancetype)shareManager {
    static id manager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[self alloc] init];
    });
    return manager;
}

- (instancetype)init {
    if ([super init]) {
        _messageReadStateDict = [NSMutableDictionary dictionary];
        _messageSendStateDict = [NSMutableDictionary dictionary];
    }
    return self;
}


#pragma mark - Public Methods

- (XYGIMNMessageSendState)messageSendStateForIndex:(NSUInteger)index {
    if (_messageSendStateDict[@(index)]) {
        return [_messageSendStateDict[@(index)] integerValue];
    }
    return XYGIMNMessageSendSuccess;
}

- (XYGIMNMessageReadState)messageReadStateForIndex:(NSUInteger)index {
    if (_messageReadStateDict[@(index)]) {
        return [_messageReadStateDict[@(index)] integerValue];
    }
    return XYGIMNMessageReaded;
}

- (void)setMessageSendState:(XYGIMNMessageSendState)messageSendState forIndex:(NSUInteger)index {
    _messageSendStateDict[@(index)] = @(messageSendState);
}

- (void)setMessageReadState:(XYGIMNMessageReadState)messageReadState forIndex:(NSUInteger)index {
    _messageReadStateDict[@(index)] = @(messageReadState);
}


- (void)cleanState {
    
    [_messageSendStateDict removeAllObjects];
    [_messageReadStateDict removeAllObjects];
    
}

@end
