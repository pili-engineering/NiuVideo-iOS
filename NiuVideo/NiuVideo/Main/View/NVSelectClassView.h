//
//  NVSelectClassView.h
//  NiuVideo
//
//  Created by 冯文秀 on 2017/12/5.
//  Copyright © 2017年 Pili Engineering, Qiniu Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
@class NVSelectClassView;
@protocol NVSelectClassViewDelegate <NSObject>

@optional
/**
 点击 NVSelectClassView 按钮的回调
 
 @param classView NVSelectClassView 的实例
 @param index 按钮下标，0 为短视频，1 为直播
 */
- (void)classView:(NVSelectClassView *)classView didSelectedIndex:(NSInteger)index;

@end

@interface NVSelectClassView : UIView
@property (nonatomic, assign) id<NVSelectClassViewDelegate> delegate;

- (instancetype)initWithFrame:(CGRect)frame superView:(UIView *)superView;

- (void)popSelectClassView;
- (void)cancelSelectClassView;

@end
