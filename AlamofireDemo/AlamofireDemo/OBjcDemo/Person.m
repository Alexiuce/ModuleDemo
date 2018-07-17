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
    
    NSLog(@"self == %@",self);
    NSObject * a = [super init];
    if (a) {
        NSLog(@"a = %@",a);
        NSLog(@"super ok....%@",[super class]);
        NSLog(@"init self = %@",self);
        
        NSString *sss = ({
            NSLog(@"hello ....ssss dfasdfsad");
            int a = 10;
            NSLog(@"%d", a + 2);
            @"ggod";
            
        });
        NSLog(@"%@",sss);
    
    }
    return self;
    
}

const int OCInt = 20;

const NSString *myString = @"hello";

@end
