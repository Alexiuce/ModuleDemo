//
//  XCDecoupleRouter.m
//  ObjcUI
//
//  Created by Alexcai on 2018/11/9.
//  Copyright © 2018 dongjiu. All rights reserved.
//  解耦路由: 根据业务请求实现业务分发

#import "XCDecoupleRouter.h"

@interface XCDecoupleRouter ()



@end

@implementation XCDecoupleRouter

+ (instancetype)defaultRouter{
    static dispatch_once_t onceToken;
    static XCDecoupleRouter *m_instance = nil;
    dispatch_once(&onceToken, ^{
        m_instance = [self new];
    });
    return m_instance;
}


@end
