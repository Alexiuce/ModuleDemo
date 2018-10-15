//
//  XCURLProtocol.m
//  Objc-UI
//
//  Created by Alexcai on 2018/10/15.
//  Copyright © 2018 Alexcai. All rights reserved.
//

#import "XCURLProtocol.h"

@implementation XCURLProtocol


+ (BOOL)canInitWithRequest:(NSURLRequest *)request{
    
    if ([NSURLProtocol propertyForKey:request.URL.absoluteString inRequest:request]) {
        return NO;
    }
    
    NSString *scheme = request.URL.scheme;
    return  [scheme hasPrefix:@"http"] || [scheme hasPrefix:@"https"];
}

+ (NSURLRequest *)canonicalRequestForRequest:(NSURLRequest *)request{
    return request;
}




@end
