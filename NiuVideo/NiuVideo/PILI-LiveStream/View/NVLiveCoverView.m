//
//  NVLiveCoverView.m
//  NiuVideo
//
//  Created by hxiongan on 2017/12/15.
//  Copyright © 2017年 Pili Engineering, Qiniu Inc. All rights reserved.
//

#import "NVLiveCoverView.h"

//避免用户没有实现crash或者每次调用都要判断有没有实现
@implementation NSObject (LiveCover)
- (void)liveCoverViewCloseAction:(NVLiveCoverView*)liveCoverView{}
- (void)liveCoverViewShareAction:(NVLiveCoverView*)liveCoverView{}
- (void)liveCoverViewMessageAction:(NVLiveCoverView*)liveCoverView{}
- (void)liveCoverViewCommentAction:(NVLiveCoverView*)liveCoverView{}
- (void)liveCoverViewSettingAction:(NVLiveCoverView*)liveCoverView{}
@end

@interface NVLiveCoverView () {
    
}

@property (nonatomic, strong) UIView* topBarView;
@property (nonatomic, strong) UIView* bottomBarView;

@property (nonatomic, strong) UIButton *closeButton;
@property (nonatomic, strong) UIButton *settingButton;
@property (nonatomic, strong) UIButton *shareButton;
@property (nonatomic, strong) UIButton *messageButton;
@property (nonatomic, strong) UIButton *commentButton;

@end;

@implementation NVLiveCoverView

- (void)dealloc {
    printf("\n[dealloc] %s", [NSStringFromClass(self.class) UTF8String]);
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
        UIView* superView   = self;
        
        self.topBarView     = [[UIView alloc] init];
        self.bottomBarView  = [[UIView alloc] init];
        
        [superView addSubview:self.topBarView];
        [superView addSubview:self.bottomBarView];
        
        [self.topBarView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.equalTo(superView);
            make.height.equalTo(NV_SAFE_TOP_HEIGHT_NAV);
        }];
        
        [self.bottomBarView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.equalTo(superView);
            make.height.equalTo(NV_SAFE_BOTTOM_HEIGHT);
        }];
        
        NSString* buttonImages[] = {
            @"live_streaming_set",
            @"live_streaming_close",
            @"live_share",
            @"live_comment",
            @"live_toolbox",
        };
        
        SEL selecters[] = {
            @selector(clickSettingButton),
            @selector(clickCloseButton),
            @selector(clickShareButton),
            @selector(clickMessageButton),
            @selector(clickControlButton),
        };

        UIButton* __strong* buttons[5] = { &_settingButton, &_closeButton, &_shareButton, &_messageButton, &_commentButton};
        for (int i = 0; i < ARRAY_SIZE(buttonImages); i ++) {
            *buttons[i] = [UIButton buttonWithType:(UIButtonTypeSystem)];
            [*buttons[i] setTintColor:NV_WHITE_COLOR];
            [*buttons[i] setImage:[UIImage imageNamed:buttonImages[i]] forState:(UIControlStateNormal)];
            [*buttons[i] addTarget:self action:selecters[i] forControlEvents:(UIControlEventTouchUpInside)];
            if (0 == i) {
                [self.topBarView addSubview:*buttons[i]];
            } else {
                [self.bottomBarView addSubview:*buttons[i]];
            }
        }

        superView = self.topBarView;
        CGSize buttonSize = CGSizeMake(44, 44);
        [_settingButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.equalTo(buttonSize);
            make.bottom.right.equalTo(superView);
        }];
        
        superView = self.bottomBarView;
        [_closeButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.equalTo(buttonSize);
            make.top.right.equalTo(superView);
        }];
        
        [_shareButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.equalTo(buttonSize);
            make.top.equalTo(superView);
            make.right.equalTo(_closeButton.mas_left);
        }];
        
        [_commentButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.equalTo(buttonSize);
            make.top.equalTo(superView);
            make.right.equalTo(_shareButton.mas_left);
        }];
        
        [_messageButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.equalTo(buttonSize);
            make.top.equalTo(superView);
            make.left.equalTo(superView);
        }];
    }
    return self;
}

- (void)setIsPushLive:(BOOL)isPushLive {
    _isPushLive = isPushLive;
    self.commentButton.hidden = !isPushLive;
}

- (void)clickCloseButton {
    [self.delegate liveCoverViewCloseAction:self];
}

- (void)clickSettingButton {
    [self.delegate liveCoverViewSettingAction:self];
}

- (void)clickShareButton {
    [self.delegate liveCoverViewShareAction:self];
}

- (void)clickMessageButton {
    [self.delegate liveCoverViewMessageAction:self];
}

- (void)clickControlButton {
    [self.delegate liveCoverViewCommentAction:self];
}

@end
