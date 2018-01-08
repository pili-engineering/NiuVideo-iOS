//
//  NVLiveSettingTableViewCell.h
//  NiuVideo
//
//  Created by hxiongan on 2017/12/25.
//  Copyright © 2017年 Pili Engineering, Qiniu Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NVLiveSettingItem.h"

@interface NVLiveSettingTableViewCell : UITableViewCell

@property (nonatomic, strong) UILabel             *titleLabel;
@property (nonatomic, strong) NVLiveSettingItem   *item;
@property (nonatomic, assign) UIEdgeInsets         contentInset;

@end


/// 只有选择项的用这个Cell
@interface NVLiveSettingSelectedTableViewCell : NVLiveSettingTableViewCell

@end


/// 需要自定义的项用这个Cell
@interface NVLiveSettingCustomTableViewCell : NVLiveSettingTableViewCell


@end


/// 水印透明度Cell
@interface NVLiveSettingWaterMarkAplhaTableViewCell : NVLiveSettingTableViewCell


@end
