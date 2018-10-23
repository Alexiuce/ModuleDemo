//
//  XCPromiseViewController.m
//  Objc-UI
//
//  Created by Alexcai on 2018/10/19.
//  Copyright © 2018 Alexcai. All rights reserved.
//

#import "XCPromiseViewController.h"
#import <PromiseKit/NSURLSession+AnyPromise.h>
#import <AFNetworking/AFNetworking.h>

@interface XCPromiseViewController ()

@end

@implementation XCPromiseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    [format setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:8]];
    format.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    NSDate *date = [format dateFromString:@"2018-10-17 23:10:00"];
    // 半小时后的 时间;
    NSDate *halfHourDate = [[NSDate alloc] initWithTimeInterval:30 * 60 sinceDate:date];
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    calendar.timeZone = format.timeZone;
    NSCalendarUnit dateFlag = NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute;
    
    NSDateComponents *dateComponents =  [calendar components:dateFlag fromDate:halfHourDate];
    NSInteger h = dateComponents.hour;
    NSInteger m  = dateComponents.minute;
    NSLog(@"%zd %zd",h,m);
}

#pragma mark - IBAction
- (IBAction)clickButton:(UIButton *)sender {
    [self afn_fetchData].then(^(id response){
        NSLog(@"%@",response);
    });
//    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
//
//    [self fetchStep1].thenOn(queue,^(NSString *response){
//        NSLog(@"thread = %@",NSThread.currentThread);
//        NSLog(@"resulut =  %@",response);
//    });
    
    
    
//    [self fetchStep1].then(^(id data1){
//        return [self fetchData];
//    }).then(^(id data2){
//        //        NSLog(@"%@",error);
//        NSLog(@"%@",NSThread.currentThread);
//        NSString *string = [[NSString alloc]initWithData:data2 encoding:NSUTF8StringEncoding];
//        NSLog(@"%@",string);
//
//    }).catch(^(NSError *myError){
//        NSLog(@"adfdsf");
//    });
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


- (AnyPromise *)afn_fetchData{
    
    return [AnyPromise promiseWithResolverBlock:^(PMKResolver resolver) {
        
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        [manager POST:@"http://httpbin.org/post" parameters:@{@"afn_1":@"hello promise"} progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            resolver(responseObject);
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            resolver(nil);
        }];
        
    }];
    
}
@end
