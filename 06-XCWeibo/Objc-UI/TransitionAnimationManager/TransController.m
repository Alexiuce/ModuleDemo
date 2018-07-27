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
    
}

- (void)dealloc{
    NSLog(@"%s  %@",__FUNCTION__, self);
}

@end
