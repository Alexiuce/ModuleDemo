//
//  ThirdResponser.m
//  Objc-main
//
//  Created by Alexcai on 2018/9/17.
//  Copyright © 2018年 Alexcai. All rights reserved.
//

#import "ThirdResponser.h"

@implementation ThirdResponser

- (void)doSomething:(NSString *)thing responser:(id<XCResponseProtocol>)responser{
    if ([thing isEqualToString:@"3"]) {
        NSLog(@"this is my work...3");
        return;
    }
    [responser doSomething:thing responser:responser];
}

@end
