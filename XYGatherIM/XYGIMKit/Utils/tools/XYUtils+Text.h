//
//  XYUtils+Text.h
//  XYGatherIM
//
//  Created by 杨卢银 on 2018/6/21.
//  Copyright © 2018年 杨卢银. All rights reserved.
//

#import "XYUtils.h"

NS_ASSUME_NONNULL_BEGIN

@interface XYUtils (Text)

+ (CGFloat)widthForSingleLineString:(NSString *)text font:(UIFont *)font;

//获取拼音首字母(传入汉字字符串, 返回大写拼音首字母)
+ (NSString *)firstPinyinLetterOfString:(NSString *)aString;
//获取拼音
+ (NSString *)pinyinOfString:(NSString *)aString;

+ (NSString *)sizeStringWithStyle:(nullable id)style size:(long long)size;

//+ (NSDictionary *)textMessageExtForEmotionModel:(XYGIMEmotionModel *)model;

+ (CGSize)boundingSizeForText:(NSString *)text maxWidth:(CGFloat)maxWidth font:(UIFont *)font lineSpacing:(CGFloat)lineSpacing;

+ (NSMutableAttributedString *)highlightDefaultDataTypes:(NSMutableAttributedString *)attributedString;

@end

NS_ASSUME_NONNULL_END
