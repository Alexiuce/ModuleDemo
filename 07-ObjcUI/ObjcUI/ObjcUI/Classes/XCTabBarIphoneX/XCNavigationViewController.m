//
//  XCNavigationViewController.m
//  ObjcUI
//
//  Created by Alexcai on 2018/11/6.
//  Copyright © 2018 dongjiu. All rights reserved.
//

#import "XCNavigationViewController.h"

@interface XCNavigationViewController ()

@end

@implementation XCNavigationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    [super pushViewController:viewController animated:animated];
    // 修改tabBra的frame
    CGRect frame = self.tabBarController.tabBar.frame;
    frame.origin.y = [UIScreen mainScreen].bounds.size.height - frame.size.height;
    self.tabBarController.tabBar.frame = frame;
}

@end
