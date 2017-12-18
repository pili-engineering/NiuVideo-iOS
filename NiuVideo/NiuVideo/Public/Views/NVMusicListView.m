//
//  NVMusicListView.m
//  NiuVideo
//
//  Created by 冯文秀 on 2017/12/14.
//  Copyright © 2017年 Pili Engineering, Qiniu Inc. All rights reserved.
//

#import "NVMusicListView.h"


static NSString *const cellIdentifier = @"musicListCell";

@interface NVMusicListView ()
<
UITableViewDelegate,
UITableViewDataSource
>

@property (nonatomic, strong) UITableView *listTableView;
@property (nonatomic, strong) NSArray *listArray;
@property (nonatomic, assign) NSInteger selectedIndex;

@end
@implementation NVMusicListView
- (id)initWithFrame:(CGRect)frame listArray:(NSArray *)listArray {
    self = [super initWithFrame:frame];
    if (self) {
        [self setupMusicListTableView];
    }
    return self;
}

- (void)setupMusicListTableView {
    self.selectedIndex = 0;
    self.listTableView = [[UITableView alloc] initWithFrame:self.frame style:UITableViewStylePlain];
    self.listTableView.delegate = self;
    self.listTableView.dataSource = self;
    self.listTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.listTableView registerClass:[NVMusicViewCell class] forCellReuseIdentifier:cellIdentifier];
    [self addSubview:_listTableView];
}

#pragma mark - tableView delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _listArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NVMusicViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    BOOL selected = NO;
    if (indexPath.row == _selectedIndex) {
        selected = YES;
    }
    [cell configureMusicViewCellWithSelected:selected musicString:_listArray[indexPath.row]];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.delegate && [self.delegate respondsToSelector:@selector(musicListView:didSelectedIndex:)]) {
        [self.delegate musicListView:self didSelectedIndex:indexPath.row];
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

@interface NVMusicViewCell ()
@property (nonatomic, strong) UIImageView *musicImageView;
@property (nonatomic, strong) UILabel *musicLabel;
@property (nonatomic, strong) UIImageView *selectImageView;

@end

@implementation NVMusicViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.musicImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 14, 14, 16)];
        [self.contentView addSubview:_musicImageView];
        
        self.musicLabel = [[UILabel alloc] initWithFrame:CGRectMake(34, 12, NV_SCREEN_WIDTH - 72, 20)];
        self.musicLabel.font = NV_LIGHT_FONT(14);
        self.musicLabel.textColor = NV_TEXT_BLACK_COLOR;
        [self.contentView addSubview:_musicLabel];
        
        self.selectImageView = [[UIImageView alloc] initWithFrame:CGRectMake(NV_SCREEN_WIDTH - 36, 17, 14, 10)];
        self.selectImageView.image = [UIImage imageNamed:@"ready_yes"];
        self.selectImageView.hidden = YES;
        [self addSubview:_selectImageView];
        
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 43.5, NV_SCREEN_WIDTH, 0.5)];
        lineView.backgroundColor = NV_TEXT_GRAY_COLOR;
        [self.contentView addSubview:lineView];
    }
    return self;
}

- (void)configureMusicViewCellWithSelected:(BOOL)selected musicString:(NSString *)musicString{
    self.musicLabel.text = musicString;
    if (selected) {
        self.selectImageView.hidden = NO;
        self.musicImageView.image = [UIImage imageNamed:@"music_active"];
        self.musicLabel.textColor = NV_TEXT_BLACK_COLOR;
    } else{
        self.selectImageView.hidden = YES;
        self.musicImageView.image = [UIImage imageNamed:@"music"];
        self.musicLabel.textColor = NV_TEXT_GRAY_COLOR;
    }
}


@end
