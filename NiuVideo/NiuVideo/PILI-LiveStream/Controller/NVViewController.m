//
//  NVViewController.m
//  NiuVideo
//
//  Created by hxiongan on 2017/12/15.
//  Copyright © 2017年 Pili Engineering, Qiniu Inc. All rights reserved.
//

#import "NVViewController.h"

@interface NVViewController ()

@end

@implementation NVViewController

- (void)dealloc {
#ifdef DEBUG
    printf("\n[dealloc] %s\n", [NSStringFromClass(self.class) UTF8String]);
#endif
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = NV_WHITE_COLOR;
    
    if (NVControllerShowModePush == self.controllerShowMode) {
        [self setNavigationLeftItemBack];
    } else {
        [self setNavigationLeftItemDismiss];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    if (NVControllerShowModePresent == self.controllerShowMode) {
        [self enablePanInteraction];
    }
}

- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    if (NVControllerShowModePresent == self.controllerShowMode) {
        [self disablePanInteraction];
    }
}

#pragma mark - 设置动画转场
- (HorizontalSwipeInteractionController *)percentDrivenInteractiveTransition{
    if (nil == _percentDrivenInteractiveTransition) {
        _percentDrivenInteractiveTransition = [[HorizontalSwipeInteractionController alloc]init];
    }
    return _percentDrivenInteractiveTransition;
}

- (PanAnimationController *)viewControllerAnimatedTransitioning{
    if (nil == _viewControllerAnimatedTransitioning) {
        _viewControllerAnimatedTransitioning = [[PanAnimationController alloc]init];
    }
    return _viewControllerAnimatedTransitioning;
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source {
    
    [self.percentDrivenInteractiveTransition wireToViewController:presented forOperation:InteractionOperationDismiss];
    self.viewControllerAnimatedTransitioning.reverse = NO;
    return self.viewControllerAnimatedTransitioning;
    
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
    self.viewControllerAnimatedTransitioning.reverse = YES;
    return self.viewControllerAnimatedTransitioning;
}

- (id<UIViewControllerInteractiveTransitioning>)interactionControllerForDismissal:(id<UIViewControllerAnimatedTransitioning>)animator {
    return self.percentDrivenInteractiveTransition.interactionInProgress ? self.percentDrivenInteractiveTransition : nil;
}

- (void)enablePanInteraction{
    UIViewController* vc = self;
    id transitioningDelegate = vc.transitioningDelegate;
    
    while (vc && !transitioningDelegate) {
        vc = vc.parentViewController;
        transitioningDelegate = vc.transitioningDelegate;
    }
    
    if (transitioningDelegate && [transitioningDelegate isKindOfClass:[NVViewController class]]) {
        [((NVViewController*)transitioningDelegate).percentDrivenInteractiveTransition enablePanInteraction];
    }
}

- (void)disablePanInteraction{
    UIViewController* vc = self;
    id transitioningDelegate = vc.transitioningDelegate;
    
    while (vc && !transitioningDelegate) {
        vc = vc.parentViewController;
        transitioningDelegate = vc.transitioningDelegate;
    }
    
    if (transitioningDelegate && [transitioningDelegate isKindOfClass:[NVViewController class]]) {
        [((NVViewController*)transitioningDelegate).percentDrivenInteractiveTransition disablePanInteraction];
    }
}

- (void)presentViewController:(NVViewController*)controller{
    
    controller.controllerShowMode   = NVControllerShowModePresent;
    
    UINavigationController* nvc     = [[UINavigationController alloc]initWithRootViewController:controller];
    nvc.transitioningDelegate       = self;
    
    [self presentViewController:nvc animated:YES completion:nil];
}

@end


@implementation UIViewController (NVViewControllerCategory)

- (void)emptyNavitationItem{
    self.navigationItem.leftBarButtonItem   = nil;
    self.navigationItem.leftBarButtonItems  = nil;
}

- (UIBarButtonItem*)spaceItem{
    UIBarButtonItem *spaceItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    [spaceItem setWidth:-5];
    return spaceItem;
}

- (UIBarButtonItem*)leftItemWithTag:(NVNavigationLeftItemTag)itemTag{
    
    UIButton* button = [UIButton buttonWithType:(UIButtonTypeCustom)];
    button.tag = itemTag;
    [button setImage:[UIImage imageNamed:@"go_back"] forState:(UIControlStateNormal)];
    [button setImage:[UIImage imageNamed:@"go_back"] forState:(UIControlStateHighlighted)];
    
    UIImage* img = [button imageForState:(UIControlStateNormal)];
    [button setFrame:CGRectMake(0, 0, img.size.width, img.size.height)];
    
    [button addTarget:self action:@selector(clickLeftItem:) forControlEvents:(UIControlEventTouchUpInside)];

    UIBarButtonItem* leftItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    return leftItem;
}

- (void)setNavigationLeftItemBack{
    [self emptyNavitationItem];
    self.navigationItem.leftBarButtonItems = @[[self spaceItem], [self leftItemWithTag:NVNavigationLeftItemTagBack]];
    
    [self enablePanGestureRecognizerBack:YES];
}

- (void)setNavigationLeftItemDismiss{
    [self emptyNavitationItem];
    self.navigationItem.leftBarButtonItems = @[[self spaceItem], [self leftItemWithTag:NVNavigationLeftItemTagDismiss]];
    
    [self enablePanGestureRecognizerBack:YES];
}

- (void)setNavigationLeftItemBackToRoot{
    [self emptyNavitationItem];
    self.navigationItem.leftBarButtonItems = @[[self spaceItem], [self leftItemWithTag:NVNavigationLeftItemTagBackToRoot]];
    
    [self enablePanGestureRecognizerBack:YES];
}

- (void)setNavigationLeftItemEmpty{
    [self emptyNavitationItem];
    
    [self enablePanGestureRecognizerBack:NO];
}

- (void)setNavigationLeftItemWithCustom:(UIView *)customView{
    [self emptyNavitationItem];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:customView];
}

- (void)enablePanGestureRecognizerBack:(BOOL)enable{
    
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        if (enable) {
            self.navigationController.interactivePopGestureRecognizer.delegate = (id<UIGestureRecognizerDelegate>)self.navigationController;
            self.navigationController.interactivePopGestureRecognizer.enabled = YES;
        }else{
            self.navigationController.interactivePopGestureRecognizer.enabled = NO;
        }
    }
}

- (void)clickLeftItem:(UIButton*)sender{
    switch (sender.tag) {
        case NVNavigationLeftItemTagBack: {
            [self.navigationController popViewControllerAnimated:YES];
        }
            break;
            
        case NVNavigationLeftItemTagDismiss: {
            [self dismissViewControllerAnimated:YES completion:nil];
        }
            break;
            
        case NVNavigationLeftItemTagBackToRoot: {
            [self.navigationController popToRootViewControllerAnimated:YES];
        }
            break;
            
        default:
            break;
    }
}

@end
