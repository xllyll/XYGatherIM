//
//  XYGIMFileCore.m
//  XYGatherIM
//
//  Created by 杨卢银 on 2018/6/11.
//  Copyright © 2018年 杨卢银. All rights reserved.
//

#import "XYGIMFileCore.h"
#import <sys/stat.h>
#import "XYGIMClient.h"
#import "XYGIMMacros.h"

#define PATH_OF_DOCUMENT    [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0]

@interface XYGIMFileCore()

@end

@implementation XYGIMFileCore

+(NSString*)getPath:(NSString*)p{
    XYGIMLibType libtype = [[XYGIMClient sharedClient] libType];
    NSString *userId = [[XYGIMClient sharedClient] currentUser];
    if (userId==nil) {
        userId = @"DATA";
    }
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
+(NSMutableDictionary*)getDictionary:(NSString*)name{
    NSDictionary *rootDic = [[NSDictionary alloc]initWithContentsOfFile:[self getPath:name]];
    if (!rootDic) {
        rootDic = [NSDictionary dictionary];
        if([rootDic writeToFile:[self getPath:name] atomically:YES]){
            
        }else{
            XYLog(@"写入文件失败！%@",[self getPath:name]);
        }
    }
    NSMutableDictionary *dic = [[NSMutableDictionary alloc]initWithDictionary:rootDic];
    return dic;
}

@end
