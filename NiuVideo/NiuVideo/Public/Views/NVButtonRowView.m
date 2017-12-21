//
//  NVButtonRowView.m
//  NiuVideo
//
//  Created by 冯文秀 on 2017/12/13.
//  Copyright © 2017年 Pili Engineering, Qiniu Inc. All rights reserved.
//

#import "NVButtonRowView.h"
#define NV_BUTTONS_WIDTH 36.f
#define NV_BUTTONS_HEIGHT 42.f

@interface NVButtonRowView ()
@property (nonatomic, strong) NSArray *titleArray;
@property (nonatomic, strong) NSArray *imagesArray;
@property (nonatomic, strong) NSArray *selectedImagesArray;

@property (nonatomic, assign) NSInteger selectedIndex;
@property (nonatomic, assign) CGFloat space;
@property (nonatomic, assign) CGFloat averageXSpace;
@property (nonatomic, assign) CGFloat averageYSpace;

@end

@implementation NVButtonRowView

- (id)initWithFrame:(CGRect)frame infoDictionary:(NSDictionary *)infoDictionary space:(CGFloat)space{
    self = [super initWithFrame:frame];
    if (self) {
        if (infoDictionary[@"titles"] && [infoDictionary[@"titles"] count] > 1) {
            _titleArray = infoDictionary[@"titles"];
        } else {
            return self;
        }
        
        if (infoDictionary[@"images"] && [infoDictionary[@"images"] count] > 1) {
            _imagesArray = infoDictionary[@"images"];
        } else {
            return self;
        }
        
        if (infoDictionary[@"selectedImages"] && [infoDictionary[@"selectedImages"] count] > 1) {
            _selectedImagesArray = infoDictionary[@"selectedImages"];
        } else {
            return self;
        }
        
        [self setupbuttonRowView:space];
    }
    return self;
}


- (void)setupbuttonRowView:(CGFloat)space {
    CGFloat frameWidth = CGRectGetWidth(self.frame);
    CGFloat frameHeight = CGRectGetHeight(self.frame);
    
    if (_imagesArray.count < 4 && _titleArray.count < 4) {
        if (space <= 0) {
            _averageXSpace = (frameWidth - _imagesArray.count * NV_BUTTONS_WIDTH)/(_imagesArray.count + 1);
            _space = _averageXSpace;
        } else{
            _space = space;
            _averageXSpace = (frameWidth - _imagesArray.count * NV_BUTTONS_WIDTH - _space * 2)/(_imagesArray.count - 1);
        }
        _averageYSpace = (frameHeight - NV_BUTTONS_HEIGHT)/2;
    } else{
        if (space <= 0) {
            _averageXSpace = (frameWidth - 4 * NV_BUTTONS_WIDTH)/5;
            _space = _averageXSpace;
        } else{
            _space = space;
            _averageXSpace = (frameWidth - 4 * NV_BUTTONS_WIDTH - space * 2)/3;
        }
        NSInteger rowsCount = _imagesArray.count/4;
        NSInteger remain = _imagesArray.count%4;
        if (remain > 0) {
            rowsCount++;
        }
        _averageYSpace = (frameHeight - NV_BUTTONS_HEIGHT * rowsCount)/(rowsCount + 1);
    }
    [_imagesArray enumerateObjectsUsingBlock:^(NSString *str, NSUInteger idx, BOOL *stop) {
        CGFloat xSpace;
        CGFloat ySpace;
        
        NSInteger count = idx + 1;
        NSInteger rowsCount = count/4;
        NSInteger remain = count%4;
        if (remain > 0) {
            rowsCount++;
            remain--;
        } else {
            remain = 3;
        }
        xSpace = _space + (NV_BUTTONS_WIDTH + _averageXSpace) * remain;
        ySpace = _averageYSpace * rowsCount + 42 * (rowsCount - 1);
        
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(xSpace, ySpace, NV_BUTTONS_WIDTH, NV_BUTTONS_HEIGHT)];
        button.tag = 100 + idx;
        button.adjustsImageWhenHighlighted = NO;
        [button setImage:[UIImage imageNamed:_imagesArray[idx]] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:_selectedImagesArray[idx]] forState:UIControlStateSelected];
        [button setTitle:_titleArray[idx] forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:11.f];
        [button setTitleColor:NV_COLOR_RGBA(178, 178, 178, 1) forState:UIControlStateNormal];
        [button setTitleColor:NV_BLACK_COLOR forState:UIControlStateSelected];
        [button setImageEdgeInsets:UIEdgeInsetsMake(0, 8, 16, 0)];
        [button setTitleEdgeInsets:UIEdgeInsetsMake(28, -20, 0, 0)];
        [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button];
        
        if (idx == 0) {
            button.selected = YES;
            _selectedIndex = 0;
        }
    }];
}

- (void)buttonAction:(UIButton *)button {
    NSInteger index = button.tag - 100;
    for (UIButton *viewButton in self.subviews) {
        if (viewButton.tag == button.tag) {
            if (_selectedIndex == index) {
                return;
            }
            _selectedIndex = index;
            viewButton.selected = YES;
        } else{
            viewButton.selected = NO;
        }
    }
    if (self.delegate && [self.delegate respondsToSelector:@selector(buttonRowView:didSelectedIndex:)]) {
        [self.delegate buttonRowView:self didSelectedIndex:index];
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
