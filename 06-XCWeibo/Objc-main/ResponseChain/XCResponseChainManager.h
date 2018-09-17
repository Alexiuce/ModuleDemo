//
//  XCResponseChainManager.h
//  Objc-main
//
//  Created by Alexcai on 2018/9/17.
//  Copyright © 2018年 Alexcai. All rights reserved.
//  响应链管理者: 遍历调用响应链条中的每个对象,直到找到事件响应者处理事件为止;

#import <Foundation/Foundation.h>
#import "XCResponseProtocol.h"

@interface XCResponseChainManager : NSObject

- (instancetype)addResponser:(id <XCResponseProtocol>)responser;

- (void)doSomething:(NSString *)thing;
@end
