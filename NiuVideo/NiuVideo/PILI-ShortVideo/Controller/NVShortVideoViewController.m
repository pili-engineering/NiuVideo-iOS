//
//  NVShortVideoViewController.m
//  NiuVideo
//
//  Created by 冯文秀 on 2017/12/5.
//  Copyright © 2017年 Pili Engineering, Qiniu Inc. All rights reserved.
//

#import "NVShortVideoViewController.h"

@interface NVShortVideoViewController ()

@end

@implementation NVShortVideoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupNavigationItem];
}

- (void)setupNavigationItem {
    self.navigationItem.title = @"短视频";
    
    UIBarButtonItem *leftBarButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"qr_code"] style:UIBarButtonItemStylePlain target:self action:@selector(leftBarButtonAction)];
    self.navigationItem.leftBarButtonItem = leftBarButton;
    self.navigationItem.leftBarButtonItem.tintColor = NV_BLACK_COLOR;
    
    UIBarButtonItem *rightBarButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"url_link"] style:UIBarButtonItemStylePlain target:self action:@selector(rightBarButtonAction)];
    self.navigationItem.rightBarButtonItem = rightBarButton;
    self.navigationItem.rightBarButtonItem.tintColor = NV_BLACK_COLOR;
}

#pragma mark ---- leftBarButton ----

- (void)leftBarButtonAction {
    
}

#pragma mark ---- rightBarButton ----

- (void)rightBarButtonAction {
    
}

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
