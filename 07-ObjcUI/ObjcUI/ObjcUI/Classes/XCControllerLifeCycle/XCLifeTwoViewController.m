//
//  XCLifeTwoViewController.m
//  ObjcUI
//
//  Created by Alexcai on 2018/10/29.
//  Copyright © 2018 dongjiu. All rights reserved.
//

#import "XCLifeTwoViewController.h"

@interface XCLifeTwoViewController ()

@end

@implementation XCLifeTwoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    NSLog(@"%s",__FUNCTION__);
}


- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    NSLog(@"%s",__FUNCTION__);
}
/**
 点击 dismiss 按钮事件

 @param sender 退出按钮
 */
- (IBAction)exitViewController:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}


@end
