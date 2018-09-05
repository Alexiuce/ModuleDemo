//
//  XCInvocationController.m
//  Objc-UI
//
//  Created by Alexcai on 2018/8/29.
//  Copyright © 2018年 Alexcai. All rights reserved.
//

#import "XCInvocationController.h"

#import "XCStrategyManager.h"

#import "XCTestMan.h"

@interface XCInvocationController ()



@end

@implementation XCInvocationController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSDictionary *dict = @{@"a":@"good",@"b": self};
   
    [XCStrategyManager appendStrategy:@"test_s" target:self selector:@selector(testStrategy123:) param:dict];
    
    XCTestMan *tm = [[XCTestMan alloc]init];

    [XCStrategyManager appendStrategy:@"man_test" target:tm selector:@selector(testStrategy)];

}

- (void)testStrategy123:(NSDictionary *)dict{
    NSLog(@"%@",dict);
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    [XCStrategyManager executeStrategyWithKey:@"test_s"];
    [XCStrategyManager executeStrategyWithKey:@"man_test"];
}

@end
