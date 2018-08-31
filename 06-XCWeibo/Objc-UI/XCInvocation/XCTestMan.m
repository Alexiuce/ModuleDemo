//
//  XCTestMan.m
//  Objc-UI
//
//  Created by Alexcai on 2018/8/29.
//  Copyright © 2018年 Alexcai. All rights reserved.
//

#import "XCTestMan.h"

#import "XCStrategyManager.h"


@implementation XCTestMan


- (instancetype)init{
    if (self = [super init]) {
        _name = @"alex";
        [XCStrategyManager appendStrategy:@"eat" target:self selector:@selector(eatLaunch)];
        
        [XCStrategyManager appendStrategy:@"showName" target:self selector:@selector(showName:) param:@{@"name":self}];
        [XCStrategyManager appendStrategy:@"fetch" target:self selector:@selector(fetchInfo)];
    }
    return self;
}

- (void)testStrategy{
    
    [XCStrategyManager executeStrategyWithKey:@"eat"];
    [XCStrategyManager executeStrategyWithKey:@"showName"];
    
    
}

- (void)showName:(NSDictionary *)param{
    NSLog(@"show the name is %@",param[@"name"]);
    
}
- (void)manSleep{
    NSLog(@"%s",__FUNCTION__);
}
- (void)requestForHelp{
      NSLog(@"%s",__FUNCTION__);
}

- (void)eatLaunch{
    NSLog(@"%s",__FUNCTION__);
}
- (void)fetchInfo{
    NSLog(@"%s",__FUNCTION__);
}
- (void)runFoward{
    NSLog(@"%s",__FUNCTION__);
}
- (void)gohome{
    NSLog(@"%s",__FUNCTION__);
}
- (void)sayHello{
    NSLog(@"%s",__FUNCTION__);
}

- (void)dealloc{
    NSLog(@"%s",__FUNCTION__);
}

@end
