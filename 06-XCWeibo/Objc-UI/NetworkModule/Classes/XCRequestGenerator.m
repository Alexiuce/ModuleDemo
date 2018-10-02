//
//  XCRequestGenerator.m
//  Objc-UI
//
//  Created by Alexcai on 2018/10/2.
//  Copyright © 2018 Alexcai. All rights reserved.
//  生成NSURLRequest 请求

#import "XCRequestGenerator.h"
#import "RequestModel.h"




@implementation XCRequestGenerator

- (NSURLRequest *)generateRequest:(RequestModel *)model{

    NSURL *url = [NSURL URLWithString:model.apiMethodPath];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    return request;
}

- (void)test{
    
}

@end
