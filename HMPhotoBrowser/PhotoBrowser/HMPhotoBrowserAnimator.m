//
//  HMPhotoBrowserAnimator.m
//  HMPhotoBrowser
//
//  Created by 刘凡 on 16/3/13.
//  Copyright © 2016年 itcast. All rights reserved.
//

#import "HMPhotoBrowserAnimator.h"

@interface HMPhotoBrowserAnimator() <UIViewControllerAnimatedTransitioning>

@end

@implementation HMPhotoBrowserAnimator {
    BOOL _isPresenting;
}

#pragma mark - UIViewControllerTransitioningDelegate
- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source {
    
    _isPresenting = YES;
    
    return self;
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
    
    _isPresenting = NO;
    
    return self;
}

#pragma mark - UIViewControllerAnimatedTransitioning
- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    return 0.25;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    _isPresenting ? [self presentTransition:transitionContext] : [self dismissTransition:transitionContext];
}

- (void)presentTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    
    UIView *containerView = [transitionContext containerView];
    UIView *toView = [transitionContext viewForKey:UITransitionContextToViewKey];
    [containerView addSubview:toView];
    
    toView.alpha = 0.0;
    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
        toView.alpha = 1.0;
    } completion:^(BOOL finished) {
        [transitionContext completeTransition:YES];
    }];
}

- (void)dismissTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    
    UIView *containerView = [transitionContext containerView];
    UIView *fromView = [transitionContext viewForKey:UITransitionContextFromViewKey];
    
    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
        fromView.alpha = 0.0;
    } completion:^(BOOL finished) {
        [transitionContext completeTransition:YES];
    }];
}

@end
