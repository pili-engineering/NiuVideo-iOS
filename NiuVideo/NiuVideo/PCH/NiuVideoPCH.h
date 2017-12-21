//
//  NiuVideoPCH.h
//  NiuVideo
//
//  Created by 冯文秀 on 2017/12/5.
//  Copyright © 2017年 Pili Engineering, Qiniu Inc. All rights reserved.
//

#ifndef NiuVideoPCH_h
#define NiuVideoPCH_h

// 颜色及字体
#import "NVColorPCH.h"
// 网络接口
#import "NVHttpPCH.h"



#define NV_WEAKSELF  __weak typeof(self) weakSelf = self;

/********************  屏幕宽高  ********************/
#define NV_SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define NV_SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

/********************  机型尺寸  ********************/
#define BC_IPHONE_5SE (NV_SCREEN_HEIGHT == 568.0f)
#define BC_IPHONE_6 (NV_SCREEN_HEIGHT == 667.0f)
#define BC_IPHONE_6PLUS (NV_SCREEN_HEIGHT == 736.0f)
#define BC_IPHONE_X (NV_SCREEN_HEIGHT == 812.0)

// iPhone X
#define NV_SAFE_TOP_HEIGHT_NAV (NV_SCREEN_HEIGHT == 812.0 ? 88 : 64) //有导航条时的顶部安全高度
#define NV_SAFE_TOP_HEIGHT (NV_SCREEN_HEIGHT == 812.0 ? 44 : 20) //无导航条时的顶部安全高度
#define NV_SAFE_BOTTOM_HEIGHT_TABBAR (NV_SCREEN_HEIGHT == 812.0 ? 34 : 0) // 无tabbar时底部的安全高度
#define NV_SAFE_BOTTOM_HEIGHT (NV_SCREEN_HEIGHT == 812.0 ? 83 : 49) // 有tabbar时底部的安全高度

// 比例
#define NV_WIDTH_RATIO (NV_SCREEN_WIDTH / 375.f)
#define NV_HEIGHT_RATIO (NV_SCREEN_HEIGHT / 667.f)

/********************  第三方  ********************/
#define MAS_SHORTHAND_GLOBALS
#import <Masonry.h>


/******************** 公共类接口 ********************/





#endif /* NiuVideoPCH_h */
