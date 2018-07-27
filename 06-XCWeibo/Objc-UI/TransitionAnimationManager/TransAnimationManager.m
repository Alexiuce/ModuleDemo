//
//  TransAnimationManager.m
//  Objc-UI
//
//  Created by Alexcai on 2018/7/27.
//  Copyright © 2018年 Alexcai. All rights reserved.
//

#import "TransAnimationManager.h"

#import "TransController.h"

@interface TransAnimationManager()

//@property (nonatomic, strong)TransController *trans;

@end

@implementation TransAnimationManager


- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source{
    return [TransController transPrensentSytle:YES];
//    return self.trans;
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed{
    return  [TransController transPrensentSytle:NO];
//    return self.trans;
}

@end
