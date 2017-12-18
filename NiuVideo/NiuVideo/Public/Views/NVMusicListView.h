//
//  NVMusicListView.h
//  NiuVideo
//
//  Created by 冯文秀 on 2017/12/14.
//  Copyright © 2017年 Pili Engineering, Qiniu Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@class NVMusicListView;
@protocol NVMusicListViewDelegate <NSObject>

@optional
/**
 点击 NVMusicListView 按钮的回调
 @param musicListView NVMusicListView 的实例
 @param index 按钮下标
 */
- (void)musicListView:(NVMusicListView *)musicListView didSelectedIndex:(NSInteger)index;

@end

@interface NVMusicListView : UIView
@property (nonatomic, assign) id<NVMusicListViewDelegate>delegate;

- (id)initWithFrame:(CGRect)frame listArray:(NSArray *)listArray;
@end


@interface NVMusicViewCell : UITableViewCell

- (void)configureMusicViewCellWithSelected:(BOOL)selected musicString:(NSString *)musicString;
@end



