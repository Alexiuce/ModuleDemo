//
//  XCTabBarViewController.m
//  ObjcUI
//
//  Created by Alexcai on 2018/11/6.
//  Copyright © 2018 dongjiu. All rights reserved.
//

#import "XCTabBarViewController.h"
#import "XCIphoneXTabBar.h"

@interface XCTabBarViewController ()

@end

@implementation XCTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    XCIphoneXTabBar *tb = [XCIphoneXTabBar new];
    [self setValue:tb forKey:@"tabBar"];
    self.view.backgroundColor = UIColor.whiteColor;
}



@end
