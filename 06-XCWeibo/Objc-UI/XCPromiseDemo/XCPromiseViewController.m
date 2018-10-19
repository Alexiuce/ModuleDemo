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
    
    
    
    
    NSURLSession *session = [NSURLSession sessionWithConfiguration:NSURLSessionConfiguration.defaultSessionConfiguration];
    NSURLRequest *request1 = [NSURLRequest requestWithURL:[NSURL URLWithString:@"https://www.baidu.com"]];
    
    
//    [[session dataTaskWithRequest:request1 completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
//        NSLog(@"adfasdfasdf");
//    }] resume] ;
    
    [session promiseDataTaskWithRequest:request1].then(^(id data1){
        return [self postURL:nil];
    }).then(^(id data2){
        
        NSString *string = [[NSString alloc]initWithData:data2 encoding:NSUTF8StringEncoding];
        NSLog(@"%@",string);
        
    });
    // Do any additional setup after loading the view.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

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

@end
