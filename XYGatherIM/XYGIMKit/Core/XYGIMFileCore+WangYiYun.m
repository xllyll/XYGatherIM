//
//  XYGIMFileCore+WangYiYun.m
//  XYGatherIM
//
//  Created by 杨卢银 on 2018/6/11.
//  Copyright © 2018年 杨卢银. All rights reserved.
//

#import "XYGIMFileCore+WangYiYun.h"
#import <sys/stat.h>
#import "XYGIMClient.h"
#import "XYGIMMacros.h"

#define PATH_OF_DOCUMENT    [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0]


@implementation XYGIMFileCore (WangYiYun)
+(NSString*)getPath2:(NSString*)p{
    XYGIMLibType libtype = [[XYGIMClient sharedClient] libType];
    NSString *userId = @"DATA";
    NSString *path = [NSString stringWithFormat:@"%@/XYDATA/%d/%@",PATH_OF_DOCUMENT,libtype,userId];
    
    NSArray *sarray = [p componentsSeparatedByString:@"/"];
    NSString *s = p;
    if (sarray && sarray.count>1) {
        for (int i = 0; i < sarray.count-1;i++) {
            path = [NSString stringWithFormat:@"%@/%@",path,sarray[i]];
        }
        s = [sarray lastObject];
    }
    BOOL bo = [[NSFileManager defaultManager] createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:nil];
    NSAssert(bo,@"创建目录失败");
    if (bo==YES) {
        
    }
    NSString *returnString = [[path stringByAppendingString:@"/"] stringByAppendingString:s];
    
    XYLog(@"文件位置：%@",returnString);
    
    return returnString;
}
+(NSMutableDictionary*)getDictionary2:(NSString*)name{
    NSDictionary *rootDic = [[NSDictionary alloc]initWithContentsOfFile:[self getPath2:name]];
    if (!rootDic) {
        rootDic = [NSDictionary dictionary];
        if([rootDic writeToFile:[self getPath2:name] atomically:YES]){
            
        }else{
            XYLog(@"写入文件失败！%@",[self getPath2:name]);
        }
    }
    NSMutableDictionary *dic = [[NSMutableDictionary alloc]initWithDictionary:rootDic];
    return dic;
}
+(void)saveLoginData:(XYGIMLoginData *)loginData{
    NSMutableDictionary *dic = [self getDictionary2:@"NIM_LOGIN.plist"];
    NSDictionary *user = @{@"account":loginData.account,@"password":loginData.password};
    [dic setObject:user forKey:@"USER"];
    [dic writeToFile:[self getPath2:@"NIM_LOGIN.plist"] atomically:YES];
}
+(XYGIMLoginData *)getLoginData{
    NSMutableDictionary *dic = [self getDictionary2:@"NIM_LOGIN.plist"];
    NSDictionary *user = dic[@"USER"];
    if (user!=nil) {
        NSString *u = user[@"account"];
        NSString *p = user[@"password"];
        if (u && p) {
            XYGIMLoginData *data = [[XYGIMLoginData alloc] init];
            data.account = u;
            data.password = p;
            return data;
        }
    }
    return nil;
}

@end
