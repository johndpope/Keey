//
//  SCNavControllerDelegate.m
//  Keey
//
//  Created by Ipalibo Whyte on 07/04/2015.
//  Copyright (c) 2015 SweetKeyNotes. All rights reserved.
//

#import "SCNavControllerDelegate.h"

@implementation SCNavControllerDelegate

- (id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController
                                  animationControllerForOperation:(UINavigationControllerOperation)operation
                                               fromViewController:(UIViewController *)fromVC
                                                 toViewController:(UIViewController *)toVC
{
    return [SCFadeTransition new];
}

@end
