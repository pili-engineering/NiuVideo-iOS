//
//  NVLiveSettingSegmentViewController.m
//  NiuVideo
//
//  Created by hxiongan on 2017/12/15.
//  Copyright © 2017年 Pili Engineering, Qiniu Inc. All rights reserved.
//

#import "NVLiveSettingSegmentViewController.h"
#import "NVLiveCaptureSettingViewController.h"
#import "NVLiveWaterMarkSettingViewController.h"
#import "NVLiveStreamSettingViewController.h"
#import "NiuVideoPCH.h"

/// 将三个设置页面放到三个controller中，减轻controller的负担，避免出现复制的逻辑和大量的代码堆积在一个文件之中

@interface NVLiveSettingSegmentViewController ()
<
UIScrollViewDelegate,
UITabBarDelegate
>
{
    NVLiveSettingChildViewController* _childControllers[3];
}

@property (nonatomic, strong) UIScrollView                          *scrollView;
@property (nonatomic, strong) UITabBar                              *tabBar;

@property (nonatomic, strong) NVLiveCaptureSettingViewController    *captureSettingController;
@property (nonatomic, strong) NVLiveWaterMarkSettingViewController  *waterMarkSettingController;
@property (nonatomic, strong) NVLiveStreamSettingViewController     *streamSettingController;

@property (nonatomic, strong) NVLiveSettingChildViewController      *currentShowController;

@end

@implementation NVLiveSettingSegmentViewController

#define MAS_SHORTHAND

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initChildController];
    [self initTabBar];
}

- (void)initTabBar {
    
    UITabBarItem *items[3];
    NSString* itemImageNames[3] = {@"qr_code", @"qr_code", @"qr_code"};
    NSString* itemTitles[3]     = {@"采集", @"水印", @"推流"};
    for (int i = 0; i < sizeof(items) / sizeof(items[0]); i ++) {
        items[i] = [[UITabBarItem alloc] initWithTitle:itemTitles[i] image:[UIImage imageNamed:itemImageNames[i]] selectedImage:[UIImage imageNamed:itemImageNames[i]]];
    }
    self.tabBar = [[UITabBar alloc] init];
    self.tabBar.delegate = self;
    [self.tabBar setItems:[NSArray arrayWithObjects:items count:sizeof(items) / sizeof(items[0])]];
    
    [self.view addSubview:self.tabBar];
    [self.tabBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.height.equalTo(49);
    }];
}

- (void)initChildController {
    
    self.scrollView                 = [[UIScrollView alloc]init];
    self.scrollView.pagingEnabled   = YES;
    self.scrollView.delegate        = self;
    self.scrollView.bounces         = NO;
    //    self.scrollView.avalibeValue_x  = 40;//当position的 x < 40时，scrollView的自己的手势不响应，相应其他的手势(比如滑动返回)，这里主要是滑动显示左侧的view
    self.scrollView.showsHorizontalScrollIndicator = NO;
    
    self.captureSettingController   = [[NVLiveCaptureSettingViewController alloc] init];
    self.waterMarkSettingController = [[NVLiveWaterMarkSettingViewController alloc] init];
    self.streamSettingController    = [[NVLiveStreamSettingViewController alloc] init];
    
    [self addChildViewController:self.captureSettingController];
    [self addChildViewController:self.waterMarkSettingController];
    [self addChildViewController:self.streamSettingController];
    
    _childControllers[0] = self.captureSettingController;
    _childControllers[1] = self.waterMarkSettingController;
    _childControllers[2] = self.streamSettingController;
    
    _waterMarkSettingController.view.backgroundColor = [UIColor redColor];
    
    UIView* superView = self.view;
    [superView addSubview:self.scrollView];
    
    [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(superView);
    }];
    
    superView = self.scrollView;
    UIView* containerView = [[UIView alloc]init];
    [superView addSubview:containerView];
    [containerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(superView);
        make.width.equalTo(self.view).multipliedBy(3);
    }];
    
    superView = containerView;
    [superView addSubview:self.captureSettingController.view];
    [superView addSubview:self.waterMarkSettingController.view];
    [superView addSubview:self.streamSettingController.view];
    
    NSArray* viewArray = @[self.captureSettingController.view, self.waterMarkSettingController.view, self.streamSettingController.view];
    [viewArray mas_distributeViewsAlongAxis:(MASAxisTypeHorizontal) withFixedSpacing:0 leadSpacing:0 tailSpacing:0];
    [viewArray mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_topLayoutGuide);
        make.bottom.equalTo(self.view);
    }];
    
    [containerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(((UIView*)viewArray[0]).mas_height);
    }];
    
    self.currentShowController = self.captureSettingController;

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - tabBarDelegate

-(void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item {
    [self.scrollView setContentOffset:CGPointMake([tabBar.items indexOfObject:item] * self.view.bounds.size.width, 0) animated:YES];
}

#pragma mark - scrollViewDelegate

- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView
                     withVelocity:(CGPoint)velocity
              targetContentOffset:(inout CGPoint *)targetContentOffset {
    [self scrollViewContentOffsetChange:*targetContentOffset];
}

-(void)scrollViewContentOffsetChange:(CGPoint)contentOffset{
    
    NSInteger offset    = contentOffset.x + self.scrollView.bounds.size.width - 1;
    NSInteger width     = self.scrollView.bounds.size.width;
    NSInteger index     = offset / width;
    
    NSInteger maxIndex = sizeof(_childControllers) / sizeof(_childControllers[0]);
    index = index < 0 ? 0 : index;
    index = index > maxIndex ? maxIndex : index;
    self.tabBar.selectedItem = self.tabBar.items[index];
}

@end
