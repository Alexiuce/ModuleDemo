//
//  XCReplicatorLayerViewController.m
//  ObjcUI
//
//  Created by Alexcai on 2018/10/27.
//  Copyright © 2018 dongjiu. All rights reserved.
//

#import "XCReplicatorLayerViewController.h"

@interface XCReplicatorLayerViewController ()

@end

@implementation XCReplicatorLayerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    /** 创建拷贝图层*/
    CAReplicatorLayer *repLayer = [CAReplicatorLayer layer];
    repLayer.position = CGPointMake(10, 150);
    /** 创建内容图层 */
    CALayer *childrenLayer = [CALayer layer];
    childrenLayer.anchorPoint = CGPointZero;
    childrenLayer.bounds = CGRectMake(0, 0, 20, 20);
    childrenLayer.backgroundColor = UIColor.redColor.CGColor;
    [repLayer addSublayer:childrenLayer];

    /** 复制内容图层副本 */
    repLayer.instanceCount = 10;
    repLayer.instanceTransform = CATransform3DMakeTranslation(30, 0, 0);
     
     
     [self.view.layer addSublayer:repLayer];
}



@end
