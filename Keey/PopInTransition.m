//
//  SCFadeTransition.m
//  Keey
//
//  Created by Ipalibo Whyte on 07/04/2015.
//  Copyright (c) 2015 SweetKeyNotes. All rights reserved.
//


#import "PopInTransition.h"
#import <pop/POP.h>

@implementation PopInTransition

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext
{
    return 4.0;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{

    // Get the two view controllers
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    // Get the container view - where the animation has to happen
    UIView *containerView = [transitionContext containerView];
    
    // Add the two VC views to the container. Hide the to
    [containerView addSubview:fromVC.view];
    [containerView addSubview:toVC.view];
    
    POPSpringAnimation *anim = [POPSpringAnimation animationWithPropertyNamed:kPOPViewScaleXY];
    
    anim.fromValue = [NSValue valueWithCGSize:CGSizeMake(0.1, 0.1)];
    anim.toValue = [NSValue valueWithCGSize:CGSizeMake(1, 1)];
    anim.springSpeed = 30;
    anim.springBounciness = 10;
    anim.removedOnCompletion = YES;
    anim.completionBlock = ^(POPAnimation *anim, BOOL finished){
        [fromVC.view removeFromSuperview];
        //[fromVC.view setUserInteractionEnabled:FALSE];
        [transitionContext completeTransition:YES];
    };
    
    [toVC.view pop_addAnimation:anim forKey:@"springAnimation"];


    /*
    
    // Perform the animation
    [UIView animateWithDuration:[self transitionDuration:transitionContext]
                          delay:0
                        options:0
                     animations:^{
                         
                         toVC.view.alpha = 1.f;
                     }
                     completion:^(BOOL finished) {
                         // Let's get rid of the old VC view
                         [fromVC.view removeFromSuperview];
                         // And then we need to tell the context that we're done
                         [transitionContext completeTransition:YES];
                     }];
    */
}

@end