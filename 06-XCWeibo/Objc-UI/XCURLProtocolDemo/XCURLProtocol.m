//
//  XCURLProtocol.m
//  Objc-UI
//
//  Created by Alexcai on 2018/10/15.
//  Copyright © 2018 Alexcai. All rights reserved.
//

#import "XCURLProtocol.h"


@interface XCURLProtocol ()

@property (nonatomic, strong)NSURLRequest *request;

@end

@implementation XCURLProtocol


+ (BOOL)canInitWithRequest:(NSURLRequest *)request{
    
    if ([NSURLProtocol propertyForKey:request.URL.absoluteString inRequest:request]) {
        return NO;
    }
    
    NSString *scheme = request.URL.scheme;
    NSLog(@"url scheme == %@",scheme);
    return  [scheme hasPrefix:@"http"] || [scheme hasPrefix:@"https"];
}

+ (NSURLRequest *)canonicalRequestForRequest:(NSURLRequest *)request{
    return request;
}


- (void)startLoading{
    
    NSMutableURLRequest *request = [self.request mutableCopy];
    [NSURLProtocol setProperty:@YES forKey:request.URL.absoluteString inRequest:request];
    
    NSURLSessionConfiguration *config = NSURLSessionConfiguration.defaultSessionConfiguration;
    NSURLSession *session = [NSURLSession sessionWithConfiguration:config];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        if (error) {
            [self.client URLProtocol:self didFailWithError:error];
        }else{
            [self.client URLProtocol:self didLoadData:data];
        }
        
    }];
    
    [task resume];
}

- (void)stopLoading{
    
}



@end
