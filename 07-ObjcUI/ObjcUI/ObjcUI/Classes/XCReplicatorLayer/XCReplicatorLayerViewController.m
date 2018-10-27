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
    CAReplicatorLayer *repLayer = [CAReplicatorLayer layer];
    repLayer.position = CGPointMake(10, 100);
    
    // Do any additional setup after loading the view.
}



@end
