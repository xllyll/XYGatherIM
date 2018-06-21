//
//  XYGIMChatVideoMessageCell.m
//  XYGatherIM
//
//  Created by 杨卢银 on 2018/6/12.
//  Copyright © 2018年 杨卢银. All rights reserved.
//

#import "XYGIMChatVideoMessageCell.h"
#import "JFLoadProgressView.h"
#import "UIImageView+XYImageView.h"

@interface XYGIMChatVideoMessageCell()

@property (nonatomic, weak) JFLoadProgressView *loadProgressView;
/**
 *  用来显示image的UIImageView
 */
@property (nonatomic, strong) UIImageView *messageImageView;

/**
 *
 */
@property (nonatomic, strong) UIImageView *playImageView;

/**
 *  用来显示上传进度的UIView
 */
@property (nonatomic, strong) UIView *messageProgressView;

/**
 *  显示上传进度百分比的UILabel
 */
@property (nonatomic, weak) UILabel *messageProgressLabel;
@end
@implementation XYGIMChatVideoMessageCell

#pragma mark - Override Methods

- (void)updateConstraints {
    
    [super updateConstraints];
    float p = 0.6;
    if (self.messageImageView.image != nil) {
        p = self.messageImageView.image.size.height/self.messageImageView.image.size.width;
    }
    [self.messageImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.messageContentV);
        make.width.lessThanOrEqualTo(@220);
        make.height.equalTo(self.messageImageView.mas_width).multipliedBy(p);
    }];
    [self.playImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.messageImageView);
        make.centerY.equalTo(self.messageImageView);
        make.width.equalTo(@40);
        make.height.equalTo(@40);
    }];
    
}
/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */


#pragma mark - Setters
- (void)setUploadProgress:(CGFloat)uploadProgress{
    if (self.loadProgressView==nil) {
        self.loadProgressView = [JFLoadProgressView showInView:self.messageImageView];
    }
    if (uploadProgress==1.0) {
        [self.loadProgressView setHidden:YES];
    }
    if (uploadProgress==0) {
        self.loadProgressView = [JFLoadProgressView showInView:self.messageImageView];
    }else{
        self.loadProgressView.progressValue = uploadProgress;
    }
}

- (void)setDownloadProgress:(CGFloat)downloadProgress{
    if (self.loadProgressView==nil) {
        self.loadProgressView = [JFLoadProgressView showInView:self.messageImageView];
    }
    if (downloadProgress==1.0) {
        [self.loadProgressView setHidden:YES];
    }
    if (downloadProgress==0) {
        self.loadProgressView = [JFLoadProgressView showInView:self.messageImageView];
    }else{
        self.loadProgressView.progressValue = downloadProgress;
    }
}

-(void)showVideo{
    
}
- (void)dismissProgress{
    [self.loadProgressView removeFromSuperview];
}

#pragma mark - Public Methods

- (void)setup {
    //[super setup];
    [self.messageContentV addSubview:self.messageImageView];
    [self.messageImageView addSubview:self.playImageView];
    [super setup];
    self.messageContentV.layer.mask = self.messageContentBackgroundIV.layer;
}
- (void)configureCellWithData:(id)data {
    
    [super configureCellWithData:data];
    id image = data[kXYGIMNMessageConfigurationImageKey];
    if ([image isKindOfClass:[UIImage class]]) {
        self.messageImageView.image = image;
    }else if ([image isKindOfClass:[NSString class]]) {
        //TODO 是一个路径,可能是网址,需要加载
        NSLog(@"是一个路径");
        [self.messageImageView xy_setImageURL:self.message.thumbnailFileURLPath placeholderImage:[UIImage imageNamed:self.message.failImageName]];
    }else {
        NSLog(@"未知的图片类型");
    }
    
    
}
#pragma mark - Getters

- (UIImageView *)messageImageView {
    
    if (!_messageImageView) {
        _messageImageView = [[UIImageView alloc] init];
        _messageImageView.contentMode = UIViewContentModeScaleAspectFill;
    }
    return _messageImageView;
    
}
-(UIImageView *)playImageView{
    if (!_playImageView) {
        _playImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"MMVideoPreviewPlay"]];
        _playImageView.contentMode = UIViewContentModeScaleAspectFill;
    }
    return _playImageView;
}
#pragma mark - 弹入弹出动画

- (CGRect)contentFrameInWindow {
    return [self.messageImageView convertRect:self.messageImageView.bounds toView:self.messageImageView.window];
}
- (void)willExitFullScreenShow {
    //    self.chatImageView.hidden = YES;
    //    self.borderView.hidden = YES;
}

- (void)didExitFullScreenShow {
    //    self.chatImageView.hidden = NO;
    //    self.borderView.hidden = NO;
}
@end
