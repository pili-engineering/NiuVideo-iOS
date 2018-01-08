//
//  NVLiveSettingItem.h
//  NiuVideo
//
//  Created by hxiongan on 2017/12/25.
//  Copyright © 2017年 Pili Engineering, Qiniu Inc. All rights reserved.
//

#import <Foundation/Foundation.h>


typedef enum : NSUInteger {
    NVSettingItemPreviewSize,
    NVSettingItemPreViewRatio,
    NVSettingItemFocusing,
    NVSettingItemWaterMarkOpen,
    NVSettingItemWaterMarkSize,
    NVSettingItemWaterMarkAlpha,
    NVSettingItemWaterMarkPosition,
    NVSettingItemEncodeType,
    NVSettingItemEncoderQuality,
    NVSettingItemEncoderSize,
    NVSettingItemEncoderControl
} NVSettingItemType;


@interface NVLiveSettingItem : NSObject

@property (nonatomic, strong) NSString              *title;
@property (nonatomic, strong) NSArray<NSString*>    *values;
@property (nonatomic, assign) NSUInteger            selectedValueIndex;
@property (nonatomic, assign) NVSettingItemType     itemType;

@end
