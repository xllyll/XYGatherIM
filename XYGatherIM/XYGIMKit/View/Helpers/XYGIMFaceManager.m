//
//  XMXYGIMFaceManager.m
//  XMChatBarExample
//
//  Created by shscce on 15/8/25.
//  Copyright (c) 2015年 xmfraker. All rights reserved.
//

#import "XYGIMFaceManager.h"

@interface XYGIMFaceManager ()

@property (nonatomic) NSBundle *emotionBundle;

@property (strong, nonatomic) NSMutableArray *emojiFaceArrays;

@property (strong, nonatomic) NSMutableArray *recentFaceArrays;

@property (strong, nonatomic) NSMutableDictionary *gifFaceDictionary;

@end

@implementation XYGIMFaceManager

- (instancetype)init{
    if (self = [super init]) {
        
        NSString *path = [[NSBundle mainBundle] pathForResource:@"Emotion" ofType:@"bundle"];
        self.emotionBundle = [NSBundle bundleWithPath:path];
        
        _emojiFaceArrays = [NSMutableArray array];
        
        
        NSArray *faceArray = [NSArray arrayWithContentsOfFile:[XYGIMFaceManager defaultEmojiFacePath]];
        
        
        [_emojiFaceArrays addObjectsFromArray:[faceArray firstObject][@"items"]];

        NSArray *recentArrays = [[NSUserDefaults standardUserDefaults] arrayForKey:@"recentFaceArrays"];
        if (recentArrays) {
            _recentFaceArrays = [NSMutableArray arrayWithArray:recentArrays];
        }else{
            _recentFaceArrays = [NSMutableArray array];
        }
        
        
        _gifFaceDictionary = [[NSMutableDictionary alloc] initWithDictionary:[self emotionFormessageViewController]];
        
    }
    return self;
}


#pragma mark - Class Methods

+ (instancetype)shareInstance{
    static dispatch_once_t onceToken;
    static id shareInstance;
    dispatch_once(&onceToken, ^{
        shareInstance = [[self alloc] init];
    });
    return shareInstance;
}

+ (UIImage *)imageForEmotionPNGName:(NSString *)pngName {
    return [UIImage imageNamed:pngName inBundle:[XYGIMFaceManager shareInstance].emotionBundle
 compatibleWithTraitCollection:nil];
}
#pragma mark - Emoji相关表情处理方法

+ (NSArray *)emojiFaces{
    
    return [[XYGIMFaceManager shareInstance] emojiFaceArrays];

}


+ (NSString *)defaultEmojiFacePath{
    return [[NSBundle mainBundle] pathForResource:@"Emotions" ofType:@"plist"];
}

+ (NSString *)faceImageNameWithFaceID:(NSUInteger)faceID{
    if (faceID == 999) {
        return @"[删除]";
    }
    for (NSDictionary *faceDict in [[XYGIMFaceManager shareInstance] emojiFaceArrays]) {
        if ([faceDict[kFaceIDKey] integerValue] == faceID) {
            return [NSString stringWithFormat:@"%@",faceDict[kFaceImageNameKey]];
        }
    }
    return @"";
}

+ (NSString *)faceNameWithFaceID:(NSUInteger)faceID{
    if (faceID == 999) {
        return @"[删除]";
    }
    for (NSDictionary *faceDict in [[XYGIMFaceManager shareInstance] emojiFaceArrays]) {
        if ([faceDict[kFaceIDKey] integerValue] == faceID) {
            return faceDict[kFaceNameKey];
        }
    }
    return @"";
}


+ (NSMutableAttributedString *)emotionStrWithString:(NSString *)text
{
    //1、创建一个可变的属性字符串
    NSMutableAttributedString *attributeString = [[NSMutableAttributedString alloc] initWithString:text];
    //2、通过正则表达式来匹配字符串
    NSString *regex_emoji = @"\\[[a-zA-Z0-9\\/\\u4e00-\\u9fa5]+\\]"; //匹配表情
    
    NSError *error = nil;
    NSRegularExpression *re = [NSRegularExpression regularExpressionWithPattern:regex_emoji options:NSRegularExpressionCaseInsensitive error:&error];
    if (!re) {
        NSLog(@"%@", [error localizedDescription]);
        return attributeString;
    }
    
    NSArray *resultArray = [re matchesInString:text options:0 range:NSMakeRange(0, text.length)];
    //3、获取所有的表情以及位置
    //用来存放字典，字典中存储的是图片和图片对应的位置
    NSMutableArray *imageArray = [NSMutableArray arrayWithCapacity:resultArray.count];
    //根据匹配范围来用图片进行相应的替换
    for(NSTextCheckingResult *match in resultArray) {
        //获取数组元素中得到range
        NSRange range = [match range];
        //获取原字符串中对应的值
        NSString *subStr = [text substringWithRange:range];
        
        for (NSDictionary *dict in [[XYGIMFaceManager shareInstance] emojiFaceArrays]) {
            if ([dict[kFaceNameKey]  isEqualToString:subStr]) {
                //face[i][@"png"]就是我们要加载的图片
                //新建文字附件来存放我们的图片,iOS7才新加的对象
                NSTextAttachment *textAttachment = [[NSTextAttachment alloc] init];
                //给附件添加图片
                textAttachment.image = [self imageForEmotionPNGName:dict[kFaceImageNameKey]];
                //textAttachment.image = [UIImage imageNamed:dict[kFaceImageNameKey]];
                //调整一下图片的位置,如果你的图片偏上或者偏下，调整一下bounds的y值即可
                textAttachment.bounds = CGRectMake(0, -8, textAttachment.image.size.width, textAttachment.image.size.height);
                //把附件转换成可变字符串，用于替换掉源字符串中的表情文字
                NSAttributedString *imageStr = [NSAttributedString attributedStringWithAttachment:textAttachment];
                //把图片和图片对应的位置存入字典中
                NSMutableDictionary *imageDic = [NSMutableDictionary dictionaryWithCapacity:2];
                [imageDic setObject:imageStr forKey:@"image"];
                [imageDic setObject:[NSValue valueWithRange:range] forKey:@"range"];
                //把字典存入数组中
                [imageArray addObject:imageDic];
                break;
            }
        }
    }
    
    //4、从后往前替换，否则会引起位置问题
    for (int i = (int)imageArray.count -1; i >= 0; i--) {
        NSRange range;
        [imageArray[i][@"range"] getValue:&range];
        //进行替换
        [attributeString replaceCharactersInRange:range withAttributedString:imageArray[i][@"image"]];
    }
    return attributeString;
}



#pragma mark - 最近使用表情相关方法
/**
 *  获取最近使用的表情图片
 *
 *  @return
 */
+ (NSArray *)recentFaces{
    return [[XYGIMFaceManager shareInstance] recentFaceArrays];
}


+ (BOOL)saveRecentFace:(NSDictionary *)recentDict{
    for (NSDictionary *dict in [[XYGIMFaceManager shareInstance] recentFaceArrays]) {
        if ([dict[@"face_id"] integerValue] == [recentDict[@"face_id"] integerValue]) {
            NSLog(@"已经存在");
            return NO;
        }
    }
    [[[XYGIMFaceManager shareInstance] recentFaceArrays] insertObject:recentDict atIndex:0];
    if ([[XYGIMFaceManager shareInstance] recentFaceArrays].count > 8) {
        [[[XYGIMFaceManager shareInstance] recentFaceArrays] removeLastObject];
    }
    [[NSUserDefaults standardUserDefaults] setObject:[[XYGIMFaceManager shareInstance] recentFaceArrays] forKey:@"recentFaceArrays"];
    return YES;
}
#pragma mark ---
+(NSDictionary *)getGifImageEmojiFaces{
    return [[XYGIMFaceManager shareInstance] gifFaceDictionary];
}
+(XYGIMEmotion *)getGifEmotionById:(NSString *)eid{
    return [[XYGIMFaceManager shareInstance] gifFaceDictionary][eid];
}
- (NSDictionary*)emotionFormessageViewController
{
//    NSMutableArray *emotions = [NSMutableArray array];
//    for (NSString *name in [EaseEmoji allEmoji]) {
//        EaseEmotion *emotion = [[EaseEmotion alloc] initWithName:@"" emotionId:name emotionThumbnail:name emotionOriginal:name emotionOriginalURL:@"" emotionType:EMEmotionDefault];
//        [emotions addObject:emotion];
//    }
//    EaseEmotion *temp = [emotions objectAtIndex:0];
//    EaseEmotionManager *managerDefault = [[EaseEmotionManager alloc] initWithType:EMEmotionDefault emotionRow:3 emotionCol:7 emotions:emotions tagImage:[UIImage imageNamed:temp.emotionId]];
    
    NSMutableArray *emotionGifs = [NSMutableArray array];
    NSMutableDictionary *_emotionDic = [NSMutableDictionary dictionary];
    NSArray *names = @[@"icon_002",@"icon_007",@"icon_010",@"icon_012",@"icon_013",@"icon_018",@"icon_019",@"icon_020",@"icon_021",@"icon_022",@"icon_024",@"icon_027",@"icon_029",@"icon_030",@"icon_035",@"icon_040"];
    int index = 0;
    for (NSString *name in names) {
        index++;
        XYGIMEmotion *emotion = [[XYGIMEmotion alloc] initWithName:[NSString stringWithFormat:@"[示例%d]",index] emotionId:[NSString stringWithFormat:@"em%d",(1000 + index)] emotionThumbnail:[NSString stringWithFormat:@"%@_cover",name] emotionOriginal:[NSString stringWithFormat:@"%@",name] emotionOriginalURL:@"" emotionType:XYGIMEmotionGif];
        [emotionGifs addObject:emotion];
        
        [_emotionDic setObject:emotion forKey:[NSString stringWithFormat:@"em%d",(1000 + index)]];
        
    }
    //EaseEmotionManager *managerGif= [[EaseEmotionManager alloc] initWithType:EMEmotionGif emotionRow:2 emotionCol:4 emotions:emotionGifs tagImage:[UIImage imageNamed:@"icon_002_cover"]];
    
    return _emotionDic;
}
@end
