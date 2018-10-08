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

@property (weak, nonatomic) IBOutlet UILabel *timeLabel;


@property (nonatomic, strong)CADisplayLink *displayLink;

@property (nonatomic, strong) NSDateFormatter *dateFormater;



@end

@implementation KeyFrameViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    CALayer *layer = [CALayer layer];
    
    layer.bounds = (CGRect){{0,0},{48,32}};
    layer.backgroundColor = UIColor.redColor.CGColor;
    layer.anchorPoint = CGPointZero;
    layer.position = CGPointMake(-48, 0);
    [self.containerView.layer addSublayer:layer];
    _animateLayer = layer;
    self.displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(timeLabel_update)];
    [self.displayLink addToRunLoop:NSRunLoop.currentRunLoop forMode:NSRunLoopCommonModes];
    
    self.dateFormater = [[NSDateFormatter alloc]init];
    
    self.dateFormater.dateFormat = @"HH:mm:ss";

}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self keyframeAnimate];
    
}


- (void)timeLabel_update{
    NSDate *date = [NSDate date];
    NSString *dateText = [self.dateFormater stringFromDate:date];
    self.timeLabel.text = dateText;
}

- (void)baseAnimate{
//    CAAnimationGroup *animGroup = [CAAnimationGroup animation];
    
    
    CABasicAnimation *anim1 = [CABasicAnimation animationWithKeyPath:@"position.x"];
    
    anim1.fromValue = @(-48);
    anim1.toValue = @(80);
    
    anim1.duration = 0.3;
    anim1.autoreverses = YES;
    
//    CABasicAnimation *anim2 = [CABasicAnimation animationWithKeyPath:@"position"];
//    animGroup.animations = @[anim1];
    
    
    [self.animateLayer addAnimation:anim1 forKey:nil];
    
    
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
//    [self baseAnimate];
    [self keyframeAnimate];
}

- (void)keyframeAnimate{
    
    CAAnimationGroup *group = [CAAnimationGroup animation];
    
    CAKeyframeAnimation *keyAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    
    NSValue *v1 =  [NSValue valueWithCGPoint:CGPointMake(-48, 0)];
    NSValue *v2 = [NSValue valueWithCGPoint:CGPointMake(80, 0)];
    NSValue *v3 = [NSValue valueWithCGPoint:CGPointMake(80.1, 0)];
    NSValue *v4 = [NSValue valueWithCGPoint:CGPointMake(-48, 0)];
    NSValue *v5 = [NSValue valueWithCGPoint:CGPointMake(-49, 0)];
    keyAnimation.values = @[v1,v2,v3,v4,v5];
//    keyAnimation.duration = 4.6;
    keyAnimation.keyTimes = @[@0.0,@(3/46.0),@(20/46.0),@(23/46.0),@1.0];
//    keyAnimation.repeatCount = MAXFLOAT;
//    keyAnimation.autoreverses = YES;
    
    CABasicAnimation *alphAnimation = [CABasicAnimation animationWithKeyPath:@"opacity"];
    alphAnimation.fromValue = @(0);
    alphAnimation.toValue = @(1);
    alphAnimation.duration = 1;
   
    
    group.animations = @[keyAnimation,alphAnimation];
    group.duration = 4.6;
    group.repeatCount = MAXFLOAT;
    
    
    [self.animateLayer addAnimation:group forKey:nil];
}


@end
