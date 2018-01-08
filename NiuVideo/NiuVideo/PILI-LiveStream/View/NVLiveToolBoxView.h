//
//  NVLiveToolBoxView.h
//  NiuVideo
//
//  Created by hxiongan on 2017/12/21.
//  Copyright © 2017年 Pili Engineering, Qiniu Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    NVToolBoxTypeBeaty = 0x1,
    NVToolBoxTypeFilter,
    NVToolBoxTypeFaceMagic,
    NVToolBoxTypeMirror,
    NVToolBoxTypeScreenRecord,
    NVToolBoxTypeFlashLight,
    NVToolBoxTypeCameraSwitch,
    NVToolBoxTypeMusic,
} NVToolBoxType;

@class NVLiveToolBoxView;
@protocol NVLiveToolBoxViewDelegate <NSObject>
@end;

@interface NVLiveToolBoxView : UIView

@property (nonatomic, weak) id<NVLiveToolBoxViewDelegate>delegate;

- (void)show;
- (void)hide;

@end
