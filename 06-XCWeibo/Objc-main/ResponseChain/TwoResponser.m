//
//  TwoResponser.m
//  Objc-main
//
//  Created by Alexcai on 2018/9/17.
//  Copyright © 2018年 Alexcai. All rights reserved.
//

#import "TwoResponser.h"

@implementation TwoResponser

- (void)doSomething:(NSString *)thing responser:(id<XCResponseProtocol>)responser{
    if ([thing isEqualToString:@"2"]) {
        NSLog(@"this is my work...2");
        return;
    }
    [responser doSomething:thing responser:responser];
}

@end
