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
    self.view.backgroundColor = UIColor.whiteColor;
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    [super pushViewController:viewController animated:animated];
 
}

@end
