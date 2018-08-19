//
//  TransAnimationManager.m
//  Objc-UI
//
//  Created by Alexcai on 2018/7/27.
//  Copyright © 2018年 Alexcai. All rights reserved.
//

#import "TransAnimationManager.h"
#import "XCPresentationController.h"
#import "TransController.h"

@interface TransAnimationManager()



@end

@implementation TransAnimationManager


- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source{
    return [TransController transPrensentSytle:YES];

}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed{
    return  [TransController transPrensentSytle:NO];

}

- (UIPresentationController *)presentationControllerForPresentedViewController:(UIViewController *)presented presentingViewController:(UIViewController *)presenting sourceViewController:(UIViewController *)source{
    return [[XCPresentationController alloc]initWithPresentedViewController:presented presentingViewController:presenting];
}


@end
