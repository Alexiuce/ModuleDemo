//
//  XCSelfSuperViewController.m
//  Objc-UI
//
//  Created by Alexcai on 2018/9/28.
//  Copyright © 2018年 Alexcai. All rights reserved.
//

#import "XCSelfSuperViewController.h"
#import "XCPersonView.h"
#import "XCSonView.h"
#import "XCSubSonView.h"


@interface XCSelfSuperViewController ()

@end

@implementation XCSelfSuperViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    XCSonView *son = [XCSonView new];
    NSLog(@"%@",son);
}



@end
