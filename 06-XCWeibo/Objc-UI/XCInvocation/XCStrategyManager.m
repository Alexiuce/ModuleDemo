//
//  XCStrategyManager.m
//  Objc-UI
//
//  Created by Alexcai on 2018/8/29.
//  Copyright © 2018年 Alexcai. All rights reserved.
//

#import "XCStrategyManager.h"

@interface XCStrategyManager()

// 策略字典: key -> NSInvocation
@property (nonatomic, strong)NSMutableDictionary <NSString*, NSInvocation*>*strategyDict;


@end


@implementation XCStrategyManager


+ (instancetype)defaultManager{
    static dispatch_once_t onceToken;
    static XCStrategyManager *__instance = nil;
    dispatch_once(&onceToken, ^{
        __instance = [[self alloc]init];
        __instance.strategyDict = [NSMutableDictionary dictionaryWithCapacity:10];
    });
    return __instance;
    
}

- (void)appendStrategy:(NSString *)key target:(id)sender selector:(SEL)action param:(NSDictionary *)dict{
    
//    NSMethodSignature *signature = [sender class] si
    
}


- (void)executeStrategyWithKey:(NSString *)strategyKey{
    
}

@end
