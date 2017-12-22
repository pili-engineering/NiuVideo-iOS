//
//  NVStartLiveView.m
//  NiuVideo
//
//  Created by hxiongan on 2017/12/21.
//  Copyright © 2017年 Pili Engineering, Qiniu Inc. All rights reserved.
//

#import "NVStartLiveView.h"

@interface NVStartLiveView ()
<
UITextFieldDelegate
>

@property (nonatomic, strong) UITextField   *titleTextfield;
@property (nonatomic, strong) UIButton      *startLiveButton;
@property (nonatomic, strong) UIButton      *closeButton;

@property (nonatomic, strong) UIVisualEffectView *effectView;
@end

@implementation NVStartLiveView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
        UIVisualEffect *effect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
        self.effectView = [[UIVisualEffectView alloc] initWithEffect:effect];
        [self addSubview:_effectView];
        [self.effectView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self);
        }];
        
        _closeButton = [UIButton buttonWithType:(UIButtonTypeSystem)];
        [_closeButton setTintColor: NV_WHITE_COLOR];
        [_closeButton setImage:[UIImage imageNamed:@"live_streaming_close"] forState:(UIControlStateNormal)];
        [_closeButton addTarget:self action:@selector(clickCloseButton) forControlEvents:(UIControlEventTouchUpInside)];
        
        _startLiveButton = [UIButton buttonWithType:(UIButtonTypeSystem)];
        [_startLiveButton setBackgroundColor:NV_WHITE_COLOR];
        [_startLiveButton setTitle:@"开始直播" forState:(UIControlStateNormal)];
        [_startLiveButton setTitleColor:NV_BLACK_COLOR forState:(UIControlStateNormal)];
        [_startLiveButton addTarget:self action:@selector(clickStartLiveButton) forControlEvents:(UIControlEventTouchUpInside)];
        _startLiveButton.layer.cornerRadius = 44 / 2;
        
        _titleTextfield = [[UITextField alloc] init];
        _titleTextfield.returnKeyType   = UIReturnKeyDone;
        _titleTextfield.delegate        = self;
        _titleTextfield.textColor       = [UIColor whiteColor];
        _titleTextfield.textAlignment   = NSTextAlignmentCenter;
        _titleTextfield.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"给直播写个标题吧" attributes:@{NSForegroundColorAttributeName : [UIColor colorWithWhite:1.0 alpha:.5]}];
        
        UIView *whiteLine = [[UIView alloc] init];
        whiteLine.backgroundColor = [UIColor colorWithWhite:1.0 alpha:.5];
        
        UIView *superView = self;
        
        [superView addSubview:_closeButton];
        [superView addSubview:_startLiveButton];
        [superView addSubview:_titleTextfield];
        [superView addSubview:whiteLine];
        
        [_closeButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.equalTo(CGSizeMake(44, 44));
            make.top.equalTo(20);
            make.right.equalTo(superView);
        }];
        
        [_startLiveButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(superView);
            make.width.equalTo(250);
            make.height.equalTo(44);
            make.bottom.equalTo(superView).offset(-70);
        }];
        
        [_titleTextfield mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(superView);
            make.width.equalTo(200);
            make.height.equalTo(44);
            make.centerY.equalTo(superView).offset(-60);
        }];
        
        [whiteLine mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(_titleTextfield);
            make.top.equalTo(_titleTextfield.mas_bottom);
            make.height.equalTo(1);
        }];
    }
    return self;
}

- (void)clickCloseButton {
    [self.delegate startLiveViewCloseButtonClick:self];
}

- (void)clickStartLiveButton {
    [self.delegate startLiveView:self startLiveWithTitle:self.titleTextfield.text];
}

#pragma mark -UITextFieldelegate

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
};

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

@end
