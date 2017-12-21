//
//  NVLiveCoverView.h
//  NiuVideo
//
//  Created by hxiongan on 2017/12/15.
//  Copyright © 2017年 Pili Engineering, Qiniu Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@class NVLiveCoverView;
@protocol NVLiveCoverViewDelegate <NSObject>

- (void)liveCoverViewCloseAction:(NVLiveCoverView*)liveCoverView;
- (void)liveCoverViewShareAction:(NVLiveCoverView*)liveCoverView;
- (void)liveCoverViewMessageAction:(NVLiveCoverView*)liveCoverView;
- (void)liveCoverViewControlAction:(NVLiveCoverView*)liveCoverView;

- (void)liveCoverView:(NVLiveCoverView*)liveCoverView startStreamActionWithTitle:(NSString*)title;

@end


@interface NVLiveCoverView : UIView

@property (nonatomic, weak) id<NVLiveCoverViewDelegate>delegate;

@end
