//
//  XYChatViewController.m
//  XYGatherIM
//
//  Created by 杨卢银 on 2018/4/9.
//  Copyright © 2018年 杨卢银. All rights reserved.
//

#import "XYGIMChatViewController.h"
#import "NSDate+XYDate.h"
#import "SDKHelper.h"

@interface XYGIMChatViewController ()<XYGIMChatBarDelegate,XYGIMChatMessageCellDelegate>

@end

@implementation XYGIMChatViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.chatBar];
    
    self.chatBar.delegate = self;
    
    self.view.backgroundColor = [UIColor colorWithRed:234.0f/255.0f green:234/255.0f blue:234/255.f alpha:1.0f];
}
-(void)updateViewConstraints{
    [super updateViewConstraints];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top);
        make.bottom.equalTo(self.chatBar.mas_top);
        make.right.equalTo(self.view.mas_right);
        make.left.equalTo(self.view.mas_left);
    }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/





#pragma mark XYGIMChatBarDelegate
- (void)chatBar:(XYGIMChatBar *)chatBar sendMessage:(NSString *)message{
    [self sendTextMessage:message];
}
- (void)chatBar:(XYGIMChatBar *)chatBar sendVoice:(NSString *)voiceFileName seconds:(NSTimeInterval)seconds{
    [self sendVoiceMessageWithLocalPath:voiceFileName duration:seconds];
}
- (void)chatBar:(XYGIMChatBar *)chatBar sendPictures:(NSArray *)pictures{
    if (pictures) {
        for (UIImage *img in pictures) {
            [self sendImageMessage:img];
        }
    }
}
- (void)chatBar:(XYGIMChatBar *)chatBar sendImageDatas:(NSArray *)imagesDatas{
    
}
- (void)chatBar:(XYGIMChatBar *)chatBar sendLocation:(CLLocationCoordinate2D)locationCoordinate locationText:(NSString *)locationText{
    [self sendLocationMessageLatitude:locationCoordinate.latitude longitude:locationCoordinate.longitude andAddress:locationText];
}
#pragma mark - XYGIMChatMessageCellDelegate

- (void)messageCellTappedHead:(XYGIMChatMessageCell *)messageCell {
    
    NSIndexPath *indexPath = [self.tableView indexPathForCell:messageCell];
    NSLog(@"tapHead :%@",indexPath);
    if (messageCell.messageOwner == XYGIMNMessageOwnerSelf) {
        
    }else{
    }
}

- (void)messageCellTappedBlank:(XYGIMChatMessageCell *)messageCell {
    NSIndexPath *indexPath = [self.tableView indexPathForCell:messageCell];
    NSLog(@"tapBlank :%@",indexPath);
    [self.chatBar endInputing];
}

- (void)messageCellTappedMessage:(XYGIMChatMessageCell *)messageCell{
    NSIndexPath *indexPath = [self.tableView indexPathForCell:messageCell];
    NSLog(@"tapMessage :%@",indexPath);
//    _selectMessageCell = messageCell;
//    _selectMessage = messageCell.message;
    
    switch (messageCell.messageType) {
        case XYGIMNMessageTypeVoice:
        {
            NSString *voiceFileName = [self.chatViewModel messageAtIndex:indexPath.row][kXYGIMNMessageConfigurationVoiceKey];
            if(voiceFileName==nil || voiceFileName.length==0){
                XYNMessage *msg = messageCell.message;
                voiceFileName = msg.fileLocalPath;
            }
            [[XYGIMAudioPlayer sharePlayer] playAudioWithURLString:voiceFileName atIndex:indexPath.row];
        }
            break;
        case XYGIMNMessageTypeLocation:
        
            break;
            
            
        case XYGIMNMessageTypeImage:{
            [self imageMessageCellSelected:messageCell.message messageCell:messageCell];
        }
            break;
        case XYGIMNMessageTypeVideo:{
            [self videoMessageCellSelected:messageCell.message messageCell:messageCell];
        }
            break;
        default:
            break;
    }
    
}
@end
