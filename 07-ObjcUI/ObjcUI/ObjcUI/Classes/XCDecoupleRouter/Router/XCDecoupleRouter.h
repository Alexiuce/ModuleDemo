//
//  XCDecoupleRouter.h
//  ObjcUI
//
//  Created by Alexcai on 2018/11/9.
//  Copyright © 2018 dongjiu. All rights reserved.
//  解耦路由: 根据业务请求实现业务分发

#import <Foundation/Foundation.h>


@class XCDecoupleRouter;


@protocol XCDecoupleRequestDelegate <NSObject>

@optional

/**
 路由分发完成

 @param router 业务路由
 @param req 业务请求
 */
- (void)decoupleRouter:(XCDecoupleRouter *)router didFinishedRequest:(NSURLRequest *)req;

/**
 路由分发业务失败

 @param router 业务路由
 @param err 错误信息
 */
- (void)decoupleRouter:(XCDecoupleRouter *)router didFailureRequest:(NSError *)err;

@end


NS_ASSUME_NONNULL_BEGIN

@interface XCDecoupleRouter : NSObject

/**
 单利方法

 @return 返回一个路由单利对象
 */
+ (instancetype)defaultRouter;


/**
 根据业务请求进行路由分发

 @param request 业务请求
 @param handle 分发请求事件回调响应对象
 */
- (void)routerForRequest:(NSURLRequest *)request callback:(id <XCDecoupleRequestDelegate>)handle;

@end

NS_ASSUME_NONNULL_END
