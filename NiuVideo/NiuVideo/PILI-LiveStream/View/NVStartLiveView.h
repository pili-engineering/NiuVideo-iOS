//
//  NVStartLiveView.h
//  NiuVideo
//
//  Created by hxiongan on 2017/12/21.
//  Copyright © 2017年 Pili Engineering, Qiniu Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@class NVStartLiveView;
@protocol NVStartLiveViewDelegate <NSObject>

- (void)startLiveViewCloseButtonClick:(NVStartLiveView*)liveView;
- (void)startLiveView:(NVStartLiveView*)liveView startLiveWithTitle:(NSString*)title;

@end

@interface NVStartLiveView : UIView

@property (nonatomic, weak)     id<NVStartLiveViewDelegate>delegate;

@end
