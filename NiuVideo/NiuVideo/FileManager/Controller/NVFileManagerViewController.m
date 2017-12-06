//
//  NVFileManagerViewController.m
//  NiuVideo
//
//  Created by 冯文秀 on 2017/12/5.
//  Copyright © 2017年 Pili Engineering, Qiniu Inc. All rights reserved.
//

#import "NVFileManagerViewController.h"

@interface NVFileManagerViewController ()

@end

@implementation NVFileManagerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupNavigationItem];
}

- (void)setupNavigationItem {
    self.navigationItem.title = @"文件";
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
