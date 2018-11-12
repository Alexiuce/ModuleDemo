//
//  XCDecoupleRouter.m
//  ObjcUI
//
//  Created by Alexcai on 2018/11/9.
//  Copyright © 2018 dongjiu. All rights reserved.
//  解耦路由: 根据业务请求实现业务分发

#import "XCDecoupleRouter.h"

@interface XCDecoupleRouter ()

/**
 业务请求回调代理
 */
@property (nonatomic, weak) id <XCDecoupleRequestDelegate> m_delegate;

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

/**  根据业务请求进行路由分发 */
- (void)routerForRequest:(NSURLRequest *)request callback:(id<XCDecoupleRequestDelegate>)handle{
    
    /** 1. 根据request 获取业务目标 */
    /** 2. 分发request 业务到目标 */
    
    if ([handle respondsToSelector:@selector(decoupleRouter:didFinishedRequest:)]) {
        [handle decoupleRouter:self didFinishedRequest:request];
    }
    if ([handle respondsToSelector:@selector(decoupleRouter:didFailureRequest:)]) {
        NSError *error = [NSError errorWithDomain:NSCocoaErrorDomain code:1 userInfo:@{NSLocalizedDescriptionKey:@"error message"}];
        [handle decoupleRouter:self didFailureRequest:error];
    }
}

@end
