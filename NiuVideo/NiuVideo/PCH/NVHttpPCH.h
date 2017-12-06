//
//  NVHttpPCH.h
//  NiuVideo
//
//  Created by 冯文秀 on 2017/12/5.
//  Copyright © 2017年 Pili Engineering, Qiniu Inc. All rights reserved.
//

#ifndef NVHttpPCH_h
#define NVHttpPCH_h

/*********************  接口  *********************/
#define NV_HTTP_HOST @"http://www.niuVideo.cn/"

#ifdef DEBUG


#define NV_HOST_URL NV_HTTP_HOST

#else

// 发布环境接口
#define NV_HOST_URL NV_HTTP_HOST


#endif

/********************  版本更新  *********************/
#define NIUVIDEO_URL_APPID @"xxxxxxxxx"
#define NIUVIDEO_URL [NSString stringWithFormat:@"http://itunes.apple.com/cn/lookup?id=%@", MerchantAppId]

// 版本更新
#define NIUVIDEO_VERSION_URL @"niuvideo_update.html"




#endif /* WMHttpPCH_h */
