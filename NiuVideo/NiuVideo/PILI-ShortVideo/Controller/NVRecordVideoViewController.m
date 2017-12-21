//
//  NVRecordVideoViewController.m
//  NiuVideo
//
//  Created by 冯文秀 on 2017/12/12.
//  Copyright © 2017年 Pili Engineering, Qiniu Inc. All rights reserved.
//

#import "NVRecordVideoViewController.h"
#import "NVProcessVideoViewController.h"
#import <AVFoundation/AVFoundation.h>
#define NV_RECORD_Y_SPACE 64
#define NV_RECORD_BUTTON_WIDTH (80.f * NV_WIDTH_RATIO)


@interface NVRecordVideoViewController ()


@property (nonatomic, strong) UIView *recordToolboxView;
// 录屏按钮
@property (nonatomic, strong) UIButton *viewRecordButton;
@property (nonatomic, strong) UIButton *recordButton;
@property (nonatomic, strong) UIButton *deleteButton;
@property (nonatomic, strong) UIButton *nextButton;
@property (nonatomic, strong) UIButton *faceButton;
@property (nonatomic, strong) UIButton *beautyButton;
@property (nonatomic, strong) UIButton *importButton;

@end

@implementation NVRecordVideoViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if(!NV_IPHONE_X) {
        [UIApplication sharedApplication].statusBarHidden = YES;
    }
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [UIApplication sharedApplication].statusBarHidden = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = NV_WHITE_COLOR;

    [self setupNavigationItem];
    [self setupRecordToolboxView];
}

- (void)setupNavigationItem {
    self.navigationItem.title = @"录制视频";
    UIButton *backButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 30, 20)];
    [backButton setImage:[UIImage imageNamed:@"drop_down"] forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(backButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *setButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 30, 20)];
    [setButton setImage:[UIImage imageNamed:@"set_icon"] forState:UIControlStateNormal];
    [setButton addTarget:self action:@selector(setButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *backBarButton = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    UIBarButtonItem *setBarButton = [[UIBarButtonItem alloc] initWithCustomView:setButton];
    self.navigationItem.leftBarButtonItems = @[backBarButton,setBarButton];

    
    UIButton *flashButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 30, 20)];
    [flashButton setImage:[UIImage imageNamed:@"flash_light_close"] forState:UIControlStateNormal];
    [flashButton setImage:[UIImage imageNamed:@"flash_light_open"] forState:UIControlStateSelected];
    [flashButton addTarget:self action:@selector(flashButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *cameraButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 30, 20)];
    [cameraButton setImage:[UIImage imageNamed:@"switch_camera"] forState:UIControlStateNormal];
    [cameraButton addTarget:self action:@selector(cameraButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *flashBarButton = [[UIBarButtonItem alloc] initWithCustomView:flashButton];
    UIBarButtonItem *cameraBarButton = [[UIBarButtonItem alloc] initWithCustomView:cameraButton];
    self.navigationItem.rightBarButtonItems = @[cameraBarButton,flashBarButton,];
}

- (void)setupRecordToolboxView {
    CGFloat y = NV_RECORD_Y_SPACE + NV_SCREEN_WIDTH;
    self.recordToolboxView = [[UIView alloc] initWithFrame:CGRectMake(0, y, NV_SCREEN_WIDTH, NV_SCREEN_HEIGHT - y)];
    self.recordToolboxView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:self.recordToolboxView];
    
    // 录制按钮
    NSInteger buttonWidth = (NSInteger)NV_RECORD_BUTTON_WIDTH;
    self.recordButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, buttonWidth, buttonWidth)];
    self.recordButton.center = CGPointMake(NV_SCREEN_WIDTH / 2, self.recordToolboxView.frame.size.height - 80);
    CGFloat buttonRadius = (CGFloat)buttonWidth/2;
    self.recordButton.layer.cornerRadius = buttonRadius;
    self.recordButton.layer.borderColor = NV_BUTTON_RECORD_BORDER.CGColor;
    self.recordButton.layer.borderWidth = 8.f * NV_WIDTH_RATIO;
    self.recordButton.backgroundColor = NV_BLACK_COLOR;
    [self.recordButton setImage:[UIImage imageNamed:@"short_video_white"] forState:UIControlStateNormal];
    [self.recordButton addTarget:self action:@selector(recordButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.recordToolboxView addSubview:_recordButton];
    
    CGFloat centerY = self.recordButton.center.y - (buttonWidth/2 - 18);
    // 回删按钮
    self.deleteButton = [[UIButton alloc] initWithFrame:CGRectMake(NV_SCREEN_WIDTH - 106, centerY, 34, 34)];
    self.deleteButton.backgroundColor = NV_BUTTON_GRAY_COLOR;
    self.deleteButton.layer.cornerRadius = 17;
    [self.deleteButton setImage:[UIImage imageNamed:@"delete"] forState:UIControlStateNormal];
    [self.deleteButton addTarget:self action:@selector(deleteButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.recordToolboxView addSubview:_deleteButton];
//    self.deleteButton.hidden = YES;
    
    // 结束录制按钮
    self.nextButton = [[UIButton alloc] initWithFrame:CGRectMake(NV_SCREEN_WIDTH - 55, centerY, 34, 34)];
    self.nextButton.backgroundColor = NV_BUTTON_GRAY_COLOR;
    self.nextButton.layer.cornerRadius = 17;
    [self.nextButton setImage:[UIImage imageNamed:@"ready_yes"] forState:UIControlStateNormal];
    [self.nextButton setImage:[UIImage imageNamed:@"ready_no"] forState:UIControlStateDisabled];
    [self.nextButton addTarget:self action:@selector(nextButtonAction:) forControlEvents:UIControlEventTouchUpInside];
//    self.nextButton.enabled = NO;
    [self.recordToolboxView addSubview:_nextButton];
//    self.nextButton.hidden = YES;
    
    // 表情特效按钮
    self.faceButton = [[UIButton alloc] initWithFrame:CGRectMake(18/NV_WIDTH_RATIO, centerY, 30, 42)];
    [self.faceButton addTarget:self action:@selector(faceButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.recordToolboxView addSubview:_faceButton];
    
    // 美颜按钮
    self.beautyButton = [[UIButton alloc] initWithFrame:CGRectMake(68/NV_WIDTH_RATIO, centerY, 30, 42)];
    [self.beautyButton addTarget:self action:@selector(beautyButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.recordToolboxView addSubview:_beautyButton];
    
    // 导入视频按钮
    self.importButton = [[UIButton alloc] initWithFrame:CGRectMake(NV_SCREEN_WIDTH - 82, centerY, 30, 42)];
    [self.importButton addTarget:self action:@selector(importButtonAction:) forControlEvents:UIControlEventTouchUpInside];
//    [self.recordToolboxView addSubview:_importButton];
    
    [self unifyButtonStyleWithButtons:@[self.faceButton, self.beautyButton, self.importButton]];
}

#pragma mark - method

- (void)unifyButtonStyleWithButtons:(NSArray *)buttons {
    NSArray *titleArray = @[@"表情", @"美颜", @"导入"];
    NSArray *imagesArray = @[@"face_check", @"face_beauty", @"import_movie"];
    for (NSInteger i = 0; i < buttons.count; i++) {
        UIButton *button = buttons[i];
        [button setImage:[UIImage imageNamed:imagesArray[i]] forState:UIControlStateNormal];
        [button setTitle:titleArray[i] forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:11.f];
        [button setTitleColor:NV_BLACK_COLOR forState:UIControlStateNormal];
        [button setImageEdgeInsets:UIEdgeInsetsMake(0, 5, 16, 0)];
        [button setTitleEdgeInsets:UIEdgeInsetsMake(28, -21, 0, 0)];
    }
}

- (void)backButtonAction:(UIButton *)backButton {
    [self dismissViewControllerAnimated:YES completion:nil];
}

// 录制相关设置
- (void)setButtonAction:(UIButton *)setButton {
    
}

// 打开／关闭闪光灯
- (void)flashButtonAction:(UIButton *)flashButton {
}

// 切换摄像头
- (void)cameraButtonAction:(UIButton *)cameraButton {
}

// 录制／暂停
- (void)recordButtonAction:(UIButton *)recordButton {
}

// 录屏
- (void)viewRecordButtonAction:(UIButton *)viewRecordButton {
}

// 回删
- (void)deleteButtonAction:(UIButton *)deleteButton {
}

// 下一步
- (void)nextButtonAction:(UIButton *)nextButton {
    AVAsset *asset;
    [self enterProcessVideoViewWithAsset:asset];
}

// 特效
- (void)faceButtonAction:(UIButton *)faceButton {
}

// 美颜
- (void)beautyButtonAction:(UIButton *)beautyButton {
}

- (void)importButtonAction:(UIButton *)importButton {
}

- (void)enterProcessVideoViewWithAsset:(AVAsset *)asset {;
    NVProcessVideoViewController *processVideoVC = [[NVProcessVideoViewController alloc] init];
    [self.navigationController pushViewController:processVideoVC animated:YES];
}

#pragma mark ---- dealloc ----

- (void)dealloc {
    NSLog(@"dealloc: %@", [[self class] description]);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
