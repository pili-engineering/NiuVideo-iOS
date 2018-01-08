//
//  NVLiveToolBoxView.m
//  NiuVideo
//
//  Created by hxiongan on 2017/12/21.
//  Copyright © 2017年 Pili Engineering, Qiniu Inc. All rights reserved.
//

#import "NVLiveToolBoxView.h"

@interface NVLiveToolBoxView ()
{
    UIButton* _toolButtons[8];
}

@property (nonatomic, strong) UIButton *dismissButton;
@property (nonatomic, strong) UIView *filterView;
@property (nonatomic, strong) UIView *backgroundView;

@end

@implementation NVLiveToolBoxView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
        self.dismissButton = [UIButton buttonWithType:(UIButtonTypeSystem)];
        [self.dismissButton addTarget:self action:@selector(clickDismssButton) forControlEvents:(UIControlEventTouchUpInside)];
        
        self.backgroundView = [[UIView alloc] init];
        
        [self addSubview:self.backgroundView];
        [self addSubview:self.dismissButton];
        
        [self.dismissButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.equalTo(self);
            make.bottom.equalTo(self.backgroundView.mas_top);
        }];
        
        [self.backgroundView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self);
            make.top.equalTo(self.mas_bottom);
        }];
        
        UIView* superView = self.backgroundView;
        
        UIVisualEffect *effect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
        UIVisualEffectView *effectView = [[UIVisualEffectView alloc] initWithEffect:effect];
        [superView addSubview:effectView];
        [effectView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(superView);
        }];
        
        NSString* buttonImages[8] = {
            @"live_beaty_face",
            @"live_filter",
            @"live_face_magic",
            @"live_mirror_switch",
            @"live_screen_record",
            @"live_flash_light",
            @"live_camera_switch",
            @"live_music",
        };
        
        NSString* buttonTitles[] = {
            @"美颜",
            @"滤镜",
            @"特效",
            @"镜像",
            @"录屏",
            @"闪光灯",
            @"翻转",
            @"音乐",
        };

        for (int i = 0; i < ARRAY_SIZE(_toolButtons); i ++) {
            _toolButtons[i] = [[UIButton alloc] init];
            _toolButtons[i].titleLabel.font = [UIFont systemFontOfSize:12];
            [_toolButtons[i] setImage:[UIImage imageNamed:buttonImages[i]] forState:(UIControlStateNormal)];
            [_toolButtons[i] setTitle:buttonTitles[i] forState:(UIControlStateNormal)];
            [_toolButtons[i] setTitleColor:NV_BLACK_COLOR forState:(UIControlStateNormal)];
            [_toolButtons[i] addTarget:self action:@selector(clickToolBoxButton:) forControlEvents:(UIControlEventTouchUpInside)];
            _toolButtons[i].tag = NVToolBoxTypeBeaty + i;
            [_toolButtons[i] sizeToFit];
            
            CGFloat totalHeight = (_toolButtons[i].imageView.frame.size.height + _toolButtons[i].titleLabel.frame.size.height);
            
            [_toolButtons[i] setImageEdgeInsets:UIEdgeInsetsMake(-(totalHeight - _toolButtons[i].imageView.frame.size.height), 0.0, 0.0, -_toolButtons[i].titleLabel.frame.size.width)];
            [_toolButtons[i] setTitleEdgeInsets:UIEdgeInsetsMake(5, -_toolButtons[i].imageView.frame.size.width, -(totalHeight - _toolButtons[i].titleLabel.frame.size.height),0.0)];
            [superView addSubview:_toolButtons[i]];
        }
        
        UIButton* button = _toolButtons[4];
        NSArray* array = [NSArray arrayWithObjects:&_toolButtons[4] count:4];
        [array mas_distributeViewsAlongAxis:(MASAxisTypeHorizontal) withFixedSpacing:0 leadSpacing:20 tailSpacing:20];
        [array mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(superView).offset(-20);
            make.height.equalTo(button.mas_width).multipliedBy(1.1);
        }];
        
        array = [NSArray arrayWithObjects:_toolButtons count:4];
        [array mas_distributeViewsAlongAxis:(MASAxisTypeHorizontal) withFixedSpacing:0 leadSpacing:20 tailSpacing:20];
        [array mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(button.mas_top);
            make.height.equalTo(button.mas_width).multipliedBy(1.1);
        }];
        
        UIView* grayLine = [[UIView alloc] init];
        grayLine.backgroundColor = [UIColor grayColor];
        
        self.filterView = [[UIView alloc] init];
        self.filterView.clipsToBounds = YES;
        [self.filterView addSubview:grayLine];
        
        [superView addSubview:self.filterView];
        
        [grayLine mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.equalTo(self.filterView);
            make.height.equalTo(1);
        }];
        
        button = _toolButtons[0];
        [self.filterView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.right.equalTo(superView);
            make.height.equalTo(0);
            make.bottom.equalTo(button.mas_top).offset(-20);
        }];
    }
    return self;
}

- (BOOL)filertViewisShow {
    return self.filterView.bounds.size.height > 1;
}

- (void)clickDismssButton{
    [self hide];
}

- (void)clickToolBoxButton:(UIButton*)button {
    NSInteger tag = button.tag;
    if (NVToolBoxTypeBeaty == tag) {
        if ([self filertViewisShow]) {
            [self hideFilterView];
        } else {
            [self showFilterView];
        }
    } else {
        if ([self filertViewisShow]) {
            [self hideFilterView];
        }
        //notify delegate
    }
}

- (void)show {
    
    self.hidden = NO;
    [self.backgroundView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self);
        make.bottom.equalTo(self.mas_bottom);
    }];
    
    [self updateConstraintsIfNeeded];
    [self setNeedsUpdateConstraints];
    [UIView animateWithDuration:.3 animations:^{
        [self layoutIfNeeded];
    }];
}

- (void)hide {
    [self.backgroundView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self);
        make.top.equalTo(self.mas_bottom);
    }];
    
    [self updateConstraintsIfNeeded];
    [self setNeedsUpdateConstraints];
    [UIView animateWithDuration:.3 animations:^{
        [self layoutIfNeeded];
    } completion:^(BOOL finished) {
        self.hidden = YES;
    }];
}

- (void)showFilterView {
    
    UIButton* button = _toolButtons[0];
    [self.filterView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.backgroundView);
        make.height.equalTo(60);
        make.bottom.equalTo(button.mas_top).offset(-20);
    }];
    
    [self updateConstraintsIfNeeded];
    [self setNeedsUpdateConstraints];
    [UIView animateWithDuration:.3 animations:^{
        [self layoutIfNeeded];
    }];
}

- (void)hideFilterView {
    
    UIButton* button = _toolButtons[0];
    [self.filterView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.backgroundView);
        make.height.equalTo(0);
        make.bottom.equalTo(button.mas_top).offset(-20);
    }];
    
    [self updateConstraintsIfNeeded];
    [self setNeedsUpdateConstraints];
    [UIView animateWithDuration:.3 animations:^{
        [self layoutIfNeeded];
    }];
}

@end

