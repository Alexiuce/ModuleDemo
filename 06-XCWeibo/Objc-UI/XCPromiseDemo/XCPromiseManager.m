//
//  XCPromiseManager.m
//  Objc-UI
//
//  Created by Alexcai on 2018/10/23.
//  Copyright © 2018 Alexcai. All rights reserved.
//

#import "XCPromiseManager.h"

@interface XCPromiseManager ()

@property (nonatomic, strong) XCPromiseBlock m_block;


@end


@implementation XCPromiseManager


+ (instancetype)managerWithBlock:(void (^)(XCPromiseBlock))block{
    return [[self alloc]initWithBlock:block];
}

- (instancetype)initWithBlock:(void (^)(XCPromiseBlock))block{
    if (self = [super init]) {
        self.m_block = block;
    }
    return self;
}


- (void (^)(id))doAfter{
    return ^(id obj){
//        if (self.m_block) {
//            self.m_block();
//        }
    };
}

@end
