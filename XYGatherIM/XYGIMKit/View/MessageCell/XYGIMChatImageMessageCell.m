//
//  XYGIMChatImageMessageCell.m
//  XYGatherIM
//
//  Created by 杨卢银 on 2018/6/12.
//  Copyright © 2018年 杨卢银. All rights reserved.
//

#import "XYGIMChatImageMessageCell.h"
#import "JFLoadProgressView.h"
#import "UIImageView+XYImageView.h"

@interface XYGIMChatImageMessageCell ()

@property (nonatomic, weak) JFLoadProgressView *loadProgressView;
/**
 *  用来显示image的UIImageView
 */
@property (nonatomic, strong) UIImageView *messageImageView;

/**
 *  用来显示上传进度的UIView
 */
@property (nonatomic, strong) UIView *messageProgressView;

/**
 *  显示上传进度百分比的UILabel
 */
@property (nonatomic, weak) UILabel *messageProgressLabel;

@end

@implementation XYGIMChatImageMessageCell


#pragma mark - Override Methods

- (void)updateConstraints {
    
    [super updateConstraints];
    [self.messageImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.messageContentV);
        make.width.lessThanOrEqualTo(@220);
        make.height.lessThanOrEqualTo(@200);
    }];
    
}

#pragma mark - Public Methods

- (void)setup {
    
    [self.messageContentV addSubview:self.messageImageView];
    [self.messageContentV addSubview:self.messageProgressView];
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
        //[self.messageImageView xy_setImageURL:self.message.thumbnailFileURLPath placeholderImage:[UIImage imageNamed:self.message.failImageName]];
    }else {
        NSLog(@"未知的图片类型");
    }
    
    
}
static CGRect oldframe;
-(void)showImage{
    UIImageView *avatarImageView = self.messageImageView;
    UIImage *image=avatarImageView.image;
    UIWindow *window=[UIApplication sharedApplication].keyWindow;
    UIView *backgroundView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    oldframe=[avatarImageView convertRect:avatarImageView.bounds toView:window];
    backgroundView.backgroundColor=[UIColor blackColor];
    backgroundView.alpha=0;
    
    UIImageView *imageView=[[UIImageView alloc]initWithFrame:oldframe];
    imageView.image=image;
    imageView.tag=1;
    [backgroundView addSubview:imageView];
    [window addSubview:backgroundView];
    
    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hideImage:)];
    [backgroundView addGestureRecognizer: tap];
    
    [UIView animateWithDuration:0.3 animations:^{
        imageView.frame=CGRectMake(0,([UIScreen mainScreen].bounds.size.height-image.size.height*[UIScreen mainScreen].bounds.size.width/image.size.width)/2, [UIScreen mainScreen].bounds.size.width, image.size.height*[UIScreen mainScreen].bounds.size.width/image.size.width);
        backgroundView.alpha=1;
    } completion:^(BOOL finished) {
        
    }];
}
-(void)hideImage:(UITapGestureRecognizer*)tap{
    
    UIView
    *backgroundView=tap.view;
    
    UIImageView
    *imageView=(UIImageView*)[tap.view viewWithTag:1];
    
    [UIView
     animateWithDuration:0.3
     
     animations:^{
         
         imageView.frame=oldframe;
         
         backgroundView.alpha=0;
         
     }
     completion:^(BOOL finished) {
         
         [backgroundView
          removeFromSuperview];
         
     }];
    
}

#pragma mark - Setters

- (void)setUploadProgress:(CGFloat)uploadProgress {
    [self setMessageSendState:XYGIMNMessageSendStateSending];
    [self.messageProgressView setFrame:CGRectMake(0, 0, self.messageImageView.bounds.size.width, self.messageImageView.bounds.size.height * (1 - uploadProgress))];
    [self.messageProgressLabel setText:[NSString stringWithFormat:@"%.0f%%",uploadProgress * 100]];
}
-(void)setDownloadProgress:(CGFloat)downloadProgress{
    if (self.loadProgressView==nil) {
        self.loadProgressView = [JFLoadProgressView showInView:self.messageImageView];
    }
    
    if (downloadProgress==0) {
        self.loadProgressView = [JFLoadProgressView showInView:self.messageImageView];
    }else{
        self.loadProgressView.progressValue = downloadProgress;
    }
}
- (void)setMessageSendState:(XYGIMNMessageSendState)messageSendState {
    [super setMessageSendState:messageSendState];
    if (messageSendState == XYGIMNMessageSendStateSending) {
        if (!self.messageProgressView.superview) {
            [self.messageContentV addSubview:self.messageProgressView];
        }
        [self.messageProgressLabel setFrame:CGRectMake(0, self.messageImageView.bounds.size.height/2 - 8, self.messageImageView.bounds.size.width, 16)];
    }else {
        [self.messageProgressView removeFromSuperview];
    }
    
}
- (void)dismissProgress{
    [self.loadProgressView removeFromSuperview];
}
#pragma mark - Getters

- (UIImageView *)messageImageView {
    
    if (!_messageImageView) {
        _messageImageView = [[UIImageView alloc] init];
        _messageImageView.contentMode = UIViewContentModeScaleAspectFill;
    }
    return _messageImageView;
    
}

- (UIView *)messageProgressView {
    if (!_messageProgressView) {
        _messageProgressView = [[UIView alloc] init];
        _messageProgressView.backgroundColor = [UIColor colorWithRed:.0f green:.0f blue:.0f alpha:.3f];
        _messageProgressView.translatesAutoresizingMaskIntoConstraints = NO;
        _messageProgressView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
        UILabel *progressLabel = [[UILabel alloc] init];
        progressLabel.font = [UIFont systemFontOfSize:14.0f];
        progressLabel.textColor = [UIColor whiteColor];
        progressLabel.textAlignment = NSTextAlignmentCenter;
        progressLabel.text = @"50.0%";
        
        [_messageProgressView addSubview:self.messageProgressLabel = progressLabel];
    }
    return _messageProgressView;
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
