//
//  XYChatBaseViewController.m
//  XYGatherIM
//
//  Created by 杨卢银 on 2018/6/11.
//  Copyright © 2018年 杨卢银. All rights reserved.
//

#import "XYGIMChatBaseViewController.h"
#import "UITableView+XYGIMNCellRegister.h"
#import "XYGIMChatMessageCell.h"
#import "XYGIMChatTextMessageCell.h"
#import "XYGIMChatImageMessageCell.h"
#import "XYGIMChatVoiceMessageCell.h"
#import "XYGIMChatVideoMessageCell.h"
#import "NSDate+XYDate.h"
#import "SDKHelper.h"
#import "XYConfig.h"

#import <MobileCoreServices/MobileCoreServices.h>
#import <MediaPlayer/MediaPlayer.h>
#import "XYGIMChatAssetDisplayController.h"

@interface XYGIMChatBaseViewController ()<XYGIMAudioPlayerDelegate,XYGIMChatViewModelDelegate,XYGIMChatMessageCellDelegate,XYGIMChatImagePreviewDelegate,XYGIMChatManagerDelegate>
{
    dispatch_queue_t _messageQueue;
}

@property (strong , nonatomic) NSMutableArray *dataArray;

@end

@implementation XYGIMChatBaseViewController


-(instancetype)initWithConversationChatter:(NSString *)conversationChatter conversationType:(XYGIMConversationType)conversationType{
    self = [super initWithNibName:nil bundle:nil];
    if (self) {
        _conversation = [[XYGIMClient sharedClient].chatManager getConversation:conversationChatter type:conversationType createIfNotExist:YES];
        
        
        
        _messageQueue = dispatch_queue_create("xllyll.com", NULL);
        
        [_conversation markAllMessagesAsRead:nil];
        
        _messageCountOfPage = 10;
        
        
        _messsagesSource = [NSMutableArray array];
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = self.conversation.conversationId;
    
    self.chatViewModel = [[XYGIMChatViewModel alloc] initWithParentVC:self];
    self.chatViewModel.delegate = self;
    
    [XYGIMAudioPlayer sharePlayer].delegate = self;
    
    //注册代理
    //[EMCDDeviceManager sharedInstance].delegate = self;
    
    [[XYGIMClient sharedClient].chatManager addDelegate:self delegateQueue:nil];
    [[XYGIMClient sharedClient].roomManager addDelegate:self delegateQueue:nil];
    [[XYGIMClient sharedClient].callManager addDelegate:self delegateQueue:nil];
    
    [self tableViewDidTriggerHeaderRefresh];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    self.isViewDidAppear = YES;
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    self.isViewDidAppear = NO;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}
#pragma mark - 视频、图片弹出、弹入动画 -

- (void)showAssetFromCell:(XYGIMChatMessageCell *)cell {
//    [[LLAudioManager sharedManager] stopPlaying];
//    [self.chatInputView dismissKeyboard];
    
    NSMutableArray *array = [NSMutableArray array];
    for (XYNMessage *model in self.dataArray) {
        if ([model isKindOfClass:[XYNMessage class]]) {
            if (model.bodyType == XYGIMMessageBodyTypeImage ||
                model.bodyType == XYGIMMessageBodyTypeVideo) {
                [array addObject:model];
            }
        }
    }
    
    XYGIMChatAssetDisplayController *vc = [[XYGIMChatAssetDisplayController alloc] initWithNibName:nil bundle:nil];
    vc.allAssets = array;
    vc.curShowMessageModel = cell.message;
    vc.originalWindowFrame = [cell contentFrameInWindow];
    vc.delegate = self;
    
    [self.navigationController pushViewController:vc animated:NO];
    
}
-(void)didFinishWithMessageModel:(XYNMessage *)model targetView:(UIView<XYGIMAssetDisplayView> *)assetView scrollToTop:(BOOL)scrollToTop{
   
}
#pragma mark - public
- (NSArray *)formatMessages:(NSArray *)messages
{
    NSMutableArray *formattedArray = [[NSMutableArray alloc] init];
    if ([messages count] == 0) {
        return formattedArray;
    }
    
    for (XYGIMMessage *message in messages) {
        //计算時間间隔
        CGFloat interval = (self.messageTimeIntervalTag - message.timestamp) / 1000;
        if (self.messageTimeIntervalTag < 0 || interval > 60 || interval < -60) {
            NSDate *messageDate = [NSDate dateWithTimeIntervalInMilliSecondSince1970:(NSTimeInterval)message.timestamp];
            NSString *timeStr = @"";
            
            timeStr = [messageDate formattedTime];
            [formattedArray addObject:timeStr];
            self.messageTimeIntervalTag = message.timestamp;
        }
        
        //FIX:构建数据模型
//        id<IMessageModel> model = nil;
//
//        model = [[EaseMessageModel alloc] initWithMessage:message];
//        model.avatarImage = [UIImage imageNamed:@"EaseUIResource.bundle/user"];
//        model.failImageName = @"imageDownloadFail";
//
//        if (model) {
//            [formattedArray addObject:model];
//        }
        XYNMessage *model = [[XYNMessage alloc] initWithMessage:message];
        model.avatarImage = [UIImage imageNamed:@"user"];
        model.failImageName = @"imageDownloadFail";
        if (model) {
            [formattedArray addObject:model];
        }
    }
    
    return formattedArray;
}
-(void)addMessageToDataSource:(XYGIMMessage *)aMessage
                     progress:(id)progress
{
    [self.messsagesSource addObject:aMessage];
    NSArray *messages = [self formatMessages:@[aMessage]];
    [self.dataArray addObjectsFromArray:messages];
    [self addXYGIMChatMessageModel:aMessage];
    
    
//    __weak XYGIMChatBaseViewController *weakSelf = self;
//
//    dispatch_async(_messageQueue, ^{
//
//        NSArray *messages = [weakSelf formatMessages:@[aMessage]];
//
//        dispatch_async(dispatch_get_main_queue(), ^{
//                [weakSelf.dataArray addObjectsFromArray:messages];
//                [self addXYGIMChatMessageModel:aMessage];
//        });
//    });
}
- (void)tableViewDidTriggerHeaderRefresh
{
    self.messageTimeIntervalTag = -1;
    NSString *messageId = nil;
    if ([self.messsagesSource count] > 0) {
        messageId = [(XYGIMMessage *)self.messsagesSource.firstObject messageId];
    }
    else {
        messageId = nil;
    }
    [self _loadMessagesBefore:messageId count:self.messageCountOfPage append:YES];
    //
    //    [self tableViewDidFinishTriggerHeader:YES reload:YES];
}
#pragma mark - pivate data

- (void)_loadMessagesBefore:(NSString*)messageId
                      count:(NSInteger)count
                     append:(BOOL)isAppend
{
    __weak typeof(self) weakSelf = self;
    
    [weakSelf.conversation loadMessagesStartFromId:messageId count:(int)count searchDirection:XYGIMMessageSearchDirectionUp completion:^(NSArray *aMessages, XYError *aError) {
        NSArray *moreMessages = aMessages;
        if ([moreMessages count] == 0) {
            return;
        }
        
        //格式化消息
        NSArray *formattedMessages = [weakSelf formatMessages:moreMessages];
        
        NSInteger scrollToIndex = 0;
        if (isAppend) {
            [weakSelf.messsagesSource insertObjects:moreMessages atIndexes:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, [moreMessages count])]];
            
            //合并消息
            id object = [weakSelf.dataArray firstObject];
            if ([object isKindOfClass:[NSString class]])
            {
                NSString *timestamp = object;
                [formattedMessages enumerateObjectsWithOptions:NSEnumerationReverse usingBlock:^(id model, NSUInteger idx, BOOL *stop) {
                    if ([model isKindOfClass:[NSString class]] && [timestamp isEqualToString:model])
                    {
                        [weakSelf.dataArray removeObjectAtIndex:0];
                        *stop = YES;
                    }
                }];
            }
            scrollToIndex = [weakSelf.dataArray count];
            [weakSelf.dataArray insertObjects:formattedMessages atIndexes:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, [formattedMessages count])]];
        }
        else{
            [weakSelf.messsagesSource removeAllObjects];
            [weakSelf.messsagesSource addObjectsFromArray:moreMessages];
            
            [weakSelf.dataArray removeAllObjects];
            [weakSelf.dataArray addObjectsFromArray:formattedMessages];
        }
        
        XYGIMMessage *latest = [weakSelf.messsagesSource lastObject];
        weakSelf.messageTimeIntervalTag = latest.timestamp;
        
        
        [self addXYGIMChatModel:self.dataArray];
        
        //从数据库导入时重新下载没有下载成功的附件
        for (XYGIMMessage *message in moreMessages)
        {
            [weakSelf _downloadMessageAttachments:message];
        }
        
        //发送已读回执
        [weakSelf _sendHasReadResponseForMessages:moreMessages
                                           isRead:NO];
    }];
    
}
- (void)_downloadMessageAttachments:(XYGIMMessage *)message
{
    
}
- (void)_reloadTableViewDataWithMessage:(XYGIMMessage *)message{
    __weak XYGIMChatBaseViewController *weakSelf = self;
    dispatch_async(_messageQueue, ^{
        if ([weakSelf.conversation.conversationId isEqualToString:message.conversationId])
        {
            for (int i = 0; i < weakSelf.dataArray.count; i ++) {
                id object = [weakSelf.dataArray objectAtIndex:i];
                if ([object isKindOfClass:[XYNMessage class]]) {
                    XYNMessage *model = object;
                    if ([message.messageId isEqualToString:model.messageId]) {
                        XYNMessage *model = nil;
                        model = [[XYNMessage alloc] initWithMessage:message];
                        model.avatarImage = [UIImage imageNamed:@"EaseUIResource.bundle/user"];
                        model.failImageName = @"imageDownloadFail";
                        
                        dispatch_async(dispatch_get_main_queue(), ^{
                            //                            [weakSelf.tableView beginUpdates];
                            [weakSelf.dataArray replaceObjectAtIndex:i withObject:model];
                            //                            [weakSelf.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:i inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
                            //                            [weakSelf.tableView endUpdates];
                        });
                        break;
                    }
                }
            }
        }
    });
}
- (void)_sendHasReadResponseForMessages:(NSArray*)messages
                                 isRead:(BOOL)isRead
{
    NSMutableArray *unreadMessages = [NSMutableArray array];
    for (NSInteger i = 0; i < [messages count]; i++)
    {
        XYGIMMessage *message = messages[i];
        BOOL isSend = YES;
        
        
        isSend = [self shouldSendHasReadAckForMessage:message
                                                 read:isRead];
        if (isSend)
        {
            [unreadMessages addObject:message];
        }
    }
    
    if ([unreadMessages count])
    {
        for (XYGIMMessage *message in unreadMessages)
        {
            //[[EMClient sharedClient].chatManager asyncSendReadAckForMessage:message];
            [[XYGIMClient sharedClient].chatManager sendMessageReadAck:message completion:^(XYGIMMessage *aMessage, XYError *aError) {
                
            }];
        }
    }
}
- (XYGIMChatType)_messageTypeFromConversationType
{
    XYGIMChatType type = XYGIMChatTypeChat;
    switch (self.conversation.type) {
        case XYGIMConversationTypeChat:
            type = XYGIMChatTypeChat;
            break;
        case XYGIMConversationTypeGroupChat:
            type = XYGIMChatTypeGroupChat;
            break;
        case XYGIMConversationTypeChatRoom:
            type = XYGIMChatTypeChatRoom;
            break;
        default:
            break;
    }
    return type;
}
- (BOOL)_shouldMarkMessageAsRead
{
    BOOL isMark = YES;
    if (([UIApplication sharedApplication].applicationState == UIApplicationStateBackground) || !self.isViewDidAppear)
    {
        isMark = NO;
    }
    
    return isMark;
}
- (void)_imageMessageCellSelected:(XYNMessage*)model messageCell:(XYGIMChatMessageCell*)messageCell;
{
    __weak XYGIMChatBaseViewController *weakSelf = self;
    XYGIMImageMessageBody *imageBody = (XYGIMImageMessageBody*)[model.message body];
    
    if ([imageBody type] == XYGIMMessageBodyTypeImage) {
        if (imageBody.thumbnailDownloadStatus == XYGIMDownloadStatusSuccessed) {
            if (imageBody.downloadStatus == XYGIMDownloadStatusSuccessed)
            {
                //发送已读回执
                [weakSelf _sendHasReadResponseForMessages:@[model.message] isRead:YES];
                NSString *localPath = model.message == nil ? model.fileLocalPath : [imageBody localPath];
                if (localPath && localPath.length > 0) {
                    UIImage *image = [UIImage imageWithContentsOfFile:localPath];
                    [(XYGIMChatImageMessageCell*)messageCell dismissProgress];
                    if (image)
                    {
                        //[[EaseMessageReadManager defaultManager] showBrowserWithImages:@[image] inViewController:self];
                        [self showAssetFromCell:messageCell];
                    }
                    else
                    {
                        NSLog(@"Read %@ failed!", localPath);
                    }
                    return;
                }
            }
            NSLog(@"图片正在下载！");
            //[weakSelf showHudInView:weakSelf.view hint:NSEaseLocalizedString(@"message.downloadingImage", @"downloading a image...")];
            [[XYGIMClient sharedClient].chatManager downloadMessageAttachment:model.message progress:^(int progress) {
                if (messageCell.messageType == XYGIMNMessageTypeImage) {
                    
                    float downf = (float)progress/100.0;
                    
                    NSLog(@"图片下载中－－－－%.2f！",downf);
                    
                    [(XYGIMChatImageMessageCell*)messageCell setDownloadProgress:downf];
                }
            } completion:^(XYGIMMessage *message, XYError *error) {
                //[weakSelf hideHud];
                if (!error) {
                    //发送已读回执
                    [weakSelf _sendHasReadResponseForMessages:@[model.message] isRead:YES];
                    NSString *localPath = message == nil ? model.fileLocalPath : [(XYGIMImageMessageBody*)message.body localPath];
                    if (localPath && localPath.length > 0) {
                        UIImage *image = [UIImage imageWithContentsOfFile:localPath];
                        //                                weakSelf.isScrollToBottom = NO;
                        if (image)
                        {
                            //[[EaseMessageReadManager defaultManager] showBrowserWithImages:@[image] inViewController:self];
                            [self showAssetFromCell:messageCell];
                        }
                        else
                        {
                            NSLog(@"Read %@ failed!", localPath);
                        }
                        return ;
                    }
                }
                //[weakSelf showHint:NSEaseLocalizedString(@"message.imageFail", @"image for failure!")];
            }];
        }else{
            //获取缩略图
            [[XYGIMClient sharedClient].chatManager downloadMessageThumbnail:model.message progress:nil completion:^(XYGIMMessage *message, XYError *error) {
                
                if (!error) {
                    [weakSelf _reloadTableViewDataWithMessage:model.message];
                }else{
                    //[weakSelf showHint:NSEaseLocalizedString(@"message.thumImageFail", @"thumbnail for failure!")];
                }
            }];
        }
    }
}

- (void)_videoMessageCellSelected:(XYNMessage*)model messageCell:(XYGIMChatVideoMessageCell*)messageCell
{
    _scrollToBottomWhenAppear = NO;
    
    XYGIMVideoMessageBody *videoBody = (XYGIMVideoMessageBody*)model.message.body;
    
    //判断本地路劲是否存在
    NSString *localPath = [model.fileLocalPath length] > 0 ? model.fileLocalPath : videoBody.localPath;
    if ([localPath length] == 0) {
        //[self showHint:NSEaseLocalizedString(@"message.videoFail", @"video for failure!")];
        //视频获取失败!
        return;
    }
    
    dispatch_block_t block = ^{
        //发送已读回执
        [self _sendHasReadResponseForMessages:@[model.message]
                                       isRead:YES];
        [messageCell dismissProgress];
        NSURL *videoURL = [NSURL fileURLWithPath:localPath];
        MPMoviePlayerViewController *moviePlayerController = [[MPMoviePlayerViewController alloc] initWithContentURL:videoURL];
        [moviePlayerController.moviePlayer prepareToPlay];
        moviePlayerController.moviePlayer.movieSourceType = MPMovieSourceTypeFile;
        [self presentMoviePlayerViewControllerAnimated:moviePlayerController];
    };
    
    __weak typeof(self) weakSelf = self;
    
    void (^completion)(XYGIMMessage *aMessage, XYError *error) = ^(XYGIMMessage *aMessage, XYError *error) {
        if (!error)
        {
            
            [weakSelf _reloadTableViewDataWithMessage:aMessage];
        }
        else
        {
            //缩略图获取失败!
            //[weakSelf showHint:NSEaseLocalizedString(@"message.thumImageFail", @"thumbnail for failure!")];
        }
    };
    
    if (videoBody.thumbnailDownloadStatus == XYGIMDownloadStatusFailed || ![[NSFileManager defaultManager] fileExistsAtPath:videoBody.thumbnailLocalPath]) {
        //[self showHint:@"begin downloading thumbnail image, click later"];
        [[XYGIMClient sharedClient].chatManager downloadMessageThumbnail:model.message progress:^(int progress) {
            if (messageCell.messageType == XYGIMNMessageTypeVideo) {
                
                float downf = (float)progress/100.0;
                [messageCell setDownloadProgress:downf];
            }
        } completion:completion];
        return;
    }
    
    if (videoBody.downloadStatus == XYGIMDownloadStatusSuccessed && [[NSFileManager defaultManager] fileExistsAtPath:localPath])
    {
        block();
        return;
    }
    
    /*
     [[EMClient sharedClient].chatManager asyncDownloadMessageAttachments:model.message progress:^(int progress) {
     if (messageCell.messageType == FUNMessageTypeVideo) {
     
     float downf = (float)progress/100.0;
     
     NSLog(@"图片下载中－－－－%.2f！",downf);
     
     [messageCell setDownloadProgress:downf];
     }
     } completion:^(XYGIMMessage *message, EMError *error) {
     //[weakSelf hideHud];
     if (!error) {
     block();
     }else{
     //[weakSelf showHint:NSEaseLocalizedString(@"message.videoFail", @"video for failure!")];
     }
     }];
     */
    [[XYGIMClient sharedClient].chatManager downloadMessageAttachment:model.message progress:^(int progress) {
        if (messageCell.messageType == XYGIMNMessageTypeVideo) {
            
            float downf = (float)progress/100.0;
            
            NSLog(@"图片下载中－－－－%.2f！",downf);
            
            [messageCell setDownloadProgress:downf];
        }
    } completion:^(XYGIMMessage *message, XYError *error) {
        if (!error) {
            block();
        }else{
            //[weakSelf showHint:NSEaseLocalizedString(@"message.videoFail", @"video for failure!")];
        }
    }];
}
-(void)addXYGIMChatModel:(NSArray*)list{
    if (list) {
        for (XYGIMMessage *message in list) {
            [self addMessage:[self xymessageFromEMessage:message]];
        }
    }
}
-(void)addXYGIMChatMessageModel:(XYGIMMessage*)message{
    [self addMessage:[self xymessageFromEMessage:message]];
}
-(NSDictionary*)xymessageFromEMessage:(XYGIMMessage *)message{
    
    
    if ([message isKindOfClass:[NSString class]]) {
        NSMutableDictionary *messageDict = [NSMutableDictionary dictionary];
        messageDict[kXYGIMNMessageConfigurationTypeKey] = @(XYGIMNMessageTypeSystem);
        messageDict[kXYGIMNMessageConfigurationOwnerKey] = @(XYGIMNMessageOwnerSystem);
        messageDict[kXYGIMNMessageConfigurationGroupKey] = @(XYGIMNMessageChatSingle);
        messageDict[kXYGIMNMessageConfigurationNicknameKey] = @"XYGIM";
        messageDict[kXYGIMNMessageConfigurationAvatarKey] =@"";
        messageDict[kXYGIMNMessageConfigurationTextKey] = message;
        return messageDict;
    }
    if ([message isKindOfClass:[XYNMessage class]]) {
        XYNMessage *model = (XYNMessage*)message;
        return model.dictionary;
    }
    XYNMessage *msg = [[XYNMessage alloc] initWithMessage:message];
    return msg.dictionary;
}


- (BOOL)shouldSendHasReadAckForMessage:(XYGIMMessage *)message
                                  read:(BOOL)read
{
    NSString *account = [[XYGIMClient sharedClient] currentUsername];
    if (message.chatType != XYGIMChatTypeChat || message.isReadAcked || [account isEqualToString:message.from] || ([UIApplication sharedApplication].applicationState == UIApplicationStateBackground) || !self.isViewDidAppear)
    {
        return NO;
    }
    
    XYGIMMessageBody *body = message.body;
    if (((body.type == XYGIMMessageBodyTypeVideo) ||
         (body.type == XYGIMMessageBodyTypeVoice) ||
         (body.type == XYGIMMessageBodyTypeImage)) &&
        !read)
    {
        return NO;
    }
    else
    {
        return YES;
    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
#pragma mark - Getters

- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, self.view.frame.size.height - kMinHeight - 64) style:UITableViewStylePlain];
        
        _tableView.estimatedRowHeight = 66;
        _tableView.delegate = self.chatViewModel;
        _tableView.dataSource = self.chatViewModel;
        //
        [_tableView registerXYGIMNChatMessageCellClass];
        
        _tableView.backgroundColor = self.view.backgroundColor;
        
        _tableView.contentInset = UIEdgeInsetsMake(8, 0, 0, 0);
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        
    }
    return _tableView;
}
- (XYGIMChatBar *)chatBar {
    if (!_chatBar) {
        
        CGRect rect = CGRectMake(0, self.view.frame.size.height - kMinHeight - (self.navigationController.navigationBar.isTranslucent ? 0 : 64), self.view.frame.size.width, kMinHeight);
        
        _chatBar = [[XYGIMChatBar alloc] initWithFrame:rect rootVC:self isSingleChat:YES];
        [_chatBar setSuperViewHeight:[UIScreen mainScreen].bounds.size.height - (self.navigationController.navigationBar.isTranslucent ? 0 : 64)];
        
    }
    return _chatBar;
}

#pragma mark XYGIMChatViewModelDelegate
- (NSString *)chatterNickname {
    
    return @"";
}

- (NSString *)chatterHeadAvator {
    return @"";
}
- (void)messageReadStateChanged:(XYGIMNMessageReadState)readState withProgress:(CGFloat)progress forIndex:(NSUInteger)index {
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:index inSection:0];
    XYGIMChatMessageCell *messageCell = [self.tableView cellForRowAtIndexPath:indexPath];
    if (![self.tableView.visibleCells containsObject:messageCell]) {
        return;
    }
    messageCell.messageReadState = readState;
}

- (void)messageSendStateChanged:(XYGIMNMessageSendState)sendState withProgress:(CGFloat)progress forIndex:(NSUInteger)index{
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:index inSection:0];
    XYGIMChatMessageCell *messageCell = [self.tableView cellForRowAtIndexPath:indexPath];
    if (![self.tableView.visibleCells containsObject:messageCell]) {
        return;
    }
    if (messageCell.messageType == XYGIMNMessageTypeImage) {
        [(XYGIMChatImageMessageCell *)messageCell setUploadProgress:progress];
    }
    dispatch_async(dispatch_get_main_queue(), ^{
        messageCell.messageSendState = sendState;
    });
}
- (void)reloadAfterReceiveMessage:(NSDictionary *)message {
    [self.tableView reloadData];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:self.chatViewModel.messageCount - 1 inSection:0];
    [self.tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionBottom animated:NO];
}
#pragma mark XYGIMAudioPlayerDelegate
- (void)audioPlayerStateDidChanged:(XYGIMNVoiceMessageState)audioPlayerState forIndex:(NSUInteger)index {
    
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:index inSection:0];
    dispatch_async(dispatch_get_main_queue(), ^{
        XYGIMChatVoiceMessageCell *voiceMessageCell = [self.tableView cellForRowAtIndexPath:indexPath];
        [voiceMessageCell setVoiceMessageState:audioPlayerState];
    });
    
}
#pragma mark - Private Methods

- (void)addMessage:(NSDictionary *)message {
    [self.chatViewModel addMessage:message];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:self.chatViewModel.messageCount - 1 inSection:0];
    [self.tableView reloadData];
    [self.tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionTop animated:NO];
    //    [self.chatViewModel sendMessage:message];
}

#pragma mark - send message

- (void)_sendMessage:(XYGIMMessage *)message
{
    if (self.conversation.type == XYGIMConversationTypeGroupChat){
        message.chatType = XYGIMChatTypeGroupChat;
    }
    else if (self.conversation.type == XYGIMConversationTypeChatRoom){
        message.chatType = XYGIMChatTypeChatRoom;
    }
    
    [self addMessageToDataSource:message
                        progress:nil];
    
    __weak typeof(self) weakself = self;
    [[XYGIMClient sharedClient].chatManager sendMessage:message progress:^(int progress) {
        float progres = (float)progress/100.0;
        NSLog(@"---->消息上传中:%.2f",progres);
        if (message.messageType==XYGIMMessageBodyTypeImage || message.messageType==XYGIMMessageBodyTypeVideo) {
            //[self.chatViewModel sendMessage:nil];
            //            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:self.dataArray.count-1 inSection:0];
            //            FUChatMessageCell *messageCell = [self.tableView cellForRowAtIndexPath:indexPath];
            //            if (![self.tableView.visibleCells containsObject:messageCell]) {
            //                return;
            //            }
            //            if (messageCell.messageType == XYGIMNMessageTypeImage) {
            //
            //                [(FUChatImageMessageCell *)messageCell setUploadProgress:progres];
            //            }
            //            dispatch_async(dispatch_get_main_queue(), ^{
            //                messageCell.messageSendState = XYGIMNMessageSendSuccess;
            //            });
        }
    } completion:^(XYGIMMessage *message, XYError *error) {
        [weakself.tableView reloadData];
    }];
    
}

- (void)sendTextMessage:(NSString *)text
{
    [self sendTextMessage:text withExt:nil];
}

- (void)sendTextMessage:(NSString *)text withExt:(NSDictionary*)ext
{
    XYGIMMessage *message = [SDKHelper sendTextMessage:text
                                                    to:self.conversation.conversationId
                                           messageType:[self _messageTypeFromConversationType]
                                            messageExt:ext];
    [self _sendMessage:message];
}
- (void)sendLocationMessageLatitude:(double)latitude
                          longitude:(double)longitude
                         andAddress:(NSString *)address
{
    XYGIMMessage *message = [SDKHelper sendLocationMessageWithLatitude:latitude
                                                             longitude:longitude
                                                               address:address
                                                                    to:self.conversation.conversationId
                                                           messageType:[self _messageTypeFromConversationType]
                                                            messageExt:nil];
    [self _sendMessage:message];
}
- (void)sendImageMessageWithData:(NSData *)imageData
{
    
    
    XYGIMMessage *message = [SDKHelper sendImageMessageWithImageData:imageData
                                                                   to:self.conversation.conversationId
                                                          messageType:[self _messageTypeFromConversationType]
                                                           messageExt:nil];
    [self _sendMessage:message];
}

- (void)sendImageMessage:(UIImage *)image
{
    
    
    XYGIMMessage *message = [SDKHelper sendImageMessageWithImage:image
                                                               to:self.conversation.conversationId
                                                      messageType:[self _messageTypeFromConversationType]
                                                       messageExt:nil];
    [self _sendMessage:message];
}
-(void)sendVoiceMessageWithLocalPath:(NSString *)localPath duration:(NSInteger)duration{
    XYGIMMessage *message = [SDKHelper sendVoiceMessageWithLocalPath:localPath
                                                            duration:duration
                                                                  to:self.conversation.conversationId
                                                          messageType:[self _messageTypeFromConversationType]
                                                           messageExt:nil];
    [self _sendMessage:message];
}

#pragma mark SELECT
- (void)imageMessageCellSelected:(id)model messageCell:(UIView *)messageCell{
    [self _imageMessageCellSelected:model messageCell:(XYGIMChatMessageCell*)messageCell];
}
- (void)videoMessageCellSelected:(id)model messageCell:(UIView *)messageCell{
    [self _videoMessageCellSelected:model messageCell:(XYGIMChatVideoMessageCell*)messageCell];
}

#pragma mark XYGIMChatManagerDelegate
-(void)XYGIM_onRecvMessages:(NSArray<XYGIMMessage *> *)aMessages{
    for (XYGIMMessage *message in aMessages) {
        if ([self.conversation.conversationId isEqualToString:message.conversationId]) {
            [self addMessageToDataSource:message progress:nil];
            
            [self _sendHasReadResponseForMessages:@[message]
                                           isRead:NO];
            
            if ([self _shouldMarkMessageAsRead])
            {
                [self.conversation markMessageAsReadWithId:message.messageId error:nil];
            }
        }
    }
}
@end
