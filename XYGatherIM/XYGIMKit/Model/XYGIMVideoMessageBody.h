//
//  XYGIMVideoMessageBody.h
//  XYGatherIM
//
//  Created by 杨卢银 on 2018/6/14.
//  Copyright © 2018年 杨卢银. All rights reserved.
//

#import "XYGIMFileMessageBody.h"

@interface XYGIMVideoMessageBody : XYGIMFileMessageBody

/*!
 *  \~chinese
 *  视频时长, 秒为单位
 *
 *  \~english
 *  Video duration, in seconds
 */
@property (nonatomic) int duration;

/*!
 *  \~chinese
 *  缩略图的本地路径
 *
 *  \~english
 *  Local path of thumbnail
 */
@property (nonatomic, copy) NSString *thumbnailLocalPath;

/*!
 *  \~chinese
 *  缩略图在服务器的路径
 *
 *  \~english
 *  Server url path of thumbnail
 */
@property (nonatomic, copy) NSString *thumbnailRemotePath;

/*!
 *  \~chinese
 *  缩略图的密钥, 下载缩略图时需要密匙做校验
 *
 *  \~english
 *  Secret key of thumbnail, required to download a thumbnail
 */
@property (nonatomic, copy) NSString *thumbnailSecretKey;

/*!
 *  \~chinese
 *  视频缩略图的尺寸
 *
 *  \~english
 *  Size of video thumbnail
 */
@property (nonatomic) CGSize thumbnailSize;

/*!
 *  \~chinese
 *  缩略图下载状态
 *
 *  \~english
 *  Download status of thumbnail
 */
@property (nonatomic)XYGIMDownloadStatus thumbnailDownloadStatus;

@end
