//
//  XCRouterListManager.h
//  ObjcUI
//
//  Created by Alexcai on 2018/11/15.
//  Copyright © 2018 dongjiu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN

@interface XCRouterListManager : NSObject

    
/**
 根据请求获取一个业务控制器

 @param req 业务请求
 @return 返回一个响应此业务请求的控制器
 */
- (UIViewController *)fetchControllerWithRequest:(NSURLRequest *)req;
    
@end

NS_ASSUME_NONNULL_END
