//
//  XCURLProtocol.m
//  Objc-UI
//
//  Created by Alexcai on 2018/10/15.
//  Copyright © 2018 Alexcai. All rights reserved.
//

#import "XCURLProtocol.h"


@interface XCURLProtocol ()<NSURLSessionDelegate,NSURLSessionTaskDelegate>

@property (nonatomic, strong) NSURLSessionDataTask *xc_dataTask;

@property (nonatomic, strong) NSURLSession *xc_session;

@end

@implementation XCURLProtocol


+ (BOOL)canInitWithRequest:(NSURLRequest *)request{
    
    if ([NSURLProtocol propertyForKey:request.URL.absoluteString inRequest:request]) {
        return NO;
    }
    
    NSString *scheme = request.URL.scheme;
    NSLog(@"url scheme == %@",request.URL.absoluteString);
    return  [scheme hasPrefix:@"http"] || [scheme hasPrefix:@"https"];
}

+ (NSURLRequest *)canonicalRequestForRequest:(NSURLRequest *)request{
    return request;
}


- (void)startLoading{
    
    NSMutableURLRequest *request = [self.request mutableCopy];
    request.URL = [NSURL URLWithString:@"https://www.163.com"];
    [NSURLProtocol setProperty:@YES forKey:request.URL.absoluteString inRequest:request];
    
    NSURLSessionConfiguration *config = NSURLSessionConfiguration.defaultSessionConfiguration;
    self.xc_session = [NSURLSession sessionWithConfiguration:config delegate:self delegateQueue:NSOperationQueue.mainQueue];
  
    self.xc_dataTask = [self.xc_session dataTaskWithRequest:request];
    
    [self.xc_dataTask resume];
}

+ (BOOL)requestIsCacheEquivalent:(NSURLRequest *)a toRequest:(NSURLRequest *)b{
    return [super requestIsCacheEquivalent:a toRequest:b];
}

- (void)stopLoading{
    [self.xc_dataTask cancel];
}
#pragma mark -NSURLSessionDelegate


#pragma mark -NSURLSessionTaskDelegate
- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveResponse:(NSURLResponse *)response completionHandler:(void (^)(NSURLSessionResponseDisposition))completionHandler {
    [self.client URLProtocol:self didReceiveResponse:response cacheStoragePolicy:NSURLCacheStorageAllowed];
    
    completionHandler(NSURLSessionResponseAllow);
}

- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveData:(NSData *)data {
    [self.client URLProtocol:self didLoadData:data];
    NSString *dataText = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    NSLog(@"response data == %@",dataText);
}




@end
