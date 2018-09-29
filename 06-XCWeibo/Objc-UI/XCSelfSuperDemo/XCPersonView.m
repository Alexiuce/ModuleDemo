//
//  XCPersonView.m
//  Objc-UI
//
//  Created by Alexcai on 2018/9/28.
//  Copyright © 2018年 Alexcai. All rights reserved.
//

#import "XCPersonView.h"

@implementation XCPersonView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setupUI];
    }
    return self;
}


- (void)setupUI{
    NSLog(@"Person View setup ui");
}

@end
