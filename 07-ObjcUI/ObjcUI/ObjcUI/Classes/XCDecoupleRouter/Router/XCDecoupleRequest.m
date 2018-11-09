//
//  XCDecoupleRequest.m
//  ObjcUI
//
//  Created by Alexcai on 2018/11/9.
//  Copyright © 2018 dongjiu. All rights reserved.
//  解耦请求: 每个请求对应一个业务跳转的逻辑

#import "XCDecoupleRequest.h"

@interface XCDecoupleRequest ()

/**
 业务请求的url
 */
@property (nonatomic, strong) NSURL *m_url;

@end

@implementation XCDecoupleRequest

+ (instancetype)decoupleRequestWithURL:(NSURL *)url{
    return [[self alloc] initWithXCDecoupleURL:url];
}
- (instancetype)initWithXCDecoupleURL:(NSURL *)requestURL{
    if (self = [super init]) {
        _m_url = requestURL;
    }
    return self;
}

@end
