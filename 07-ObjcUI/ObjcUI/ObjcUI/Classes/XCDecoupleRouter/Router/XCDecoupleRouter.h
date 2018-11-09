//
//  XCDecoupleRouter.h
//  ObjcUI
//
//  Created by Alexcai on 2018/11/9.
//  Copyright © 2018 dongjiu. All rights reserved.
//  解耦路由: 根据业务请求实现业务分发

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface XCDecoupleRouter : NSObject

/**
 单利方法

 @return 返回一个路由单利对象
 */
+ (instancetype)defaultRouter;



@end

NS_ASSUME_NONNULL_END
