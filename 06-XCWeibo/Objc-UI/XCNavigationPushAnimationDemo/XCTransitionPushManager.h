//
//  XCTransitionPushManager.h
//  Objc-UI
//
//  Created by Alexcai on 2018/10/11.
//  Copyright © 2018 Alexcai. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface XCTransitionPushManager : NSObject<UIViewControllerAnimatedTransitioning>

@property (nonatomic, assign) BOOL isPOP;

@end

NS_ASSUME_NONNULL_END
