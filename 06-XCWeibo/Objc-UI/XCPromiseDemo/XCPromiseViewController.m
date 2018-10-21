//
//  XCPromiseViewController.m
//  Objc-UI
//
//  Created by Alexcai on 2018/10/19.
//  Copyright © 2018 Alexcai. All rights reserved.
//

#import "XCPromiseViewController.h"
#import <PromiseKit/NSURLSession+AnyPromise.h>

@interface XCPromiseViewController ()

@end

@implementation XCPromiseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    

}

#pragma mark - IBAction
- (IBAction)clickButton:(UIButton *)sender {
    
    [self fetchStep1].then(^(id data1){
        return [self fetchData];
    }).then(^(id data2){
        //        NSLog(@"%@",error);
        NSLog(@"%@",NSThread.currentThread);
        NSString *string = [[NSString alloc]initWithData:data2 encoding:NSUTF8StringEncoding];
        NSLog(@"%@",string);
        
    }).catch(^(NSError *myError){
        NSLog(@"adfdsf");
    });
}


- (AnyPromise *)fetchStep1{
    NSURLSession *session = [NSURLSession sessionWithConfiguration:NSURLSessionConfiguration.defaultSessionConfiguration];
    NSURLRequest *request1 = [NSURLRequest requestWithURL:[NSURL URLWithString:@"https://www.baidu.com"]];
    
    
    //    [[session dataTaskWithRequest:request1 completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
    //        NSLog(@"adfasdfasdf");
    //    }] resume] ;
    return [session promiseDataTaskWithRequest:request1];
    
}

- (AnyPromise *)postURL:(NSString *)url{
    return [AnyPromise promiseWithResolverBlock:^(PMKResolver resolver) {
        NSURLSession *s = [NSURLSession sessionWithConfiguration:NSURLSessionConfiguration.defaultSessionConfiguration];
        
        NSURL *url = [NSURL URLWithString:@"http://httpbin.org/get"];
        NSURLRequest *request = [NSURLRequest requestWithURL:url];
        [[s dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            if (error) {
                resolver(error);
            }else{
                resolver(data);
            }
        }]resume] ;
    }];
}


- (AnyPromise *)fetchData{
    return [AnyPromise promiseWithAdapterBlock:^(PMKAdapter  _Nonnull adapter) {
        NSURLSession *s = [NSURLSession sessionWithConfiguration:NSURLSessionConfiguration.defaultSessionConfiguration];
        
        NSURL *url = [NSURL URLWithString:@"http://httpbin.org/get"];
        NSURLRequest *request = [NSURLRequest requestWithURL:url];
        [[s dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
//            NSError *e = [NSError errorWithDomain:NSCocoaErrorDomain code:100 userInfo:nil];
            adapter(data,nil);
        }]resume] ;
    }];
}
@end
