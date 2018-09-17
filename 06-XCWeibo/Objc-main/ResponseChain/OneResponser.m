//
//  OneResponser.m
//  Objc-main
//
//  Created by Alexcai on 2018/9/17.
//  Copyright © 2018年 Alexcai. All rights reserved.
//

#import "OneResponser.h"

@implementation OneResponser

- (void)doSomething:(NSString *)thing responser:(id<XCResponseProtocol>)responser{
    if ([thing isEqualToString:@"1"]) {
        NSLog(@"this is my work...1");
        return;
    }
    [responser doSomething:thing responser:responser];
}

@end
