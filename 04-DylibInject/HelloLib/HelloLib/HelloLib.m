//
//
// HelloLib.m
// Created by Alex on 2018/4/20
// Copyright © 2018年 hfapp.com.joinf.www. All rights reserved.
//

#import "HelloLib.h"
#import <AppKit/AppKit.h>
#import "Aspects.h"


@implementation HelloLib

+ (void)load{
    NSLog(@"==============HelloLib already loaded =================");
    
    id viewController = NSClassFromString(@"ViewController");
    [viewController aspect_hookSelector:@selector(viewDidLoad) withOptions:AspectPositionAfter usingBlock:^(id<AspectInfo> info) {
        id instance = info.instance;
        NSTextField *targetLabel = [instance valueForKeyPath:@"titleLabel"];
        targetLabel.stringValue = @"Text Already changed from HelloLib";
    } error:nil ];
    
}

@end
