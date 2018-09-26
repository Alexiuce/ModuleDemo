//
//  XCGradientController.m
//  Objc-UI
//
//  Created by Alexcai on 2018/9/26.
//  Copyright © 2018年 Alexcai. All rights reserved.
//

#import "XCGradientController.h"

@implementation XCGradientController

- (void)viewDidLoad{
    [super viewDidLoad];
    
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.bounds = (CGRect){CGPointZero,CGSizeMake(100, 100)};
    gradientLayer.position = self.view.center;
    [self.view.layer addSublayer:gradientLayer];
    
    gradientLayer.colors = @[(__bridge id)[UIColor redColor].CGColor,
                             (__bridge id)[UIColor blueColor].CGColor];
    
    gradientLayer.startPoint = CGPointZero;
    
    gradientLayer.endPoint = CGPointMake(1, 0);
    
    
}

@end
