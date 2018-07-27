//
//  TransController.m
//  Objc-UI
//
//  Created by Alexcai on 2018/7/27.
//  Copyright © 2018年 Alexcai. All rights reserved.
//

#import "TransController.h"


@interface TransController()

@property (nonatomic, assign) BOOL isPresentStyle;


@end


@implementation TransController

+ (instancetype)transPrensentSytle:(BOOL)isPresent{
    return [[self alloc]initWithPresentStyle:isPresent];
}

- (instancetype)initWithPresentStyle:(BOOL)isPresentStyle{
    if (self = [super init]) {
        self.isPresentStyle = isPresentStyle;
    }
    return self;
}

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext{
    return 0.5;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext{
    
    UIView *containerView = transitionContext.containerView;
    if (self.isPresentStyle) {
        UIView *showView = [transitionContext viewForKey:UITransitionContextToViewKey];
        [containerView addSubview:showView];
        showView.frame = CGRectMake(300, 100, 300, 300);
        [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
            showView.frame =  CGRectMake(0, 100, 300, 300);
        } completion:^(BOOL finished) {
            [transitionContext completeTransition:YES];
        }];
        return;
    }
    UIView *fromView = [transitionContext viewForKey:UITransitionContextFromViewKey];
    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
        fromView.frame = CGRectMake(1000, 100, 300, 300);
    } completion:^(BOOL finished) {
        [fromView removeFromSuperview];
        [transitionContext completeTransition:YES];
    }];
}

- (void)dealloc{
    NSLog(@"%s  %@",__FUNCTION__, self);
}

@end
