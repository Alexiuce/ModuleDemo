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
    CAKeyframeAnimation *keyAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    
    NSValue *v1 =  [NSValue valueWithCGPoint:CGPointMake(0, 0)];
    NSValue *v2 = [NSValue valueWithCGPoint:CGPointMake(80, 0)];
    NSValue *v3 = [NSValue valueWithCGPoint:CGPointMake(80, 100)];
    NSValue *v4 = [NSValue valueWithCGPoint:CGPointMake(200, 100)];
    NSValue *v5 = [NSValue valueWithCGPoint:CGPointMake(200, 200)];
    
    keyAnimation.values = @[v1,v2,v3,v4,v5];
    keyAnimation.duration = 8;
    keyAnimation.repeatCount = MAXFLOAT;
    
    [self.animateLayer addAnimation:keyAnimation forKey:nil];
}


@end
