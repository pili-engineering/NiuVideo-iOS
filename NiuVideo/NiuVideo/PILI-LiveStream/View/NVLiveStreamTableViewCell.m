//
//  NVLiveStreamTableViewCell.m
//  NiuVideo
//
//  Created by hxiongan on 2017/12/13.
//  Copyright © 2017年 Pili Engineering, Qiniu Inc. All rights reserved.
//

#import "NVLiveStreamTableViewCell.h"
#import <Masonry.h>

@interface NVLiveStreamTableViewCell ()

@property (nonatomic, strong) UIImageView   *userHaaderImageView;
@property (nonatomic, strong) UILabel       *liveTitleLabel;
@property (nonatomic, strong) UILabel       *userNameLabel;
@property (nonatomic, strong) UIImageView   *thumbImageView;
@property (nonatomic, strong) UIButton      *shareButton;

@end


@implementation NVLiveStreamTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _userHaaderImageView = [[UIImageView alloc] init];
        _userHaaderImageView.clipsToBounds  = YES;
        _userHaaderImageView.contentMode    = UIViewContentModeScaleAspectFill;
        
        _liveTitleLabel = [[UILabel alloc] init];
        _liveTitleLabel.font        = [UIFont systemFontOfSize:10.0];
        _liveTitleLabel.textColor   = NV_BLACK_COLOR;
        
        _userNameLabel = [[UILabel alloc] init];
        _userNameLabel.font         = [UIFont systemFontOfSize:10.0];
        _userNameLabel.textColor    = [UIColor colorWithWhite:155.0/255 alpha:1];
        
        _thumbImageView = [[UIImageView alloc] init];
        _thumbImageView.clipsToBounds   = YES;
        _thumbImageView.contentMode     = UIViewContentModeScaleAspectFill;
        
        UIImage* shareImage = [UIImage imageNamed:@"share"];
        _shareButton = [UIButton buttonWithType:(UIButtonTypeSystem)];
        _shareButton.tintColor = NV_BLACK_COLOR;
        [_shareButton setImage:shareImage forState:(UIControlStateNormal)];
        [_shareButton addTarget:self action:@selector(shareButtonAction) forControlEvents:(UIControlEventTouchUpInside)];
        
        UIView* superView = self.contentView;
        
        [superView addSubview:_userHaaderImageView];
        [superView addSubview:_liveTitleLabel];
        [superView addSubview:_userNameLabel];
        [superView addSubview:_thumbImageView];
        [superView addSubview:_shareButton];
        
        [_userHaaderImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.equalTo(@(CGSizeMake(36, 36)));
            make.left.equalTo(superView).offset(10);
            make.top.equalTo(@(5));
        }];
        
        [_liveTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_userHaaderImageView.mas_right).offset(10);
            make.bottom.equalTo(_userHaaderImageView.mas_centerY).offset(-2);
            make.right.equalTo(_shareButton.mas_left);
        }];
        
        [_userNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(_liveTitleLabel);
            make.top.equalTo(_userHaaderImageView.mas_centerY).offset(2);
        }];
        
        [_thumbImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.left.right.equalTo(superView);
            make.top.equalTo(_userHaaderImageView.mas_bottom).offset(5);
            make.height.equalTo(_thumbImageView.mas_width).multipliedBy(1.0);
        }];
        
        [_shareButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(_userHaaderImageView);
            make.width.equalTo(@(shareImage.size.width));
            make.height.equalTo(@(44));
            make.right.equalTo(superView).offset(-10);
        }];
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)shareButtonAction {
    
}

- (void)setLiveUserModel:(NVLiveUserModel *)liveUserModel {
    _liveUserModel = liveUserModel;
    // do UI config
}

@end
