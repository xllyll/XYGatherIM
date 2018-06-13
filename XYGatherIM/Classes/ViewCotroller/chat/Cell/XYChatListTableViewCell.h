//
//  XYChatListTableViewCell.h
//  XYGatherIM
//
//  Created by 杨卢银 on 2018/6/13.
//  Copyright © 2018年 杨卢银. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XYChatListTableViewCell : UITableViewCell

-(instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier;
@property (weak, nonatomic) IBOutlet UILabel *messageLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *headerImageView;
@property (assign , nonatomic) NSInteger badgeValue;

@end
