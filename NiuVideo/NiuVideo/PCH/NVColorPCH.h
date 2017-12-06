//
//  NVColorPCH.h
//  NiuVideo
//
//  Created by 冯文秀 on 2017/12/5.
//  Copyright © 2017年 Pili Engineering, Qiniu Inc. All rights reserved.
//

#ifndef NVColorPCH_h
#define NVColorPCH_h

/*********************  颜色  *********************/
// 颜色RGB 通用
#define NV_COLOR_RGBA(r,g,b,a) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]

// 黑色
#define NV_BLACK_COLOR NV_COLOR_RGBA(0, 0, 0, 1)

// 灰色透明
#define NV_BLACK_POP_COLOR NV_COLOR_RGBA(209, 207, 205, 0.33)

// 白色按钮背景
#define NV_BUTTON_BLACKBG NV_COLOR_RGBA(74, 74, 74, 1)

/*********************  字体  *********************/
#define NV_LIGHT_FONT(FontSize) [UIFont fontWithName:@"HelveticaNeue-Light" size:FontSize]
#define NV_REGULAR_FONT(FontSize) [UIFont fontWithName:@"HelveticaNeue-Regular" size:FontSize]
#define NV_BOLD_FONT(FontSize) [UIFont fontWithName:@"HelveticaNeue-Bold" size:FontSize]


#endif /* NVColorPCH_h */
