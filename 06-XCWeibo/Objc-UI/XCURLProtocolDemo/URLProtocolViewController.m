//
//  URLProtocolViewController.m
//  Objc-UI
//
//  Created by Alexcai on 2018/10/13.
//  Copyright © 2018 Alexcai. All rights reserved.
//

#import "URLProtocolViewController.h"
#import "AFNetworking.h"

@interface URLProtocolViewController ()
@property (weak, nonatomic) IBOutlet UIButton *requestButton;

@property (nonatomic, strong)NSURLSession *session;

@end

@implementation URLProtocolViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
}
#pragma mark - IBAction Event Handler
/** 点击网络请求按钮事件处理 */
- (IBAction)clickRequestButtonEvent:(UIButton *)sender {

//    
//    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
//    
//    
//    [manager POST:@"http://www.baidu.com" parameters:nil constructingBodyWithBlock:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        
//        NSLog(@"%@",responseObject);
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        NSLog(@"%@",error.localizedDescription);
//    }];
    
    
    NSURL *url = [NSURL URLWithString:@"http://www.baidu.com"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
//
    self.session = [NSURLSession sessionWithConfiguration:NSURLSessionConfiguration.defaultSessionConfiguration];
//
    NSURLSessionDataTask *dataTask = [self.session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {

        NSString *result = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"%@",result);

    }];
    [dataTask resume];

}


@end
