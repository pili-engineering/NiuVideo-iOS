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
- (void)liveCoverViewCommentAction:(NVLiveCoverView*)liveCoverView;
- (void)liveCoverViewSettingAction:(NVLiveCoverView*)liveCoverView;

@end


@interface NVLiveCoverView : UIView

@property (nonatomic, weak) id<NVLiveCoverViewDelegate>delegate;
@property (nonatomic)       BOOL isPushLive;//是直播还是观看直播,YES:直播；NO:观看
@end
