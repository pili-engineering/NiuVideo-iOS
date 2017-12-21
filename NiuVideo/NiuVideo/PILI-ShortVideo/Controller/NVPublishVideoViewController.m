//
//  NVPublishVideoViewController.m
//  NiuVideo
//
//  Created by 冯文秀 on 2017/12/12.
//  Copyright © 2017年 Pili Engineering, Qiniu Inc. All rights reserved.
//

#import "NVPublishVideoViewController.h"

@interface NVPublishVideoViewController ()

@end

@implementation NVPublishVideoViewController

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
    [self setupNavigationItem];
}

- (void)setupNavigationItem {
    self.navigationItem.title = @"发布分享";
    UIButton *backButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 52, 24)];
    [backButton setImage:[UIImage imageNamed:@"go_back"] forState:UIControlStateNormal];
    [backButton setTitle:@"返回" forState:UIControlStateNormal];
    backButton.titleLabel.font = [UIFont systemFontOfSize:15];
    [backButton setTitleColor:NV_BLACK_COLOR forState:UIControlStateNormal];
    [backButton setImageEdgeInsets:UIEdgeInsetsMake(0, -12, 0, 0)];
    [backButton setTitleEdgeInsets:UIEdgeInsetsMake(0, 8, 0, 0)];
    [backButton addTarget:self action:@selector(backButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *draftButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 62, 24)];
    [draftButton setImage:[UIImage imageNamed:@"draft"] forState:UIControlStateNormal];
    [draftButton setTitle:@"草稿" forState:UIControlStateNormal];
    draftButton.titleLabel.font = [UIFont systemFontOfSize:15];
    [draftButton setTitleColor:NV_BLACK_COLOR forState:UIControlStateNormal];
    [draftButton setImageEdgeInsets:UIEdgeInsetsMake(0, -10, 0, 0)];
    [draftButton setTitleEdgeInsets:UIEdgeInsetsMake(0, 7, 0, 0)];
    [draftButton addTarget:self action:@selector(draftButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:draftButton];
}

#pragma mark - button action

- (void)backButtonAction:(UIButton *)backButton {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)draftButtonAction:(UIButton *)draftButton {
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
