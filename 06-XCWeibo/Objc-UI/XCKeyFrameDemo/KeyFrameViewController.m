//
//  KeyFrameViewController.m
//  Objc-UI
//
//  Created by Alexcai on 2018/9/29.
//  Copyright © 2018年 Alexcai. All rights reserved.
//

#import "KeyFrameViewController.h"

@interface KeyFrameViewController ()
@property (weak, nonatomic) IBOutlet UIView *containerView;

@property (nonatomic, weak) CALayer *animateLayer;

@end

@implementation KeyFrameViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    CALayer *layer = [CALayer layer];
    
    layer.bounds = (CGRect){{0,0},{48,32}};
    layer.backgroundColor = UIColor.redColor.CGColor;
    layer.anchorPoint = CGPointZero;
    
    [self.containerView.layer addSublayer:layer];
    _animateLayer = layer;

}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
}


- (void)baseAnimate{
//    CAAnimationGroup *animGroup = [CAAnimationGroup animation];
    
    
    CABasicAnimation *anim1 = [CABasicAnimation animationWithKeyPath:@"position"];
    
    anim1.fromValue = @(-48);
    anim1.toValue = @(80);
    
    anim1.duration = 0.3;
    anim1.autoreverses = YES;
    
//    CABasicAnimation *anim2 = [CABasicAnimation animationWithKeyPath:@"position"];
//    animGroup.animations = @[anim1];
    
    
    [self.animateLayer addAnimation:anim1 forKey:nil];
    
    
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self baseAnimate];
}

- (void)keyframeAnimate{
    CAKeyframeAnimation *keyAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    
    NSValue *v1 =  [NSValue valueWithCGPoint:CGPointMake(-48, 0)];
    NSValue *v2 = [NSValue valueWithCGPoint:CGPointMake(80, 0)];
    NSValue *v3 = [NSValue valueWithCGPoint:CGPointMake(81, 0)];
    NSValue *v4 = [NSValue valueWithCGPoint:CGPointMake(-48, 0)];
    
    
    keyAnimation.values = @[v1,v2,v3,v4];
    keyAnimation.duration = 2.6;
    keyAnimation.keyTimes = @[@0,@0.12,@0.76,@0.12];
    keyAnimation.repeatCount = MAXFLOAT;
    keyAnimation.autoreverses = YES;
    
    [self.animateLayer addAnimation:keyAnimation forKey:nil];
}


@end
