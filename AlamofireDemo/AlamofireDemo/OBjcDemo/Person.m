//
//  Person.m
//  OBjcDemo
//
//  Created by Alexcai on 2018/7/12.
//  Copyright © 2018年 alexiuce.github.io. All rights reserved.
//

#import "Person.h"

@implementation Person


- (instancetype)init{
    NSObject * a = [super init];
    if (a) {
        NSLog(@"a = %@",a);
        NSLog(@"super ok....%@",[super class]);
        NSLog(@"init self = %@",self);
    }
    return self;
    
}


@end
