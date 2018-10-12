//
//  XCTransitionPushManager.m
//  Objc-UI
//
//  Created by Alexcai on 2018/10/11.
//  Copyright © 2018 Alexcai. All rights reserved.
//

#import "XCTransitionPushManager.h"
#import "XCPushAnimationViewController.h"

@interface XCTransitionPushManager()<CAAnimationDelegate>

@property (nonatomic, strong) id<UIViewControllerContextTransitioning> transitionContext;


@end

@implementation XCTransitionPushManager



- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext{
    return 0.5;
}


/**
 转场动画实现方法

 @param transitionContext 转场上下文
 */
- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext{
    
    self.transitionContext = transitionContext;
    
    
    NSString *fromControllerKey = self.isPOP ? UITransitionContextToViewControllerKey : UITransitionContextFromViewControllerKey;
    NSString *toControllerKey = self.isPOP ? UITransitionContextFromViewControllerKey : UITransitionContextToViewControllerKey;
    
    //获取源控制器 注意不要写成 UITransitionContextFromViewKey
    XCPushAnimationViewController *fromVc = [transitionContext viewControllerForKey:fromControllerKey];
    //获取目标控制器 注意不要写成 UITransitionContextToViewKey
    UIViewController *toVc = [transitionContext viewControllerForKey:toControllerKey];
    
    //获得容器视图
    UIView *containView = [transitionContext containerView];
    // 都添加到container中。注意顺序 目标控制器的view需要后面添加
    [containView addSubview:fromVc.view];
    [containView addSubview:toVc.view];
    
    UIButton *button = fromVc.fromButton;
    //绘制圆形
    UIBezierPath *startPath = [UIBezierPath bezierPathWithOvalInRect:button.frame];
    
    //创建两个圆形的 UIBezierPath 实例；一个是 button 的 size ，另外一个则拥有足够覆盖屏幕的半径。最终的动画则是在这两个贝塞尔路径之间进行的
    //按钮中心离屏幕最远的那个角的点
    CGPoint finalPoint;
    //判断触发点在那个象限
    if(button.frame.origin.x > (toVc.view.bounds.size.width / 2)){
        if (button.frame.origin.y < (toVc.view.bounds.size.height / 2)) {
            //第一象限
            finalPoint = CGPointMake(0, CGRectGetMaxY(toVc.view.frame));
        }else{
            //第四象限
            finalPoint = CGPointZero;
        }
    }else{
        if (button.frame.origin.y < (toVc.view.bounds.size.height / 2)) {
            //第二象限
            finalPoint = CGPointMake(CGRectGetMaxX(toVc.view.frame), CGRectGetMaxY(toVc.view.frame));
        }else{
            //第三象限
            finalPoint = CGPointMake(CGRectGetMaxX(toVc.view.frame), 0);
        }
    }
    
    CGPoint startPoint = CGPointMake(button.center.x, button.center.y);
    //计算向外扩散的半径 = 按钮中心离屏幕最远的那个角距离 - 按钮半径
    CGFloat radius = sqrt((finalPoint.x-startPoint.x) * (finalPoint.x-startPoint.x) + (finalPoint.y-startPoint.y) * (finalPoint.y-startPoint.y)) - sqrt(button.frame.size.width/2 * button.frame.size.width/2 + button.frame.size.height/2 * button.frame.size.height/2);
    UIBezierPath *endPath = [UIBezierPath bezierPathWithOvalInRect:CGRectInset(button.frame, -radius, -radius)];
    
    //赋值给toVc视图layer的mask
    CAShapeLayer *maskLayer = [CAShapeLayer layer];
    maskLayer.path = endPath.CGPath;
    toVc.view.layer.mask = maskLayer;
    
    CABasicAnimation *maskAnimation =[CABasicAnimation animationWithKeyPath:@"path"];
    if (self.isPOP) {
        maskAnimation.fromValue = (__bridge id)endPath.CGPath;
        maskAnimation.toValue = (__bridge id)startPath.CGPath;

    }else{
        maskAnimation.fromValue = (__bridge id)startPath.CGPath;
        maskAnimation.toValue = (__bridge id)endPath.CGPath;
        
    }
    maskAnimation.duration = [self transitionDuration:transitionContext];
    maskAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    maskAnimation.delegate = self;
    [maskLayer addAnimation:maskAnimation forKey:@"path"];
    
}


#pragma mark -- CAAnimationDelegate --

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
    
    //告诉 iOS 这个 transition 完成
    [self.transitionContext completeTransition:YES];
    [self.transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey].view.layer.mask = nil;
    [self.transitionContext viewControllerForKey:UITransitionContextToViewControllerKey].view.layer.mask = nil;
    
}
@end
