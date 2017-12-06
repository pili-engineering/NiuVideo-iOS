//
//  NVSelectClassView.m
//  NiuVideo
//
//  Created by 冯文秀 on 2017/12/5.
//  Copyright © 2017年 Pili Engineering, Qiniu Inc. All rights reserved.
//

#import "NVSelectClassView.h"

@interface NVSelectClassView ()
@property (nonatomic, strong) UIButton *shortVideoButton;
@property (nonatomic, strong) UIButton *liveStreamButton;
@property (nonatomic, strong) UILabel *shortVideoLabel;
@property (nonatomic, strong) UILabel *liveStreamLabel;

@end

@implementation NVSelectClassView

- (instancetype)initWithFrame:(CGRect)frame superView:(UIView *)superView{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = NV_BLACK_POP_COLOR;
        self.frame = CGRectMake(0, NV_SCREEN_HEIGHT, NV_SCREEN_WIDTH, 252 * NV_HEIGHT_RATIO);
        
        CGFloat xSpaceOne = 86 * NV_WIDTH_RATIO;
        CGFloat ySpaceOne = 40 * NV_WIDTH_RATIO;

        CGFloat xSpaceTwo = 224 * NV_WIDTH_RATIO;
        CGFloat ySpaceTwo = 118 * NV_WIDTH_RATIO;

        
        CGFloat buttonWidth = 68 * NV_WIDTH_RATIO;

        // 短视频
        self.shortVideoButton = [[UIButton alloc]initWithFrame:CGRectMake(xSpaceOne, ySpaceOne, buttonWidth, buttonWidth)];
        self.shortVideoButton.backgroundColor = NV_BUTTON_BLACKBG;
        self.shortVideoButton.layer.cornerRadius = buttonWidth/2;
        [self.shortVideoButton setImage:[UIImage imageNamed:@"short_video_white"] forState:UIControlStateNormal];
        [self.shortVideoButton addTarget:self action:@selector(buttonSelectedAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_shortVideoButton];
        
        self.shortVideoLabel = [[UILabel alloc]initWithFrame:CGRectMake(xSpaceOne, ySpaceTwo, buttonWidth, 24)];
        self.shortVideoLabel.textAlignment = NSTextAlignmentCenter;
        self.shortVideoLabel.textColor = NV_BUTTON_BLACKBG;
        self.shortVideoLabel.font = NV_REGULAR_FONT(16);
        self.shortVideoLabel.text = @"短视频";
        [self addSubview:_shortVideoLabel];
        
        // 直播
        self.liveStreamButton = [[UIButton alloc]initWithFrame:CGRectMake(xSpaceTwo, ySpaceOne, buttonWidth, buttonWidth)];
        self.liveStreamButton.backgroundColor = NV_BUTTON_BLACKBG;
        self.liveStreamButton.layer.cornerRadius = buttonWidth/2;
        [self.liveStreamButton setImage:[UIImage imageNamed:@"live_white"] forState:UIControlStateNormal];
        [self.liveStreamButton addTarget:self action:@selector(buttonSelectedAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_liveStreamButton];
        
        self.liveStreamLabel = [[UILabel alloc]initWithFrame:CGRectMake(xSpaceTwo, ySpaceTwo,  buttonWidth, 24)];
        self.liveStreamLabel.textAlignment = NSTextAlignmentCenter;
        self.liveStreamLabel.textColor = NV_BUTTON_BLACKBG;
        self.liveStreamLabel.font = NV_REGULAR_FONT(16);
        self.liveStreamLabel.text = @"直播";
        [self addSubview:_liveStreamLabel];
        
        UIButton *cancelButton = [[UIButton alloc]initWithFrame:CGRectMake(NV_SCREEN_WIDTH/2 - 12 * NV_WIDTH_RATIO, 192 * NV_HEIGHT_RATIO, 24 * NV_WIDTH_RATIO, 24 * NV_WIDTH_RATIO)];
        [cancelButton setImage:[UIImage imageNamed:@"close"] forState:UIControlStateNormal];
        [cancelButton addTarget:self action:@selector(selectCancelButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:cancelButton];

        if (superView && [superView isKindOfClass:[UIView class]]) {
            [superView addSubview:self];
        } else{
            NSLog(@"NVSelectClassView : did not set super view!");
        }
    }
    return self;
}


#pragma mark - private
- (void)buttonSelectedAction:(UIButton *)button {
    NSInteger index = 0;
    if (![button isEqual:_shortVideoButton]) {
        index = 1;
    }
    
    if (self.delegate != nil && [self.delegate respondsToSelector:@selector(classView:didSelectedIndex:)]) {
        [self.delegate classView:self didSelectedIndex:index];
    }
}

- (void)selectCancelButtonAction:(UIButton *)closeButton {
    if (self.delegate != nil && [self.delegate respondsToSelector:@selector(classView:selectedCloseButton:)]) {
        [self.delegate classView:self selectedCloseButton:closeButton];
    }
    [self cancelSelectClassView];
}

#pragma mark - public

- (void)popSelectClassView {
    if (self.superview) {
        [UIView animateWithDuration:0.3 animations:^{
            self.frame = CGRectMake(0, NV_SCREEN_HEIGHT - 252 * NV_HEIGHT_RATIO, NV_SCREEN_WIDTH, 252 * NV_HEIGHT_RATIO);
        }];
    }
}

- (void)cancelSelectClassView {
    [UIView animateWithDuration:0.3 animations:^{
        self.frame = CGRectMake(0, NV_SCREEN_HEIGHT, NV_SCREEN_WIDTH, 252 * NV_HEIGHT_RATIO);
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
