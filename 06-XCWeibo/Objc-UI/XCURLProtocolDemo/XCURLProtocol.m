//
//  XCURLProtocol.m
//  Objc-UI
//
//  Created by Alexcai on 2018/10/15.
//  Copyright © 2018 Alexcai. All rights reserved.
//

#import "XCURLProtocol.h"


@interface XCURLProtocol ()

@property (nonatomic, strong) NSURLSessionDataTask *xc_dataTask;

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
    request.URL = [NSURL URLWithString:@"http://www.httpbin.org/get"];
    [NSURLProtocol setProperty:@YES forKey:request.URL.absoluteString inRequest:request];
    
    NSURLSessionConfiguration *config = NSURLSessionConfiguration.defaultSessionConfiguration;
    NSURLSession *session = [NSURLSession sessionWithConfiguration:config];
    self.xc_dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        if (error) {
            [self.client URLProtocol:self didFailWithError:error];
        }else{
            [self.client URLProtocol:self didLoadData:data];
        }
        
    }];
    
    [self.xc_dataTask resume];
}

+ (BOOL)requestIsCacheEquivalent:(NSURLRequest *)a toRequest:(NSURLRequest *)b{
    return [super requestIsCacheEquivalent:a toRequest:b];
}


- (void)stopLoading{
    [super stopLoading];
}



@end
