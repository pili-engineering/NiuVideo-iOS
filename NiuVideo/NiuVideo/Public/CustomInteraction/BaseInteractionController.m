//
//  BaseInteractionController.m
//  ViewControllerTransitions
//
//  Created by Colin Eberhardt on 10/09/2013.
//  Copyright (c) 2013 Colin Eberhardt. All rights reserved.
//

#import "BaseInteractionController.h"
//#import "GlobalTool.h"
@implementation BaseInteractionController

- (void)wireToViewController:(UIViewController *)viewController forOperation:(InteractionOperation)operation {
    
    @throw [NSException exceptionWithName:NSInternalInconsistencyException
                                   reason:[NSString stringWithFormat:@"You must override %@ in a subclass", NSStringFromSelector(_cmd)]
                                 userInfo:nil];
    
}


-(void)enablePanInteraction{
    
}

-(void)disablePanInteraction{
    
}

@end
