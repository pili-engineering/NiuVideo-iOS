//
//  BaseInteractionController.h
//  ViewControllerTransitions
//
//  Created by Colin Eberhardt on 10/09/2013.
//  Copyright (c) 2013 Colin Eberhardt. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, InteractionOperation) {
    InteractionOperationPop,
    InteractionOperationDismiss,
    InteractionOperationTab
};

@interface BaseInteractionController : UIPercentDrivenInteractiveTransition

- (void)wireToViewController:(UIViewController*)viewController forOperation:(InteractionOperation)operation;

@property (nonatomic, assign) BOOL interactionInProgress;


-(void)enablePanInteraction;

-(void)disablePanInteraction;

@end
