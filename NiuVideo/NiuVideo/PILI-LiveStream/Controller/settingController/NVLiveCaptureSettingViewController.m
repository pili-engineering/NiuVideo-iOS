//
//  NVLiveCaptureSettingViewController.m
//  NiuVideo
//
//  Created by hxiongan on 2017/12/15.
//  Copyright © 2017年 Pili Engineering, Qiniu Inc. All rights reserved.
//

#import "NVLiveCaptureSettingViewController.h"

@interface NVLiveCaptureSettingViewController ()
@property (nonatomic, strong)NSMutableArray *itemArray;
@end

@implementation NVLiveCaptureSettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.itemArray = [[NSMutableArray alloc] init];
    
    NVLiveSettingItem* item = [[NVLiveSettingItem alloc] init];
    item.title              = @"预览尺寸设置";
    item.values             = @[@"小", @"中", @"大"];
    item.itemType           = NVSettingItemPreviewSize;
    item.selectedValueIndex = 0;
    
    [self.itemArray addObject:item];
    
    item                    = [[NVLiveSettingItem alloc] init];
    item.title              = @"预览比例设置";
    item.values             = @[@"16:9", @"4:3"];
    item.itemType           = NVSettingItemPreViewRatio;
    item.selectedValueIndex = 0;
    
    [self.itemArray addObject:item];
    
    item                    = [[NVLiveSettingItem alloc] init];
    item.title              = @"预览比例设置";
    item.values             = @[@"16:9", @"4:3"];
    item.itemType           = NVSettingItemPreViewRatio;
    item.selectedValueIndex = 0;
    
    [self.itemArray addObject:item];
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
