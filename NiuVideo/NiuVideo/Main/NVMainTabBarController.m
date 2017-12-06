//
//  NVMainTabBarController.m
//  NiuVideo
//
//  Created by suntongmian on 2017/12/1.
//  Copyright © 2017年 Pili Engineering, Qiniu Inc. All rights reserved.
//

#import "NVMainTabBarController.h"
#import "NVShortVideoViewController.h"
#import "NVLiveStreamViewController.h"
#import "NVFileManagerViewController.h"
#import "NVUserConfigViewController.h"

#import "NVSelectClassView.h"

@interface NVMainTabBarController ()
<
UITabBarControllerDelegate,
NVSelectClassViewDelegate
>

@end

@implementation NVMainTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self setupMainTabBar];
}

- (void)setupMainTabBar {
    // 短视频
    NVShortVideoViewController *shortVideoVC = [[NVShortVideoViewController alloc] init];
    UINavigationController *shortVideoNav = [[UINavigationController alloc] initWithRootViewController:shortVideoVC];
    shortVideoNav.tabBarItem.title = @"短视频";
    shortVideoNav.tabBarItem.tag = 0;
    shortVideoNav.tabBarItem.image = [UIImage imageNamed:@"short_video_icon"];
    
    // 直播
    NVLiveStreamViewController *liveStreamVC = [[NVLiveStreamViewController alloc] init];
    UINavigationController *liveStreamNav = [[UINavigationController alloc] initWithRootViewController:liveStreamVC];
    liveStreamNav.tabBarItem.title = @"直播";
    liveStreamNav.tabBarItem.tag = 1;
    liveStreamNav.tabBarItem.image = [UIImage imageNamed:@"live"];
    
    // 发布
    UIViewController *publishVC = [[UIViewController alloc] init];
    UINavigationController *publishNav = [[UINavigationController alloc] initWithRootViewController:publishVC];
    publishNav.tabBarItem.title = @"发布";
    publishNav.tabBarItem.tag = 2;
    publishNav.tabBarItem.image = [UIImage imageNamed:@"release"];
    
    // 文件
    NVFileManagerViewController *fileManagerVC = [[NVFileManagerViewController alloc] init];
    UINavigationController *fileManagerNav = [[UINavigationController alloc] initWithRootViewController:fileManagerVC];
    fileManagerNav.tabBarItem.title = @"文件";
    fileManagerNav.tabBarItem.tag = 3;
    fileManagerNav.tabBarItem.image = [UIImage imageNamed:@"document"];
    
    // 用户
    NVUserConfigViewController *userConfigVC = [[NVUserConfigViewController alloc] init];
    UINavigationController *userConfigNav = [[UINavigationController alloc] initWithRootViewController:userConfigVC];
    userConfigNav.tabBarItem.title = @"用户";
    userConfigNav.tabBarItem.tag = 4;
    userConfigNav.tabBarItem.image = [UIImage imageNamed:@"user"];
    
    self.viewControllers = @[shortVideoNav, liveStreamNav, publishNav, fileManagerNav, userConfigNav];
    self.tabBar.tintColor = NV_BLACK_COLOR;
    self.selectedIndex = 0;
    self.delegate = self;
    
}

- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController {
    if (viewController == self.viewControllers[2]) {
        NVSelectClassView *selectClassView = [[NVSelectClassView alloc] initWithFrame:CGRectZero superView:self.view];
        selectClassView.delegate = self;
        [selectClassView popSelectClassView];
        return NO;
    }
    return YES;
}

#pragma mark ---- NVSelectClassViewDelegate ----
- (void)classView:(NVSelectClassView *)classView didSelectedIndex:(NSInteger)index {
    [classView cancelSelectClassView];
    if (index == 0) {
        // 短视频
    } else{
        // 直播
    }
}

- (void)dealloc {
    NSLog(@"dealloc: %@", [[self class] description]);
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
