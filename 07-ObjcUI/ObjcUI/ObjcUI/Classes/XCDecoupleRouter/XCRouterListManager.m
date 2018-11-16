//
//  XCRouterListManager.m
//  ObjcUI
//
//  Created by Alexcai on 2018/11/15.
//  Copyright © 2018 dongjiu. All rights reserved.
//

#import "XCRouterListManager.h"
#import <objc/runtime.h>

@implementation XCRouterListManager


- (UIViewController *)fetchControllerWithRequest:(NSURLRequest *)req{

    NSURL *url = req.URL;
    NSLog(@"host =%@",url.host);
    NSLog(@"scheme =%@",url.scheme);
    
    
    
    int classCount = objc_getClassList(NULL, 0);
    NSLog(@"clss count = %d",classCount);
    
    Class *cls = (Class*)malloc(sizeof(Class)*classCount);
    objc_getClassList(cls, classCount);
    for (int i = 0; i < classCount; ++i) {
        NSString * clsName =  NSStringFromClass(cls[i]);
        if ([clsName hasPrefix:@"XC"] && [clsName hasSuffix:@"Controller"]) {
            NSLog(@"%@",clsName);
        }
    }
    return [UIViewController new];
    
}

    

@end
