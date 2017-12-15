//
//  NVLiveStreamTableViewCell.h
//  NiuVideo
//
//  Created by hxiongan on 2017/12/13.
//  Copyright © 2017年 Pili Engineering, Qiniu Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NVLiveUserModel.h"

@class NVLiveStreamTableViewCell;
@protocol NVLiveStreamTableViewCellDelegate <NSObject>

- (void)liveStreamTableViewCellShareButtonClick:(NVLiveStreamTableViewCell*)liveCell;

@end


@interface NVLiveStreamTableViewCell : UITableViewCell

@property (nonatomic, weak) id<NVLiveStreamTableViewCellDelegate> delegate;
@property (nonatomic, strong) NVLiveUserModel   *liveUserModel;

@end
