//
//  NVProcessVideoViewController.m
//  NiuVideo
//
//  Created by 冯文秀 on 2017/12/12.
//  Copyright © 2017年 Pili Engineering, Qiniu Inc. All rights reserved.
//

#import "NVProcessVideoViewController.h"
#import "NVPublishVideoViewController.h"

#import "NVButtonRowView.h"

@interface NVProcessVideoViewController ()
<
NVButtonRowViewDelegate
>
@property (nonatomic, assign) NSInteger selectedIndex;
@property (nonatomic, strong) NSArray *titleArray;
@property (nonatomic, strong) NVButtonRowView *buttonRowView;

@property (nonatomic, strong) UIView *processToolboxView;

@end

@implementation NVProcessVideoViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if(!NV_IPHONE_X) {
        [UIApplication sharedApplication].statusBarHidden = YES;
    }
    self.buttonRowView.hidden = NO;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [UIApplication sharedApplication].statusBarHidden = NO;
    self.buttonRowView.hidden = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = NV_WHITE_COLOR;
    
    self.selectedIndex = 0;
    self.titleArray = @[@"滤镜编辑",@"MV 特效",@"背景音乐",@"剪辑拼接"];
    
    [self setupNavigationItem];
    
    [self setupVideoPreview];
    [self setupPeocessToolboxView];

    
    
}

- (void)setupNavigationItem {
    self.navigationItem.title = self.titleArray[_selectedIndex];
    UIButton *backButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 52, 24)];
    [backButton setImage:[UIImage imageNamed:@"go_back"] forState:UIControlStateNormal];
    [backButton setTitle:@"返回" forState:UIControlStateNormal];
    backButton.titleLabel.font = [UIFont systemFontOfSize:15];
    [backButton setTitleColor:NV_BLACK_COLOR forState:UIControlStateNormal];
    [backButton setImageEdgeInsets:UIEdgeInsetsMake(0, -12, 0, 0)];
    [backButton setTitleEdgeInsets:UIEdgeInsetsMake(0, 8, 0, 0)];
    [backButton addTarget:self action:@selector(backButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *nextButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 66, 24)];
    [nextButton setImage:[UIImage imageNamed:@"next_step"] forState:UIControlStateNormal];
    [nextButton setTitle:@"下一步" forState:UIControlStateNormal];
    nextButton.titleLabel.font = [UIFont systemFontOfSize:15];
    [nextButton setTitleColor:NV_BLACK_COLOR forState:UIControlStateNormal];
    [nextButton setImageEdgeInsets:UIEdgeInsetsMake(0, 57, 0, 0)];
    [nextButton setTitleEdgeInsets:UIEdgeInsetsMake(0, -28, 0, 0)];
    [nextButton addTarget:self action:@selector(nextButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:nextButton];
}

- (void)buttonRowView:(NVButtonRowView *)buttonRowView didSelectedIndex:(NSInteger)index {
    self.selectedIndex = index;
    self.navigationItem.title = self.titleArray[_selectedIndex];
    switch (index) {
        case 0:{
            
        }
            break;
        case 1:{
            
        }
            break;
        case 2:{
            
        }
            break;
        case 3:{
            
        }
            break;
        default:
            break;
    }
}

- (void)setupVideoPreview {
    
}

- (void)setupPeocessToolboxView {
    
    NSInteger sapce = 32 * NV_WIDTH_RATIO;
    self.buttonRowView = [[NVButtonRowView alloc] initWithFrame:CGRectMake(0, NV_SCREEN_HEIGHT - 69, NV_SCREEN_WIDTH, 69) infoDictionary:@{@"titles":@[@"滤镜",@"MV",@"音乐",@"编辑"],@"images":@[@"filter",@"mv",@"music",@"edit"],@"selectedImages":@[@"filter_active",@"mv_active",@"music_active",@"edit_active"]} space:sapce];
    self.buttonRowView.delegate = self;
    [self.view addSubview:_buttonRowView];
}

#pragma mark - button action

- (void)backButtonAction:(UIButton *)backButton {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)nextButtonAction:(UIButton *)nextButton {
    NVPublishVideoViewController *publishVideoVC = [[NVPublishVideoViewController alloc] init];
    [self.navigationController pushViewController:publishVideoVC animated:YES];
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
