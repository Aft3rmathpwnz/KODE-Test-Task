//
//  DatePickerPresentationAnimationController.m
//  KODETestTask
//
//  Created by Aft3rmath on 16.05.17.
//  Copyright © 2017 aft3rmath. All rights reserved.
//

#import "SBYDatePickerPresentationAnimationController.h"

static const NSTimeInterval kDefaultAnimationDuration = 0.3f;

@interface SBYDatePickerPresentationAnimationController()

@property (nonatomic) BOOL isPresenting;

@end


@implementation SBYDatePickerPresentationAnimationController


#pragma mark - Lifecycle


- (instancetype)initForPresenting:(BOOL)presenting
{
    if(self = [super init]) {
        _isPresenting = presenting;
    }
    return self;
}


#pragma mark - Inner


- (void)animatePresentationWithTransitionContext:(id<UIViewControllerContextTransitioning>)transitionContext
{
    UIViewController *presentedController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView *presentedControllerView = [transitionContext viewForKey:UITransitionContextToViewKey];
    UIView *containerView = transitionContext.containerView;
    
    presentedControllerView.frame = [transitionContext finalFrameForViewController:presentedController];
    presentedControllerView.center = CGPointMake(presentedControllerView.center.x, presentedControllerView.center.y + containerView.bounds.size.height);
    
    [containerView addSubview:presentedControllerView];
    
    [UIView animateWithDuration:[self transitionDuration:transitionContext] delay:0.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        presentedControllerView.center = CGPointMake(presentedControllerView.center.x, presentedControllerView.center.y - containerView.bounds.size.height);
        
    } completion:^(BOOL finished) {
        [transitionContext completeTransition:finished];
    }];
}

- (void)animateDismissalWithTransitionContext:(id<UIViewControllerContextTransitioning>)transitionContext
{
    UIView *presentedControllerView = [transitionContext viewForKey:UITransitionContextFromViewKey];
    UIView *containerView = transitionContext.containerView;
    
    [UIView animateWithDuration:[self transitionDuration:transitionContext] delay:0.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        presentedControllerView.center = CGPointMake(presentedControllerView.center.x, presentedControllerView.center.y + containerView.bounds.size.height);
    } completion:^(BOOL finished) {
        [transitionContext completeTransition:finished];
    }];
}


#pragma mark - UIViewControllerAnimatedTransitioning


- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    if(_isPresenting) {
        [self animatePresentationWithTransitionContext:transitionContext];
    }
    else {
        [self animateDismissalWithTransitionContext:transitionContext];
    }
}

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext
{
    return _isPresenting ? kDefaultAnimationDuration : kDefaultAnimationDuration * 1.5f;
}


@end
