//
//  VerticalSwipeInteactionController.m
//  car-camera
//
//  Created by Colin Eberhardt on 22/09/2013.
//  Copyright (c) 2013 Colin Eberhardt. All rights reserved.
//

#import "VerticalSwipeInteractionController.h"

@interface VerticalSwipeInteractionController ()
{
    BOOL _shouldCompleteTransition;
 
    UIPanGestureRecognizer *_gesture;
    InteractionOperation _operation;
}

@property(nonatomic, weak)   UIViewController *viewController;
@end

@implementation VerticalSwipeInteractionController

-(void)dealloc {
    [_gesture.view removeGestureRecognizer:_gesture];
}

- (void)wireToViewController:(UIViewController *)viewController forOperation:(InteractionOperation)operation{
    
    if (operation == InteractionOperationTab) {
        @throw [NSException exceptionWithName:NSInternalInconsistencyException
                                       reason:@"You cannot use a vertical swipe interaction with a tabbar controller - that would be silly!"
                                     userInfo:nil];
    }
    _operation = operation;
    _viewController = viewController;
    [self prepareGestureRecognizerInView:viewController.view];
}


- (void)prepareGestureRecognizerInView:(UIView*)view {
    _gesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handleGesture:)];
    [view addGestureRecognizer:_gesture];
}

- (CGFloat)completionSpeed
{
    return 1 - self.percentComplete;
}



- (void)handleGesture:(UIPanGestureRecognizer*)gestureRecognizer {
    CGPoint translation = [gestureRecognizer translationInView:gestureRecognizer.view.superview];
    
    switch (gestureRecognizer.state) {
        case UIGestureRecognizerStateBegan: {
            
            BOOL topToBottomSwipe = translation.y > 0;
            
            if (_operation == InteractionOperationPop) {
                if (topToBottomSwipe) {
                    self.interactionInProgress = YES;
                    [_viewController.navigationController popViewControllerAnimated:YES];
                }
            } else {
                self.interactionInProgress = YES;
                [_viewController dismissViewControllerAnimated:YES completion:nil];
            }
            break;
        }
        case UIGestureRecognizerStateChanged: {
            if (self.interactionInProgress) {
                CGFloat fraction = fabs(translation.y / [[UIScreen mainScreen]bounds].size.height);
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
