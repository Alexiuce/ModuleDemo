//
//  XCPromiseManager.h
//  Objc-UI
//
//  Created by Alexcai on 2018/10/23.
//  Copyright © 2018 Alexcai. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN


typedef void(^XCPromiseBlock)(id);


@interface XCPromiseManager : NSObject

+ (instancetype)managerWithBlock:(void (^)(XCPromiseBlock resolver))block;



- (void (^)(id p_block))doAfter;

@end

NS_ASSUME_NONNULL_END
