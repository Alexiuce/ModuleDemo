//
//  XCInvocationController.m
//  Objc-UI
//
//  Created by Alexcai on 2018/8/29.
//  Copyright © 2018年 Alexcai. All rights reserved.
//

#import "XCInvocationController.h"

#import "XCStrategyManager.h"

@interface XCInvocationController ()

@end

@implementation XCInvocationController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSDictionary *dict = @{@"a":@"good"};
    XCStrategyManager *sm = [XCStrategyManager defaultManager];
    [sm appendStrategy:@"test_s" target:self selector:@selector(testStrategy:) param:dict];
}



- (void)testStrategy:(NSDictionary *)dict{
    NSLog(@"%@",dict);
    
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    XCStrategyManager *sm = [XCStrategyManager defaultManager];
    [sm executeStrategyWithKey:@"test_s"];
}

@end
