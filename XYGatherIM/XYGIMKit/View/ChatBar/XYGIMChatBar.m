//
//  XYGIMChatBar.m
//  XYGatherIM
//
//  Created by 杨卢银 on 2018/4/9.
//  Copyright © 2018年 杨卢银. All rights reserved.
//

#import "XYGIMChatBar.h"
#import "Mp3Recorder.h"
#import "XYGIMChatFaceView.h"
#import "XYGIMChatMoreView.h"
#import "Masonry.h"

#import <Photos/Photos.h>
#import <AssetsLibrary/AssetsLibrary.h>
#import <MobileCoreServices/MobileCoreServices.h>

#import "XYProgressHUD.h"
#import "XYGIMConfig.h"
#import "UIView+XYView.h"

@interface XYGIMChatBar ()<UITextViewDelegate,XYGIMChatFaceViewDelegate,XYGIMChatMoreViewDataSource,XYGIMChatMoreViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,Mp3RecorderDelegate>
{
    BOOL issinglechat;
}
@property (strong, nonatomic) Mp3Recorder *MP3;
@property (strong, nonatomic) UIButton *voiceButton; /**< 切换录音模式按钮 */
@property (strong, nonatomic) UIButton *voiceRecordButton; /**< 录音按钮 */

@property (strong, nonatomic) UIButton *faceButton; /**< 表情按钮 */
@property (strong, nonatomic) UIButton *moreButton; /**< 更多按钮 */

@property (strong, nonatomic) XYGIMChatFaceView *faceView; /**< 当前活跃的底部view,用来指向faceView */
@property (strong, nonatomic) XYGIMChatMoreView *moreView; /**< 当前活跃的底部view,用来指向moreView */

@property (strong, nonatomic) UITextView *textView;

@property (assign, nonatomic, readonly) CGFloat bottomHeight;
@property (assign, nonatomic) CGRect keyboardFrame;
@property (copy  , nonatomic) NSString *inputText;


@end

@implementation XYGIMChatBar

#pragma mark - Life Cycle
- (instancetype)initWithFrame:(CGRect)frame{
    if ([super initWithFrame:frame]) {
        [self setup];
    }
    return self;
}
-(void)awakeFromNib{
    [super awakeFromNib];
    [self setup];
    [self setSuperViewHeight:64];
}

-(instancetype)initWithFrame:(CGRect)frame rootVC:(UIViewController *)rootVC isSingleChat:(BOOL)issingle{
    if ([super initWithFrame:frame]) {
        [self setup];
        issinglechat = issingle;
        _rootViewController = rootVC;
        
    }
    return self;
}

-(void)layoutSubviews{
    XYLog(@"%@>>>>>",NSStringFromCGRect(self.superview.bounds));
}
- (void)updateConstraints{
    [super updateConstraints];
    
    [self.voiceButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).with.offset(10);
        make.top.equalTo(self.mas_top).with.offset(8);
        make.width.equalTo(self.voiceButton.mas_height);
    }];
    
    [self.moreButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.mas_right).with.offset(-10);
        make.top.equalTo(self.mas_top).with.offset(8);
        make.width.equalTo(self.moreButton.mas_height);
    }];
    
    [self.faceButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.moreButton.mas_left).with.offset(-10);
        make.top.equalTo(self.mas_top).with.offset(8);
        make.width.equalTo(self.faceButton.mas_height);
    }];
    
    [self.textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.voiceButton.mas_right).with.offset(10);
        make.right.equalTo(self.faceButton.mas_left).with.offset(-10);
        make.top.equalTo(self.mas_top).with.offset(4);
        make.bottom.equalTo(self.mas_bottom).with.offset(-4);
    }];
    
    [self.voiceRecordButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.voiceButton.mas_right).with.offset(10);
        make.right.equalTo(self.faceButton.mas_left).with.offset(-10);
        make.top.equalTo(self.mas_top).with.offset(4);
        make.bottom.equalTo(self.mas_bottom).with.offset(-4);
    }];
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillChangeFrameNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}
#pragma mark - UITextViewDelegate

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    
    if ([text isEqualToString:@"\n"]) {
        [self sendTextMessage:textView.text];
        return NO;
    }else if (text.length == 0){
        //判断删除的文字是否符合表情文字规则
        NSString *deleteText = [textView.text substringWithRange:range];
        if ([deleteText isEqualToString:@"]"]) {
            NSUInteger location = range.location;
            NSUInteger length = range.length;
            NSString *subText;
            while (YES) {
                if (location == 0) {
                    return YES;
                }
                location -- ;
                length ++ ;
                subText = [textView.text substringWithRange:NSMakeRange(location, length)];
                if (([subText hasPrefix:@"["] && [subText hasSuffix:@"]"])) {
                    break;
                }
            }
            textView.text = [textView.text stringByReplacingCharactersInRange:NSMakeRange(location, length) withString:@""];
            [textView setSelectedRange:NSMakeRange(location, 0)];
            [self textViewDidChange:self.textView];
            return NO;
        }
    }
    return YES;
}

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView{
    self.faceButton.selected = self.moreButton.selected = self.voiceButton.selected = NO;
    [self showFaceView:NO];
    [self showMoreView:NO];
    [self showVoiceView:NO];
    return YES;
}

- (void)textViewDidChange:(UITextView *)textView{
    
    CGRect textViewFrame = self.textView.frame;
    
    CGSize textSize = [self.textView sizeThatFits:CGSizeMake(CGRectGetWidth(textViewFrame), 1000.0f)];
    
    CGFloat offset = 10;
    textView.scrollEnabled = (textSize.height + 0.1 > kMaxHeight-offset);
    textViewFrame.size.height = MAX(34, MIN(kMaxHeight, textSize.height));
    
    CGRect addBarFrame = self.frame;
    addBarFrame.size.height = textViewFrame.size.height+offset;
    addBarFrame.origin.y = self.superViewHeight - self.bottomHeight - addBarFrame.size.height;
    [self setFrame:addBarFrame animated:NO];
    if (textView.scrollEnabled) {
        [textView scrollRangeToVisible:NSMakeRange(textView.text.length - 2, 1)];
    }
    
}

#pragma mark - UIImagePickerControllerDelegate

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    //    UIImage *image = info[UIImagePickerControllerOriginalImage];
    //    [self sendImageMessage:image];
    //    [self.rootViewController dismissViewControllerAnimated:YES completion:nil];
    
    NSString *mediaType = info[UIImagePickerControllerMediaType];
    if ([mediaType isEqualToString:(NSString *)kUTTypeMovie]) {
        NSURL *videoURL = info[UIImagePickerControllerMediaURL];
        // video url:
        // file:///private/var/mobile/Applications/B3CDD0B2-2F19-432B-9CFA-158700F4DE8F/tmp/capture-T0x16e39100.tmp.9R8weF/capturedvideo.mp4
        // we will convert it to mp4 format
        NSURL *mp4 = [self _convert2Mp4:videoURL];
        NSFileManager *fileman = [NSFileManager defaultManager];
        if ([fileman fileExistsAtPath:videoURL.path]) {
            NSError *error = nil;
            [fileman removeItemAtURL:videoURL error:&error];
            if (error) {
                XYLog(@"failed to remove file, error:%@.", error);
            }
        }
        [self sendVideoMessage:mp4];
        
    }else{
        
        NSURL *url = info[UIImagePickerControllerReferenceURL];
        if (url == nil) {
            UIImage *orgImage = info[UIImagePickerControllerOriginalImage];
            [self sendImageMessage:orgImage];
        } else {
            if ([[UIDevice currentDevice].systemVersion doubleValue] >= 9.0f) {
                PHFetchResult *result = [PHAsset fetchAssetsWithALAssetURLs:@[url] options:nil];
                [result enumerateObjectsUsingBlock:^(PHAsset *asset , NSUInteger idx, BOOL *stop){
                    if (asset) {
                        [[PHImageManager defaultManager] requestImageDataForAsset:asset options:nil resultHandler:^(NSData *data, NSString *uti, UIImageOrientation orientation, NSDictionary *dic){
                            if (data.length > 10 * 1000 * 1000) {
                                //[self showHint:@"图片太大了，换个小点的"];
                                XYLog(@"图片太大了，换个小点的");
                                return;
                            }
                            if (data != nil) {
                                [self sendImageMessageWithData:data];
                            } else {
                                XYLog(@"图片太大了，换个小点的");
                            }
                        }];
                    }
                }];
            } else {
                ALAssetsLibrary *alasset = [[ALAssetsLibrary alloc] init];
                [alasset assetForURL:url resultBlock:^(ALAsset *asset) {
                    if (asset) {
                        ALAssetRepresentation* assetRepresentation = [asset defaultRepresentation];
                        Byte* buffer = (Byte*)malloc([assetRepresentation size]);
                        NSUInteger bufferSize = [assetRepresentation getBytes:buffer fromOffset:0.0 length:[assetRepresentation size] error:nil];
                        NSData* fileData = [NSData dataWithBytesNoCopy:buffer length:bufferSize freeWhenDone:YES];
                        if (fileData.length > 10 * 1000 * 1000) {
                            //                            [self showHint:@"图片太大了，换个小点的"];
                            XYLog(@"图片太大了，换个小点的");
                            return;
                        }
                        [self sendImageMessageWithData:fileData];
                    }
                } failureBlock:NULL];
            }
        }
    }
    
    [picker dismissViewControllerAnimated:YES completion:nil];
    
    //    [[EaseSDKHelper shareHelper] setIsShowingimagePicker:NO];
    
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [self.rootViewController dismissViewControllerAnimated:YES completion:nil];
}

//-(void)lf_imagePickerController:(LFImagePickerController *)picker didFinishPickingAssets:(NSArray *)assets infos:(NSArray<NSDictionary *> *)infos{
//    XYLog(@"assets");
//}
//-(void)lf_imagePickerController:(LFImagePickerController *)picker didFinishPickingThumbnailImages:(NSArray<UIImage *> *)thumbnailImages originalImages:(NSArray<UIImage *> *)originalImages{
//    XYLog(@"images");
//}

- (NSURL *)_convert2Mp4:(NSURL *)movUrl
{
    NSURL *mp4Url = nil;
    AVURLAsset *avAsset = [AVURLAsset URLAssetWithURL:movUrl options:nil];
    NSArray *compatiblePresets = [AVAssetExportSession exportPresetsCompatibleWithAsset:avAsset];
    
    if ([compatiblePresets containsObject:AVAssetExportPresetHighestQuality]) {
        AVAssetExportSession *exportSession = [[AVAssetExportSession alloc]initWithAsset:avAsset
                                                                              presetName:AVAssetExportPresetHighestQuality];
        NSString *mp4Path =@""; //[NSString stringWithFormat:@"%@/%d%d.mp4", [EMCDDeviceManager dataPath], (int)[[NSDate date] timeIntervalSince1970], arc4random() % 100000];
        mp4Url = [NSURL fileURLWithPath:mp4Path];
        exportSession.outputURL = mp4Url;
        exportSession.shouldOptimizeForNetworkUse = YES;
        exportSession.outputFileType = AVFileTypeMPEG4;
        dispatch_semaphore_t wait = dispatch_semaphore_create(0l);
        [exportSession exportAsynchronouslyWithCompletionHandler:^{
            switch ([exportSession status]) {
                case AVAssetExportSessionStatusFailed: {
                    XYLog(@"failed, error:%@.", exportSession.error);
                } break;
                case AVAssetExportSessionStatusCancelled: {
                    XYLog(@"cancelled.");
                } break;
                case AVAssetExportSessionStatusCompleted: {
                    XYLog(@"completed.");
                } break;
                default: {
                    XYLog(@"others.");
                } break;
            }
            dispatch_semaphore_signal(wait);
        }];
        long timeout = dispatch_semaphore_wait(wait, DISPATCH_TIME_FOREVER);
        if (timeout) {
            XYLog(@"timeout.");
        }
        if (wait) {
            //dispatch_release(wait);
            wait = nil;
        }
    }
    
    return mp4Url;
}

#pragma mark - XMLocationControllerDelegate

- (void)cancelLocation{
    [self.rootViewController dismissViewControllerAnimated:YES completion:nil];
}

- (void)sendLocation:(CLPlacemark *)placemark{
    [self cancelLocation];
    if (self.delegate && [self.delegate respondsToSelector:@selector(chatBar:sendLocation:locationText:)]) {
        [self.delegate chatBar:self sendLocation:placemark.location.coordinate locationText:placemark.name];
    }
}
#pragma mark FUChatLuckyMoneyControllerDelegate
//-(void)chatLuckyMoneyController:(FUChatLuckyMoneyController *)luckyMoneyVC isSuccess:(BOOL)isSuccess sendRedBag:(FUPRedBag *)redBag{
//    if (isSuccess) {
//        [luckyMoneyVC dismissViewControllerAnimated:YES completion:^{
//
//        }];
//        if (self.delegate && [self.delegate respondsToSelector:@selector(chatBar:sendUserRedBag:)]) {
//            [self.delegate chatBar:self sendUserRedBag:redBag];
//        }
//    }else{
//        FUHUDHint(@"发送红包失败");
//        FUHUDError(@"发送红包失败");
//    }
//}

#pragma mark - MP3RecordedDelegate

- (void)endConvertWithMP3FileName:(NSString *)fileName {
    if (fileName) {
        [XYProgressHUD dismissWithProgressState:XYProgressSuccess];
        [self sendVoiceMessage:fileName seconds:[XYProgressHUD seconds]];
    }else{
        [XYProgressHUD dismissWithProgressState:XYProgressError];
    }
}

- (void)failRecord{
    [XYProgressHUD dismissWithProgressState:XYProgressError];
}

- (void)beginConvert{
    XYLog(@"开始转换");
    [XYProgressHUD changeSubTitle:@"正在转换..."];
}

#pragma mark - XMChatMoreViewDelegate & XMChatMoreViewDataSource

- (void)moreView:(XYGIMChatMoreView *)moreView selectIndex:(XYGIMChatMoreItemType)itemType{
    switch (itemType) {
        case XYGIMChatMoreItemAlbum:
        {
            
            //显示拍照
            if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:@"您的设备不支持拍照" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
                [alertView show];
                break;
            }
            
            UIImagePickerController *pickerC = [[UIImagePickerController alloc] init];
            pickerC.sourceType = UIImagePickerControllerSourceTypeCamera;
            pickerC.delegate = self;
            [self.rootViewController presentViewController:pickerC animated:YES completion:nil];
            
            
            
        }
            break;
        case XYGIMChatMoreItemCamera:
        {
            //显示相册
            
            UIImagePickerController *pickerC = [[UIImagePickerController alloc] init];
            pickerC.delegate = self;
            [self.rootViewController presentViewController:pickerC animated:YES completion:nil];
            
            //            LFImagePickerController *imagePicker = [[LFImagePickerController alloc] initWithMaxImagesCount:9 delegate:self];
            //            //imagePicker.naviBgColor = [UIColor fu_topMenuColor];
            //
            //            //    imagePicker.allowTakePicture = NO;
            //            //    imagePicker.sortAscendingByCreateDate = NO;
            //            imagePicker.doneBtnTitleStr = @"确定";
            //            //    imagePicker.allowEditting = NO;
            //            imagePicker.supportAutorotate = YES; /** 适配横屏 */
            //            //    imagePicker.imageCompressSize = 200; /** 标清图压缩大小 */
            //            //    imagePicker.thumbnailCompressSize = 20; /** 缩略图压缩大小 */
            //            imagePicker.allowPickingGif = YES; /** 支持GIF */
            //            [self.rootViewController presentViewController:imagePicker animated:YES completion:nil];
            
        }
            break;
        case XYGIMChatMoreItemLocation:
            
            break;
        case XYGIMChatMoreItemLuckyMoney:
            
            break;
        case XYGIMChatMoreItemVideo:{
            
            if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:@"您的设备不支持拍照" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
                [alertView show];
                break;
            }
            UIImagePickerController *pickerC = [[UIImagePickerController alloc] init];
            pickerC.sourceType = UIImagePickerControllerSourceTypeCamera;
            pickerC.mediaTypes = @[(NSString *)kUTTypeMovie];
            pickerC.delegate = self;
            [self.rootViewController presentViewController:pickerC animated:YES completion:nil];
        }
            
            break;
        case XYGIMChatMoreItemCallVideo:{
            if (self.delegate && [self.delegate respondsToSelector:@selector(chatBar:sendCall:isCaller:)]) {
                [self.delegate chatBar:self sendCall:@"" isCaller:YES];
            }
        }
            break;
        case XYGIMChatMoreItemCallAudio:{
            if (self.delegate && [self.delegate respondsToSelector:@selector(chatBar:sendCall:isCaller:)]) {
                [self.delegate chatBar:self sendCall:@"" isCaller:NO];
            }
        }
            break;
        case XYGIMChatMoreItemFamilyTreeShare:
            
            break;
        case XYGIMChatMoreItemFamilyTreeInvitation:
            
            break;
        case XYGIMChatMoreItemAudio:
            
            break;
            
            
        default:
            break;
    }
    
}

- (NSArray *)titlesOfMoreView:(XYGIMChatMoreView *)moreView{
    if (!issinglechat) {
        return @[@"照片",@"拍照",@"位置",@"视频"];
    }
    return @[@"照片",@"拍照",@"视频",@"位置",@"语音通话",@"视频通话"];
}

- (NSArray *)imageNamesOfMoreView:(XYGIMChatMoreView *)moreView{
    if (!issinglechat) {
        return @[@"chat_bottom_img",@"chat_bottom_camera",@"chat_bottom_location",@"chat_bottom_video"];
    }
    
    return @[@"sharemore_pic",@"sharemore_video",@"sharemore_videovoip",@"sharemore_location",@"sharemore_voipvoice",@"sharemore_multitalk"];
}

#pragma mark - XMChatFaceViewDelegate

- (void)faceViewSendFace:(NSString *)faceName{
    if ([faceName isEqualToString:@"[删除]"]) {
        [self textView:self.textView shouldChangeTextInRange:NSMakeRange(self.textView.text.length - 1, 1) replacementText:@""];
    }else if ([faceName isEqualToString:@"发送"]){
        NSString *text = self.textView.text;
        if (!text || text.length == 0) {
            return;
        }
        if (self.delegate && [self.delegate respondsToSelector:@selector(chatBar:sendMessage:)]) {
            [self.delegate chatBar:self sendMessage:text];
        }
        self.inputText = @"";
        self.textView.text = @"";
        [self setFrame:CGRectMake(0, self.superViewHeight - self.bottomHeight - kMinHeight, self.frame.size.width, kMinHeight) animated:NO];
        [self showViewWithType:XYGIMFunctionViewShowFace];
    }else{
        self.textView.text = [self.textView.text stringByAppendingString:faceName];
        [self textViewDidChange:self.textView];
    }
}

#pragma mark - Public Methods

- (void)endInputing{
    [self showViewWithType:XYGIMFunctionViewShowNothing];
}

#pragma mark - Private Methods

- (void)keyboardWillHide:(NSNotification *)notification{
    self.keyboardFrame = CGRectZero;
    [self textViewDidChange:self.textView];
}

- (void)keyboardFrameWillChange:(NSNotification *)notification{
    self.keyboardFrame = [notification.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    [self textViewDidChange:self.textView];
}

- (void)setup{
    
    self.MP3 = [[Mp3Recorder alloc] initWithDelegate:self];
    [self addSubview:self.voiceButton];
    [self addSubview:self.moreButton];
    [self addSubview:self.faceButton];
    [self addSubview:self.textView];
    self.voiceRecordButton.frame = self.textView.bounds;
    //[self.textView addSubview:self.voiceRecordButton];
    [self addSubview:self.voiceRecordButton];
    
    UIImageView *topLine = [[UIImageView alloc] init];
    topLine.backgroundColor = [UIColor colorWithRed:184/255.0f green:184/255.0f blue:184/255.0f alpha:1.0f];
    [self addSubview:topLine];
    
    [topLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left);
        make.right.equalTo(self.mas_right);
        make.top.equalTo(self.mas_top);
        make.height.mas_equalTo(@.5f);
    }];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardFrameWillChange:) name:UIKeyboardWillChangeFrameNotification object:nil];
    
    self.backgroundColor = [UIColor colorWithRed:235/255.0f green:236/255.0f blue:238/255.0f alpha:1.0f];
    [self updateConstraintsIfNeeded];
    
    //FIX 修复首次初始化页面 页面显示不正确 textView不显示bug
    [self layoutIfNeeded];
}
//- (void)recordVoiceButtonAction:(id)sender forEvent:(UIEvent *)event{
//    UITouchPhase phase = event.allTouches.anyObject.phase;
//    XYLog(@"%ld",phase);
//    if (phase == UITouchPhaseBegan) {
//        XYLog(@"开始录音");
//    }
//    else if(phase == UITouchPhaseEnded){
//        XYLog(@"录音结束");
//    }
//}
/**
 *  开始录音
 */
- (void)startRecordVoice{
    [XYProgressHUD show];
    [self.MP3 startRecord];
}

/**
 *  取消录音
 */
- (void)cancelRecordVoice{
    XYLog(@"取消录音");
    [XYProgressHUD dismissWithMessage:@"取消录音"];
    [self.MP3 cancelRecord];
}

/**
 *  录音结束
 */
- (void)confirmRecordVoice{
    XYLog(@"录音结束");
    [self.MP3 stopRecord];
}

/**
 *  更新录音显示状态,手指向上滑动后提示松开取消录音
 */
- (void)updateCancelRecordVoice{
    [XYProgressHUD changeSubTitle:@"松开取消录音"];
}

/**
 *  更新录音状态,手指重新滑动到范围内,提示向上取消录音
 */
- (void)updateContinueRecordVoice{
    [XYProgressHUD changeSubTitle:@"向上滑动取消录音"];
}


- (void)showViewWithType:(XYGIMFunctionViewShowType)showType{
    
    //显示对应的View
    [self showMoreView:showType == XYGIMFunctionViewShowMore && self.moreButton.selected];
    [self showVoiceView:showType == XYGIMFunctionViewShowVoice && self.voiceButton.selected];
    [self showFaceView:showType == XYGIMFunctionViewShowFace && self.faceButton.selected];
    
    switch (showType) {
        case XYGIMFunctionViewShowNothing:
        case XYGIMFunctionViewShowVoice:
        {
            self.inputText = self.textView.text;
            self.textView.text = nil;
            [self setFrame:CGRectMake(0, self.superViewHeight - kMinHeight, self.frame.size.width, kMinHeight) animated:NO];
            [self.textView resignFirstResponder];
        }
            break;
        case XYGIMFunctionViewShowMore:
            
        case XYGIMFunctionViewShowFace:
            self.inputText = self.textView.text;
            [self setFrame:CGRectMake(0, self.superViewHeight - kFunctionViewHeight - self.textView.frame.size.height - 10, self.frame.size.width, self.textView.frame.size.height + 10) animated:NO];
            [self.textView resignFirstResponder];
            [self textViewDidChange:self.textView];
            break;
        case XYGIMFunctionViewShowKeyboard:
            self.textView.text = self.inputText;
            [self textViewDidChange:self.textView];
            self.inputText = nil;
            break;
        default:
            break;
    }
    
}

- (void)buttonAction:(UIButton *)button{
    
    self.inputText = self.textView.text;
    XYGIMFunctionViewShowType showType = button.tag;
    
    //更改对应按钮的状态
    if (button == self.faceButton) {
        [self.faceButton setSelected:!self.faceButton.selected];
        [self.moreButton setSelected:NO];
        [self.voiceButton setSelected:NO];
    }else if (button == self.moreButton){
        [self.faceButton setSelected:NO];
        [self.moreButton setSelected:!self.moreButton.selected];
        [self.voiceButton setSelected:NO];
    }else if (button == self.voiceButton){
        [self.faceButton setSelected:NO];
        [self.moreButton setSelected:NO];
        [self.voiceButton setSelected:!self.voiceButton.selected];
    }
    
    if (!button.selected) {
        showType = XYGIMFunctionViewShowKeyboard;
        [self.textView becomeFirstResponder];
    }else{
        self.inputText = self.textView.text;
    }
    
    [self showViewWithType:showType];
}
-(CGFloat)superViewHeight{
    float height  = [UIScreen mainScreen].bounds.size.height - (self.rootViewController.navigationController.navigationBar.isTranslucent ? 0 : 64);
    if(IsPad){
        //        height = height - 64;
        return _superViewHeight;
    }
    return height;
}
- (void)showFaceView:(BOOL)show{
    if (show) {
        
        [self.superview addSubview:self.faceView];
        [UIView animateWithDuration:.3 animations:^{
            [self.faceView setFrame:CGRectMake(0, self.superViewHeight - kFunctionViewHeight, self.frame.size.width, kFunctionViewHeight)];
            if (IsPad) {
                [self.faceView setFrame:CGRectMake(0, self.superViewHeight - kFunctionViewHeight - 49, self.frame.size.width, kFunctionViewHeight)];
            }
        } completion:nil];
    }else{
        [UIView animateWithDuration:.3 animations:^{
            [self.faceView setFrame:CGRectMake(0, self.superViewHeight, self.frame.size.width, kFunctionViewHeight)];
            if (IsPad) {
                [self.faceView setFrame:CGRectMake(0, self.superViewHeight + 49, self.frame.size.width, kFunctionViewHeight)];
            }
        } completion:^(BOOL finished) {
            [self.faceView removeFromSuperview];
        }];
    }
}

/**
 *  显示moreView
 *  @param show 要显示的moreView
 */
- (void)showMoreView:(BOOL)show{
    if (show) {
        [self.superview addSubview:self.moreView];
        
        
        [UIView animateWithDuration:.3 animations:^{
            
            [self.moreView setFrame:CGRectMake(0, self.superViewHeight - kFunctionViewHeight, self.frame.size.width, kFunctionViewHeight)];
            if (IsPad) {
                [self.moreView setFrame:CGRectMake(0, self.superViewHeight - kFunctionViewHeight - 49, self.frame.size.width, kFunctionViewHeight)];
            }
        } completion:nil];
        
    }else{
        [UIView animateWithDuration:.3 animations:^{
            [self.moreView setFrame:CGRectMake(0, self.superViewHeight, self.frame.size.width, kFunctionViewHeight)];
            if (IsPad) {
                [self.moreView setFrame:CGRectMake(0, self.superViewHeight + 49, self.frame.size.width, kFunctionViewHeight)];
            }
        } completion:^(BOOL finished) {
            [self.moreView removeFromSuperview];
        }];
    }
}

- (void)showVoiceView:(BOOL)show{
    self.voiceButton.selected = show;
    self.voiceRecordButton.selected = show;
    self.voiceRecordButton.hidden = !show;
}


/**
 *  发送普通的文本信息,通知代理
 *
 *  @param text 发送的文本信息
 */
- (void)sendTextMessage:(NSString *)text{
    if (!text || text.length == 0) {
        return;
    }
    if (self.delegate && [self.delegate respondsToSelector:@selector(chatBar:sendMessage:)]) {
        [self.delegate chatBar:self sendMessage:text];
    }
    self.inputText = @"";
    self.textView.text = @"";
    [self setFrame:CGRectMake(0, self.superViewHeight - self.bottomHeight - kMinHeight, self.frame.size.width, kMinHeight) animated:NO];
    [self showViewWithType:XYGIMFunctionViewShowKeyboard];
}

/**
 *  通知代理发送语音信息
 *
 *  @param voiceData 发送的语音信息data
 *  @param seconds   语音时长
 */
- (void)sendVoiceMessage:(NSString *)voiceFileName seconds:(NSTimeInterval)seconds{
    if (self.delegate && [self.delegate respondsToSelector:@selector(chatBar:sendVoice:seconds:)]) {
        [self.delegate chatBar:self sendVoice:voiceFileName seconds:seconds];
    }
}

/**
 *  通知代理发送图片信息
 *
 *  @param image 发送的图片
 */
- (void)sendVideoMessage:(NSURL *)video_url{
    if (self.delegate && [self.delegate respondsToSelector:@selector(chatBar:sendVideo:)]) {
        [self.delegate chatBar:self sendVideo:video_url];
    }
}
/**
 *  通知代理发送图片信息
 *
 *  @param image 发送的图片
 */
- (void)sendImageMessage:(UIImage *)image{
    if (self.delegate && [self.delegate respondsToSelector:@selector(chatBar:sendPictures:)]) {
        [self.delegate chatBar:self sendPictures:@[image]];
    }
}
- (void)sendImageMessageWithData:(NSData *)image{
    if (self.delegate && [self.delegate respondsToSelector:@selector(chatBar:sendImageDatas:)]) {
        [self.delegate chatBar:self sendImageDatas:@[image]];
    }
}

#pragma mark - Getters

- (XYGIMChatFaceView *)faceView{
    if (!_faceView) {
        _faceView = [[XYGIMChatFaceView alloc] initWithFrame:CGRectMake(0, self.superViewHeight , self.frame.size.width, kFunctionViewHeight)];
        _faceView.delegate = self;
        _faceView.backgroundColor = self.backgroundColor;
    }
    return _faceView;
}

- (XYGIMChatMoreView *)moreView{
    if (!_moreView) {
        _moreView = [[XYGIMChatMoreView alloc] initWithFrame:CGRectMake(0, self.superViewHeight, self.frame.size.width, kFunctionViewHeight)];
        _moreView.delegate = self;
        _moreView.dataSource = self;
        _moreView.backgroundColor = self.backgroundColor;
    }
    return _moreView;
}

- (UITextView *)textView{
    if (!_textView) {
        _textView = [[UITextView alloc] init];
        _textView.font = [UIFont systemFontOfSize:16.0f];
        _textView.delegate = self;
        _textView.layer.cornerRadius = 4.0f;
        _textView.layer.borderColor = [UIColor colorWithRed:204.0/255.0f green:204.0/255.0f blue:204.0/255.0f alpha:1.0f].CGColor;
        _textView.returnKeyType = UIReturnKeySend;
        _textView.layer.borderWidth = .5f;
        _textView.layer.masksToBounds = YES;
    }
    return _textView;
}

- (UIButton *)voiceButton{
    if (!_voiceButton) {
        _voiceButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _voiceButton.tag = XYGIMFunctionViewShowVoice;
        [_voiceButton setBackgroundImage:[UIImage imageNamed:@"tool_voice_1"] forState:UIControlStateNormal];
        [_voiceButton setBackgroundImage:[UIImage imageNamed:@"tool_keyboard_1"] forState:UIControlStateSelected];
        [_voiceButton addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        [_voiceButton sizeToFit];
    }
    return _voiceButton;
}

- (UIButton *)voiceRecordButton{
    if (!_voiceRecordButton) {
        _voiceRecordButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _voiceRecordButton.hidden = YES;
        _voiceRecordButton.frame = self.textView.bounds;
        //_voiceRecordButton.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        [_voiceRecordButton setBackgroundColor:[UIColor lightGrayColor]];
        _voiceRecordButton.titleLabel.font = [UIFont systemFontOfSize:14.0f];
        [_voiceRecordButton setTitle:@"按住录音" forState:UIControlStateNormal];
        //[_voiceRecordButton addTarget:self action:@selector(recordVoiceButtonAction:forEvent:) forControlEvents:UIControlEventAllEvents];
        _voiceRecordButton.layer.cornerRadius = 5.0f;
        
        // 手指按下
        [_voiceRecordButton addTarget:self action:@selector(startRecordVoice) forControlEvents:UIControlEventTouchDown];
        //所有在控件之外触摸抬起事件(点触必须开始与控件内部才会发送通知)。
        //[_voiceRecordButton addTarget:self action:@selector(cancelRecordVoice) forControlEvents:UIControlEventTouchUpOutside];
        // 松开手指
        [_voiceRecordButton addTarget:self action:@selector(confirmRecordVoice) forControlEvents:UIControlEventTouchUpInside];
        //当一次触摸从控件窗口内部拖动到外部时。
        [_voiceRecordButton addTarget:self action:@selector(updateCancelRecordVoice) forControlEvents:UIControlEventTouchDragExit];
        //当一次触摸从控件窗口之外拖动到内部时。
        [_voiceRecordButton addTarget:self action:@selector(updateContinueRecordVoice) forControlEvents:UIControlEventTouchDragEnter];
        
    }
    return _voiceRecordButton;
}

- (UIButton *)moreButton{
    if (!_moreButton) {
        _moreButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _moreButton.tag = XYGIMFunctionViewShowMore;
        [_moreButton setBackgroundImage:[UIImage imageNamed:@"tool_share_1"] forState:UIControlStateNormal];
        [_moreButton setBackgroundImage:[UIImage imageNamed:@"tool_keyboard_1"] forState:UIControlStateSelected];
        [_moreButton addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        [_moreButton sizeToFit];
    }
    return _moreButton;
}

- (UIButton *)faceButton{
    if (!_faceButton) {
        _faceButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _faceButton.tag = XYGIMFunctionViewShowFace;
        [_faceButton setBackgroundImage:[UIImage imageNamed:@"tool_emotion_1"] forState:UIControlStateNormal];
        [_faceButton setBackgroundImage:[UIImage imageNamed:@"tool_keyboard_1"] forState:UIControlStateSelected];
        [_faceButton addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        [_faceButton sizeToFit];
    }
    return _faceButton;
}

- (CGFloat)bottomHeight{
    
    if (self.faceView.superview || self.moreView.superview) {
        return MAX(self.keyboardFrame.size.height, MAX(self.faceView.frame.size.height, self.moreView.frame.size.height));
    }else{
        return MAX(self.keyboardFrame.size.height, CGFLOAT_MIN);
    }
    
}

- (UIViewController *)rootViewController{
    if (_rootViewController) {
        return _rootViewController;
    }
    UIViewController *rootvc = [[UIApplication sharedApplication] keyWindow].rootViewController;
    
    rootvc = [[UIApplication sharedApplication].delegate window].rootViewController;
    
    return rootvc;
}

#pragma mark - Getters
-(void)reloadView:(CGRect)rect{
    self.frame = rect;
    
    _superViewHeight = rect.origin.y + rect.size.height +49;
    
    [UIView animateWithDuration:0.3 animations:^{
        self.faceView.frame = CGRectMake(0, self.superViewHeight-kFunctionViewHeight, rect.size.width, kFunctionViewHeight);
        [self.faceView reloadView];
        self.moreView.frame = CGRectMake(0, self.superViewHeight-kFunctionViewHeight, rect.size.width, kFunctionViewHeight);
        [self.moreView reloadView];
        if (_faceButton.selected || _moreButton.selected) {
            self.y = _faceView.y - self.height;
        }
    } completion:nil];
}
-(void)dismissView{
    
}

- (void)setFrame:(CGRect)frame animated:(BOOL)animated{
    //XYLog(@"CHAT-----------%@-->%@",NSStringFromCGRect(frame),@(animated));
    if (animated) {
        [UIView animateWithDuration:.3 animations:^{
            CGRect rect = frame;
            
            //XYLog(@"%@",NSStringFromCGRect(rect));
            [self setFrame:rect];
        }];
    }else{
        CGRect rect = frame;
        if (IsPad) {
            if (_voiceButton.selected == YES || _faceButton.selected == YES || _moreButton.selected == YES) {
                rect.origin.y -= 49.0;
            }
        }
        [self setFrame:rect];
    }
    if (self.delegate && [self.delegate respondsToSelector:@selector(chatBarFrameDidChange:frame:)]) {
        [self.delegate chatBarFrameDidChange:self frame:frame];
    }
}
-(void)setnavColor:(UIColor*)color{
    UIImage *image;
    if (color!=nil) {
        image = [self fu_createImageWithColor:color];
    }else{
        image = [[UIImage alloc] init];
    }
    [[UINavigationBar appearance] setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
    [[UINavigationBar appearance] setShadowImage:image];
}
-(UIImage*) fu_createImageWithColor: (UIColor*) color
{
    CGRect rect=CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}
@end
