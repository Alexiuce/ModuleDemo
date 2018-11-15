//
//  XCRouterListManager.m
//  ObjcUI
//
//  Created by Alexcai on 2018/11/15.
//  Copyright © 2018 dongjiu. All rights reserved.
//

#import "XCRouterListManager.h"

@implementation XCRouterListManager


- (UIViewController *)fetchControllerWithRequest:(NSURLRequest *)req{

    NSURL *url = req.URL;
    NSLog(@"host =%@",url.host);
    NSLog(@"scheme =%@",url.scheme);
    return [UIViewController new];
    
}

    

@end
