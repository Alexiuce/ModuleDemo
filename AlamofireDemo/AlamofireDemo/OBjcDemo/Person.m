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
    if ([super init]) {
        NSLog(@"super ok....%@",[super class]);
        NSLog(@"init self = %@",self);
    }
    return self;
    
}


@end
