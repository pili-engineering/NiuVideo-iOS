//
//  PanAnimationController.m
//  car-camera
//
//  Created by Alvin Zeng on 01/08/2014.
//  Copyright (c) 2014 Alvin Zeng. All rights reserved.
//

#import "PanAnimationController.h"

@implementation PanAnimationController

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext fromVC:(UIViewController *)fromVC toVC:(UIViewController *)toVC fromView:(UIView *)fromView toView:(UIView *)toView {

    CGFloat viewWidth = fromVC.view.frame.size.width;
    UIView* containerView = [transitionContext containerView];
    [containerView addSubview:toView];

    toView.frame = [transitionContext finalFrameForViewController:toVC];
    
    if (self.reverse) {//dismiss
        [containerView sendSubviewToBack:toView];
        
        fromView.layer.shadowColor = [[UIColor blackColor] CGColor];
        fromView.layer.shadowOffset = CGSizeMake(-2.0f,0.0f);
        fromView.layer.shadowOpacity = 0.5f;
        fromView.layer.shadowRadius = 2.0f;
        
        CGRect frame = toView.frame;
        frame.origin.x = -viewWidth/3.0;
        toView.frame = frame;
        
    } else { //present
        [containerView bringSubviewToFront:toView];
        
        CGRect frame = toView.frame;
        frame.origin.x = viewWidth;
        toView.frame = frame;
    }
    
    NSTimeInterval duration = [self transitionDuration:transitionContext];
    
    [UIView animateWithDuration:duration animations:^{
        fromView.frame = CGRectMake(!self.reverse ? -viewWidth/3 : viewWidth, fromView.frame.origin.y, fromView.frame.size.width, fromView.frame.size.height);
        toView.frame = [transitionContext finalFrameForViewController:toVC];
    } completion:^(BOOL finished) {
        if ([transitionContext transitionWasCancelled]) {
            
            toView.frame = CGRectMake(self.reverse ? -viewWidth/3 : viewWidth, toView.frame.origin.y, toView.frame.size.width, toView.frame.size.height);
            fromView.frame = CGRectMake(0, fromView.frame.origin.y, fromView.frame.size.width, fromView.frame.size.height);
            
            [toView removeFromSuperview];
            
        } else {
            
            [fromView removeFromSuperview];
            
            fromView.frame = CGRectMake(!self.reverse ? -viewWidth/3 : viewWidth, fromView.frame.origin.y, fromView.frame.size.width, fromView.frame.size.height);
            toView.frame = [transitionContext finalFrameForViewController:toVC];
        }
        [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
    }];

}

@end
