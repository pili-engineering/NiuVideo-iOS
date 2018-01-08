//
//  SwipeINteractionController.m
//  ILoveCatz
//
//  Created by Colin Eberhardt on 22/08/2013.
//  Copyright (c) 2013 com.razeware. All rights reserved.
//

#import "HorizontalSwipeInteractionController.h"

@interface HorizontalSwipeInteractionController ()
{
    BOOL _shouldCompleteTransition;
    
        UIPanGestureRecognizer *_gesture;
//    UIScreenEdgePanGestureRecognizer *_gesture;
    InteractionOperation _operation;
}

@property(nonatomic, weak)UIViewController *viewController;
@end

@implementation HorizontalSwipeInteractionController


-(void)dealloc {
    [_gesture.view removeGestureRecognizer:_gesture];
}

- (void)wireToViewController:(UIViewController *)viewController forOperation:(InteractionOperation)operation{
    self.popOnRightToLeft = YES;
    _operation = operation;
    _viewController = viewController;
    [self prepareGestureRecognizerInView:viewController.view];
}


- (void)prepareGestureRecognizerInView:(UIView*)view {
    _gesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handleGesture:)];
//    _gesture = [[UIScreenEdgePanGestureRecognizer alloc] initWithTarget:self action:@selector(handleGesture:)];
//    _gesture.edges = UIRectEdgeLeft;
    [view addGestureRecognizer:_gesture];
}

- (CGFloat)completionSpeed
{
    return 1 - self.percentComplete;
}

-(void)enablePanInteraction{
    [_viewController.view addGestureRecognizer:_gesture];
}

-(void)disablePanInteraction{
    [_viewController.view removeGestureRecognizer:_gesture];
}


- (void)handleGesture:(UIPanGestureRecognizer*)gestureRecognizer {
    CGPoint translation = [gestureRecognizer translationInView:gestureRecognizer.view.superview];
    CGPoint vel = [gestureRecognizer velocityInView:gestureRecognizer.view];
    
    switch (gestureRecognizer.state) {
        case UIGestureRecognizerStateBegan: {
            
            BOOL rightToLeftSwipe = vel.x < 0;
            
            
            if (_operation == InteractionOperationPop) {
                if ((self.popOnRightToLeft && rightToLeftSwipe) ||
                    (!self.popOnRightToLeft && !rightToLeftSwipe)) {
                    self.interactionInProgress = YES;
                    [_viewController.navigationController popViewControllerAnimated:YES];
                }
            } else if (_operation == InteractionOperationTab) {
                if (rightToLeftSwipe) {
                    if (_viewController.tabBarController.selectedIndex < _viewController.tabBarController.viewControllers.count - 1) {
                        self.interactionInProgress = YES;
                        _viewController.tabBarController.selectedIndex++;
                    }
                } else {
                    if (_viewController.tabBarController.selectedIndex > 0) {
                        self.interactionInProgress = YES;
                        _viewController.tabBarController.selectedIndex--;
                    }
                }
            } else {
                if (vel.x > 0) {
                    self.interactionInProgress = YES;
                    [_viewController dismissViewControllerAnimated:YES completion:nil];
                }
            }
            break;
        }
        case UIGestureRecognizerStateChanged: {
            if (self.interactionInProgress) {
                CGFloat fraction = fabs(translation.x / ([[UIScreen mainScreen]bounds].size.width));
                fraction = fminf(fmaxf(fraction, 0.0), 1.0);
                _shouldCompleteTransition = (fraction > 0.5);
                
                if (fraction >= 1.0)
                    fraction = 0.99;
                
                [self updateInteractiveTransition:fraction];
            }
            break;
        }
        case UIGestureRecognizerStateEnded:
        case UIGestureRecognizerStateCancelled:
            if (self.interactionInProgress) {
                self.interactionInProgress = NO;
                if (!_shouldCompleteTransition || gestureRecognizer.state == UIGestureRecognizerStateCancelled) {
                    [self cancelInteractiveTransition];
                }
                else {
                    [self finishInteractiveTransition];
                }
            }
            break;
        default:
            break;
    }
}


@end
