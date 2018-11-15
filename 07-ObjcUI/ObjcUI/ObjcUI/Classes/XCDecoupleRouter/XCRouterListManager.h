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

    
- (UIViewController *)fetchControllerWithRequest:(NSURLRequest *)req;
    
@end

NS_ASSUME_NONNULL_END
