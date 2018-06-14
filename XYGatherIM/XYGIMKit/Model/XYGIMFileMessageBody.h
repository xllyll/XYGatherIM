//
//  XYGIMFileMessageBody.h
//  XYGatherIM
//
//  Created by 杨卢银 on 2018/6/14.
//  Copyright © 2018年 杨卢银. All rights reserved.
//

#import "XYGIMMessageBody.h"
/*!
 *  \~chinese
 *  附件下载状态
 *
 *  \~english
 *  File downloading status
 */
typedef enum {
    XYGIMDownloadStatusDownloading   = 0,  /*! \~chinese 正在下载 \~english Downloading */
    XYGIMDownloadStatusSucceed,            /*! \~chinese 下载成功 \~english Succeed */
    XYGIMDownloadStatusFailed,             /*! \~chinese 下载失败 \~english Failed */
    XYGIMDownloadStatusPending,            /*! \~chinese 准备下载 \~english Pending */
    XYGIMDownloadStatusSuccessed=XYGIMDownloadStatusSucceed,   /*! \~chinese 旧版 \~english legacy */
} XYGIMDownloadStatus;
@interface XYGIMFileMessageBody : XYGIMMessageBody

/*!
 *  \~chinese
 *  附件的显示名
 *
 *  \~english
 *  Display name of attachment
 */
@property (nonatomic, copy) NSString *displayName;

/*!
 *  \~chinese
 *  附件的本地路径
 *
 *  \~english
 *  Local path of attachment
 */
@property (nonatomic, copy) NSString *localPath;

/*!
 *  \~chinese
 *  附件在服务器上的路径
 *
 *  \~english
 *  Server path of attachment
 */
@property (nonatomic, copy) NSString *remotePath;

/*!
 *  \~chinese
 *  附件的密钥, 下载附件时需要密匙做校验
 *
 *  \~english
 *  Secret key for downloading the message attachment
 */
@property (nonatomic, copy) NSString *secretKey;

/*!
 *  \~chinese
 *  附件的大小, 以字节为单位
 *
 *  \~english
 *  Length of attachment, in bytes
 */
@property (nonatomic) long long fileLength;

/*!
 *  \~chinese
 *  附件的下载状态
 *
 *  \~english
 *  Downloading status of attachment
 */
@property (nonatomic) XYGIMDownloadStatus downloadStatus;

/*!
 *  \~chinese
 *  初始化文件消息体
 *
 *  @param aLocalPath   附件本地路径
 *  @param aDisplayName 附件显示名（不包含路径）
 *
 *  @result 消息体实例
 */
- (instancetype)initWithLocalPath:(NSString *)aLocalPath
                      displayName:(NSString *)aDisplayName;

/*!
 *  \~chinese
 *  初始化文件消息体
 *
 *  @param aData        附件数据
 *  @param aDisplayName 附件显示名（不包含路径）
 *
 *  @result 消息体实例
 */
- (instancetype)initWithData:(NSData *)aData
                 displayName:(NSString *)aDisplayName;

@end
