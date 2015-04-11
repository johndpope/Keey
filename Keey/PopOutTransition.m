//
//  PopOutTransition.m
//  Keey
//
//  Created by Ipalibo Whyte on 07/04/2015.
//  Copyright (c) 2015 SweetKeyNotes. All rights reserved.
//

#import "PopOutTransition.h"
#import <pop/POP.h>

@implementation PopOutTransition

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext
{
    return 2.0;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{

    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVc = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];

    // Get the container view - where the animation has to happen
    UIView *containerView = [transitionContext containerView];
    
    [containerView addSubview:fromVC.view];
    [containerView addSubview:toVc.view];
    

    // Add the two VC views to the container. Hide the to
    
    POPSpringAnimation *anim = [POPSpringAnimation animationWithPropertyNamed:kPOPViewScaleXY];
    
    anim.fromValue = [NSValue valueWithCGSize:CGSizeMake(1, 1)];
    anim.toValue = [NSValue valueWithCGSize:CGSizeMake(0.1, 0.1)];
    anim.springSpeed = 30;
    anim.springBounciness = 10;
    anim.removedOnCompletion = YES;
    anim.completionBlock = ^(POPAnimation *anim, BOOL finished){
        
        //[fromVC.view removeFromSuperview];
        [toVc.view setUserInteractionEnabled:true];
        [transitionContext completeTransition:YES];
        
        [[[UIApplication sharedApplication] keyWindow] addSubview:toVc.view];

    };
    [fromVC.view pop_addAnimation:anim forKey:@"springAnimation"];
    //fromVC.view.backgroundColor = [UIColor redColor];
    
}


@end
