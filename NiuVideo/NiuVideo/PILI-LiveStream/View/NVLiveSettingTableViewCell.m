//
//  NVLiveSettingTableViewCell.m
//  NiuVideo
//
//  Created by hxiongan on 2017/12/25.
//  Copyright © 2017年 Pili Engineering, Qiniu Inc. All rights reserved.
//

#import "NVLiveSettingTableViewCell.h"

@implementation NVLiveSettingTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentInset = UIEdgeInsetsMake(10, 16, 10, 16);
        
        self.titleLabel = [[UILabel alloc] init];
        self.titleLabel.font = [UIFont systemFontOfSize:14];
        self.titleLabel.numberOfLines = 0;
        self.titleLabel.textColor =NV_BLACK_COLOR;
        
        [self.contentView addSubview:self.titleLabel];
        
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentInset.left);
            make.top.equalTo(self.contentInset.top);
            make.right.equalTo(-self.contentInset.right);
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

- (void)setItem:(NVLiveSettingItem *)item {
    _item = item;
    self.titleLabel.text = item.title;
}

@end


@interface NVLiveSettingSelectedTableViewCell () {
    
}
@end;


@implementation NVLiveSettingSelectedTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

- (void)setItem:(NVLiveSettingItem *)item {
    
    [super setItem:item];
    
    UIView* preView = nil;
    for (int i = 0; i < item.values.count; i ++) {
        UIButton* button = [UIButton buttonWithType:(UIButtonTypeCustom)];
        if (item.selectedValueIndex == i) {
            [button setImage:[UIImage imageNamed:@""] forState:(UIControlStateNormal)];
        } else {
            [button setImage:[UIImage imageNamed:@""] forState:(UIControlStateNormal)];
        }
        [button setTitle:item.values[i] forState:(UIControlStateNormal)];
        [button setTitleColor:NV_BLACK_COLOR forState:(UIControlStateNormal)];
        [button setTitleColor:[UIColor colorWithWhite:0.0 alpha:.5] forState:(UIControlStateHighlighted)];
        [button.titleLabel setFont:[UIFont systemFontOfSize:14]];
        [button setTag:i];
        [button addTarget:self action:@selector(clickValueButton:) forControlEvents:(UIControlEventTouchUpInside)];
        [button sizeToFit];
        
        [self.contentView addSubview:button];
        
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.titleLabel.mas_bottom).offset(self.contentInset.top);
            make.size.equalTo(button.bounds.size);
            if (preView) {
                make.left.equalTo(preView.mas_right).offset(self.contentInset.left);
            } else {
                make.left.equalTo(self.contentView).offset(self.contentInset.left);
            }
        }];
        preView = button;
    }
    
    [preView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.contentView).offset(-self.contentInset.bottom);
    }];
    
    
}

- (void)clickValueButton:(UIButton*)button{
    
    
}

@end



@interface NVLiveSettingCustomTableViewCell () {
    
}

@property (nonatomic, strong)UIView    *selectView;
@property (nonatomic, strong)UILabel   *valueShowLabel;
@property (nonatomic, strong)UIImageView *arrawImageView;

@end

@implementation NVLiveSettingCustomTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.arrawImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@""]];
        
        self.valueShowLabel = [[UILabel alloc] init];
        self.valueShowLabel.font = [UIFont systemFontOfSize:14];
        self.valueShowLabel.textColor = NV_BLACK_COLOR;
        
        self.selectView = [[UIView alloc] init];
        self.selectView.backgroundColor = [UIColor colorWithWhite:243.0/255 alpha:1];
        self.selectView.layer.cornerRadius = 2;
        
        [self.contentView addSubview:self.selectView];
        [self.selectView addSubview:self.valueShowLabel];
        [self.selectView addSubview:self.arrawImageView];
        
        [self.arrawImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.selectView);
            make.right.equalTo(self.selectView).offset(-10);
            make.size.equalTo(self.arrawImageView.image.size);
        }];
        
        [self.valueShowLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.selectView).offset(10);
            make.right.equalTo(self.arrawImageView.mas_left).offset(-5);
            make.centerY.equalTo(self.selectView);
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

- (void)setItem:(NVLiveSettingItem *)item{
    [super setItem:item];
    
    UIView* preView = nil;
    NSString* titles[] = {@"预设", @"自定义"};
    for (int i = 0; i < ARRAY_SIZE(titles); i ++) {
        UIButton* button = [UIButton buttonWithType:(UIButtonTypeCustom)];
        if (0 == i) {
            [button setImage:[UIImage imageNamed:@""] forState:(UIControlStateNormal)];
        } else {
            [button setImage:[UIImage imageNamed:@""] forState:(UIControlStateNormal)];
        }
        [button setTitle:titles[i] forState:(UIControlStateNormal)];
        [button setTitleColor:NV_BLACK_COLOR forState:(UIControlStateNormal)];
        [button setTitleColor:[UIColor colorWithWhite:0.0 alpha:.5] forState:(UIControlStateHighlighted)];
        [button.titleLabel setFont:[UIFont systemFontOfSize:14]];
        [button setTag:i];
        [button addTarget:self action:@selector(clickValueButton:) forControlEvents:(UIControlEventTouchUpInside)];
        [button sizeToFit];
        
        [self.contentView addSubview:button];
        
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.titleLabel.mas_bottom).offset(self.contentInset.top);
            make.size.equalTo(button.bounds.size);
            if (preView) {
                make.left.equalTo(preView.mas_right).offset(self.contentInset.left);
            } else {
                make.left.equalTo(self.contentView).offset(self.contentInset.left);
            }
        }];
        preView = button;
    }
    
    [self.selectView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(self.contentInset.left);
        make.right.equalTo(self.contentView).offset(-self.contentInset.right);
        make.top.equalTo(preView.mas_bottom).offset(self.contentInset.top);
        make.bottom.equalTo(self.contentView).offset(-self.contentInset.bottom);
        make.height.equalTo(38);
    }];
}

@end


@implementation NVLiveSettingWaterMarkAplhaTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
