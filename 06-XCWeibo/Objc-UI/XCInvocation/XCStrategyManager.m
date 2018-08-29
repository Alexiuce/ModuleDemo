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

@property (nonatomic, strong) NSMutableDictionary <NSString *, NSDictionary *>*paramsDict;;

@property (nonatomic, copy) NSString *paramKey;

@end


@implementation XCStrategyManager


+ (instancetype)defaultManager{
    static dispatch_once_t onceToken;
    static XCStrategyManager *__instance = nil;
    dispatch_once(&onceToken, ^{
        __instance = [[self alloc]init];
        __instance.strategyDict = [NSMutableDictionary dictionaryWithCapacity:10];
        __instance.paramsDict = [NSMutableDictionary dictionaryWithCapacity:10];
        __instance.paramKey = @"__instance_param_key";
    });
    return __instance;
    
}

- (void)appendStrategy:(NSString *)key target:(id)sender selector:(SEL)action param:(NSDictionary *)dict{
    
    NSMethodSignature *signature = [sender methodSignatureForSelector:action];
    NSAssert(signature, @"action must be imlemented");
    NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:signature];
    
    invocation.target = sender;
    invocation.selector = action;
    self.strategyDict[key] = invocation;
    
    // 空的dict,直接返回
    if (dict.allKeys.count < 1) {  return;}
    
    NSString *paramKey = [NSString stringWithFormat:@"%@%@",key,self.paramKey];
    self.paramsDict[paramKey] = dict;
    
}

- (void)appendStrategy:(NSString *)key target:(id)sender selector:(SEL)action{
    [self appendStrategy:key target:sender selector:action param:@{}];
}


- (void)executeStrategyWithKey:(NSString *)strategyKey{
    NSInvocation *invocation = self.strategyDict[strategyKey];
    if (invocation == nil) {return;}
    
    NSString *paramKey = [NSString stringWithFormat:@"%@%@",strategyKey,self.paramKey];
    NSDictionary *param = self.paramsDict[paramKey];
    if (param) {
        [invocation setArgument:&param atIndex:2];
    }
    [invocation invoke];
}

@end
