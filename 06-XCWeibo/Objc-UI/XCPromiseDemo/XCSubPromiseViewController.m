//
//  XCSubPromiseViewController.m
//  Objc-UI
//
//  Created by Alexcai on 2018/10/22.
//  Copyright © 2018 Alexcai. All rights reserved.
//

#import "XCSubPromiseViewController.h"

#import <PromiseKit/PromiseKit.h>
#import <AFNetworking/AFNetworking.h>
#import "XCPromiseManager.h"


@interface XCSubPromiseViewController ()

@property (nonatomic, assign) NSUInteger loadIndex;
@property (nonatomic, strong)AnyPromise *myPromise;

@property (nonatomic, strong) XCPromiseManager *m_manager;

@end

@implementation XCSubPromiseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.m_manager = [XCPromiseManager managerWithBlock:^(id obj) {
        NSLog(@"view did load");
        NSLog(@"%@",obj);
    }];
    self.m_manager.doAfter(^(id obj){
        NSLog(@"do after manager");
    });
    
}


- (IBAction)clickButton:(UIButton *)sender {
    [self sub_afnFetchData].then(^(id result){
        NSLog(@"result = %@",result);
        
    }).catch(^(NSError *error){
        NSLog(@"%@",error.localizedDescription);
    });
    
}



- (AnyPromise *)sub_afnFetchData{
    self.myPromise = [AnyPromise promiseWithResolverBlock:^(PMKResolver resolver) {
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        self.loadIndex = 1;
        
        [manager POST:@"http://httpbin.org/post" parameters:@{} progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
            resolver(responseObject);
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            resolver(error);
        }];
    }];
    return self.myPromise;
}

- (void)dealloc{
    NSLog(@"%s", __FUNCTION__);
}
@end
