//
//  URLProtocolViewController.m
//  Objc-UI
//
//  Created by Alexcai on 2018/10/13.
//  Copyright © 2018 Alexcai. All rights reserved.
//

#import "URLProtocolViewController.h"

@interface URLProtocolViewController ()
@property (weak, nonatomic) IBOutlet UIButton *requestButton;

@end

@implementation URLProtocolViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
}
#pragma mark - IBAction Event Handler
/** 点击网络请求按钮事件处理 */
- (IBAction)clickRequestButtonEvent:(UIButton *)sender {

    
    NSURL *url = [NSURL URLWithString:@"http://www.baidu.com"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    NSURLSession *session = [[NSURLSession alloc]init];
   
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        NSString *result = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"%@",result);
        
    }];
    [dataTask resume];

}


@end
