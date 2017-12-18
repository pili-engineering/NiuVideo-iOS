//
//  NVButtonRowView.h
//  NiuVideo
//
//  Created by 冯文秀 on 2017/12/13.
//  Copyright © 2017年 Pili Engineering, Qiniu Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@class NVButtonRowView;
@protocol NVButtonRowViewDelegate <NSObject>

@optional
/**
 点击 NVButtonRowView 按钮的回调
 @warning 重复点击同一个 button 回调只在第一次点击时有效
 @param buttonRowView NVButtonRowView 的实例
 @param index 按钮下标
 */
- (void)buttonRowView:(NVButtonRowView *)buttonRowView didSelectedIndex:(NSInteger)index;

@end

@interface NVButtonRowView : UIView
@property (nonatomic, assign) id<NVButtonRowViewDelegate>delegate;

/**
 NVButtonRowView 初始化方法

 @param frame NVButtonRowView 位置及大小
 @param infoDictionary 字典格式 @{@"titles":@[],@"images":@[],@"selectedImages":@[]}，每个 key 值对应的数组个数需相同，不可为空，且个数大于 2
 @param space 左右间距，传 0 则等距分配
 @return NVButtonRowView 实例
 */
- (id)initWithFrame:(CGRect)frame infoDictionary:(NSDictionary *)infoDictionary space:(CGFloat)space;

@end
