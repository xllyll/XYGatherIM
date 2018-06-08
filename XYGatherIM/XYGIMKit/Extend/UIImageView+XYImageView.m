//
//  UIImageView+XYImageView.m
//  XYGatherIM
//
//  Created by 杨卢银 on 2018/4/16.
//  Copyright © 2018年 杨卢银. All rights reserved.
//

#import "UIImageView+XYImageView.h"
#import "NSString+XYString.h"


#define PATH_XY_OF_CACHE       [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0]

@implementation UIImageView (XYImageView)

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

-(void)fu_setImageURLByLoading:(NSString *)imageUrlString placeholderImage:(UIImage *)placeimage{
    self.image = placeimage;
    
    UIImage *timage = [self getImageName:imageUrlString foundation:@"CACHE"];
    if (timage) {
        self.image = timage;
    }else{
        if(imageUrlString ==nil || [imageUrlString isKindOfClass:[NSNull class]] || imageUrlString.length==0){
            return;
        }
        //        [FUNetWorkingAction download:imageUrlString progressBlock:^(CGFloat progress) {
        //
        //        } ResponseData:^(NSData *i_data, NSError *error) {
        //
        //        }];
//        XYHttpAction *action = [[XYHttpAction alloc]init];
//        
//        FUHUDLoading;
//        float asize=20.0;
//        UIActivityIndicatorView *ac = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
//        ac.frame = CGRectMake((K_WINDOW_FRAME.size.width-asize)/2.0, (K_WINDOW_FRAME.size.width-asize)/2.0, asize, asize);
//        [self addSubview:ac];
//        [ac startAnimating];
//        
//        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
//        [action download:imageUrlString progressBlock:^(CGFloat progress) {
//            
//        } ResponseData:^(NSData *i_data, NSError *error) {
//            FUHUDDismiss;
//            [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
//            
//            [ac removeFromSuperview];
//            
//            if (i_data) {
//                UIImage *tempImage = [UIImage imageWithData:i_data];
//                if (tempImage) {
//                    [self saveImage:tempImage imageName:imageUrlString foundation:@"CACHE"];
//                    self.image = tempImage;
//                }else{
//                    NSLog(@"data图片下载失败！");
//                }
//            }else{
//                NSLog(@"图片下载失败！");
//            }
//        }];
    }
}
-(void)fu_setImageURL:(NSString *)imageUrlString placeholderImage:(UIImage *)placeimage{
    
    self.image = placeimage;
    
    UIImage *timage = [self getImageName:imageUrlString foundation:@"CACHE"];
    if (timage) {
        self.image = timage;
        
    }else{
        if(imageUrlString ==nil || [imageUrlString isKindOfClass:[NSNull class]] || imageUrlString.length==0){
            return;
        }
      
        // 1.创建url
        NSString *urlString = imageUrlString;
        // 一些特殊字符编码
        urlString = [urlString stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
        NSURL *url = [NSURL URLWithString:urlString];
        
        // 2.创建请求
        NSURLRequest *request = [NSURLRequest requestWithURL:url];
        
        // 3.创建会话，采用苹果提供全局的共享session
        NSURLSession *sharedSession = [NSURLSession sharedSession];
        
        // 4.创建任务
        NSURLSessionDownloadTask *downloadTask = [sharedSession downloadTaskWithRequest:request completionHandler:^(NSURL * _Nullable location, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            if (error == nil) {
                // location:下载任务完成之后,文件存储的位置，这个路径默认是在tmp文件夹下!
                // 只会临时保存，因此需要将其另存
                NSLog(@"location:%@",location.path);
                
                // 采用模拟器测试，为了方便将其下载到Mac桌面
                // NSString *filePath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
                NSString *filePath = @"/Users/coohua/Desktop/周杰伦 - 枫.mp3";
                NSError *fileError;
                [[NSFileManager defaultManager] copyItemAtPath:location.path toPath:filePath error:&fileError];
                if (fileError == nil) {
                    NSLog(@"file save success");
                } else {
                    NSLog(@"file save error: %@",fileError);
                }
            } else {
                NSLog(@"download error:%@",error);
            }
        }];
        
        // 5.开启任务
        [downloadTask resume];
        
//        NSURL *url = [NSURL URLWithString:imageUrlString];
//        NSURLRequest *request = [NSURLRequest requestWithURL:url];
//        NSURLConnection as
//        [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse * _Nullable response, NSData * _Nullable data, NSError * _Nullable connectionError) {
//            if (data) {
//                UIImage *tempImage = [UIImage imageWithData:data];
//                NSString *s = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
//                if (tempImage) {
//
//                    [self saveImage:tempImage imageName:imageUrlString foundation:@"CACHE"];
//                    self.image = tempImage;
//                }else{
//                    NSLog(@"data图片下载失败！");
//                }
//            }else{
//                NSLog(@"图片下载失败！");
//            }
//        }];
    }
}
-(BOOL)saveImage:(UIImage *)image imageName:(NSString *)image_name foundation:(NSString *)foundation_name{
    if(image_name==nil || [image_name isKindOfClass:[NSNull class]]){
        return NO;
    }
    NSString *path = [[[PATH_XY_OF_CACHE stringByAppendingPathComponent:@"XYGIMDATA"] stringByAppendingPathComponent:@"Image"] stringByAppendingPathComponent:foundation_name];
    BOOL bo = [[NSFileManager defaultManager] createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:nil];
    NSAssert(bo,@"创建目录失败");
    if (bo==YES) {
        
    }
    NSString *uniquePath=[PATH_XY_OF_CACHE stringByAppendingPathComponent:[NSString stringWithFormat:@"/XYGIMDATA/Image/%@/image_%@.png",foundation_name,[image_name md5String]]];//以model.itemid image.png为区分保存在Documents中
    BOOL result = [UIImagePNGRepresentation(image) writeToFile:uniquePath atomically:YES];
    return result;
}

-(UIImage *)getImageName:(NSString *)image_name foundation:(NSString *)foundation_name{
    if(image_name==nil || [image_name isKindOfClass:[NSNull class]]){
        return nil;
    }
    NSString *uniquePath=[PATH_XY_OF_CACHE stringByAppendingPathComponent:[NSString stringWithFormat:@"/XYGIMDATA/Image/%@/image_%@.png",foundation_name,[image_name md5String]]];
    UIImage *image = [[UIImage alloc]initWithContentsOfFile:uniquePath];
    return image;
}

@end
