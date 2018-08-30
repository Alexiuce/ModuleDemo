//
//  XCStrategyManager.h
//  Objc-UI
//
//  Created by Alexcai on 2018/8/29.
//  Copyright © 2018年 Alexcai. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XCStrategyManager : NSObject

/**
 策略管理者 单利对象

 @return 创建好的管理者单利对象
 */
//+ (instancetype)defaultManager;

/**
 添加策略到管理者中(含参数)

 @param key 策略的key
 @param sender 策略的执行对象 (不会对sender 进行强应用)
 @param dict 策略的参数
 */
+ (void)appendStrategy:(nonnull NSString *)key target:(id)sender selector:(SEL)action param:(nonnull NSDictionary *)dict;


/**
  添加策略到管理者中(不含参数)

 @param key 策略的key
 @param sender 策略的执行对象
 @param action 策略的方法
 */
+ (void)appendStrategy:(nonnull NSString *)key target:(id)sender selector:(SEL)action;

/**
 执行策略
 */
+ (void)executeStrategyWithKey:(nonnull NSString *)strategyKey;


/**
 移除指定key键的策略

 @param key 需要移除策略的key
 */
+ (void)removeStrategy:(nonnull NSString *)key;

/**
 移除所有策略
 */
+ (void)removeAllStrategy;


@end
