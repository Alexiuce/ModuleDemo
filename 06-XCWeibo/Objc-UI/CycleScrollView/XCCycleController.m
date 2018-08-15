//
//  XCCycleController.m
//  Objc-UI
//
//  Created by Alexcai on 2018/8/15.
//  Copyright © 2018年 Alexcai. All rights reserved.
//

#import "XCCycleController.h"
#import <SDCycleScrollView/SDCycleScrollView.h>

@interface XCCycleController ()

@end

@implementation XCCycleController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIView *topView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 200)];
    topView.backgroundColor = UIColor.lightGrayColor;
    [self.view addSubview:topView];
    
    
    
    
}



@end
