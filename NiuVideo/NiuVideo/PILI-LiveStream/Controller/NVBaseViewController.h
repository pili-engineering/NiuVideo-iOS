//
//  NVBaseViewController.h
//  NiuVideo
//
//  Created by hxiongan on 2017/12/15.
//  Copyright © 2017年 Pili Engineering, Qiniu Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PanAnimationController.h"
#import "HorizontalSwipeInteractionController.h"

//controller的显示模式，push或者present
typedef enum : NSUInteger {
    NVControllerShowModePush,
    NVControllerShowModePresent,
} NVControllerShowMode;

typedef enum : NSUInteger {
    NVNavigationLeftItemTagBack = 0x123,
    NVNavigationLeftItemTagDismiss,
    NVNavigationLeftItemTagBackToRoot,
} NVNavigationLeftItemTag;

@interface NVBaseViewController : UIViewController
<
UIViewControllerTransitioningDelegate
>

/// controller的显示模式，push或者present
@property(nonatomic) NVControllerShowMode controllerShowMode;
/// 自定义的controller交互动画
@property(nonatomic, strong) PanAnimationController *viewControllerAnimatedTransitioning;
@property(nonatomic, strong) HorizontalSwipeInteractionController *percentDrivenInteractiveTransition;

/**
    禁用自定义交互滑动返回手势
 */
- (void)disablePanInteraction;

/**
    启用自定义交互滑动返回手势
 */
- (void)enablePanInteraction;

/**
    用自定义交互的方式显示controller
    controller：将用自定义交互present的viewController
 */
- (void)presentViewController:(NVBaseViewController*)controller;

@end



@interface UIViewController (NVBaseViewControllerCategory)

- (UIBarButtonItem*)spaceItem;
- (void)setNavigationLeftItemBack;
- (void)setNavigationLeftItemDismiss;
- (void)setNavigationLeftItemEmpty;
- (void)setNavigationLeftItemWithCustom:(UIView*)customView;
- (void)enablePanGestureRecognizerBack:(BOOL)enable;
- (void)clickLeftItem:(UIButton*)sender;

@end
