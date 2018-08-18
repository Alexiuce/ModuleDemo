//
//  SAFrameObj.m
//  Objc-UI
//
//  Created by Alexcai on 2018/8/18.
//  Copyright © 2018年 Alexcai. All rights reserved.
//

#import "SAFrameObj.h"

@interface SAFrameObj()

@end


@implementation SAFrameObj

+ (instancetype)shareFrame{
    static SAFrameObj *_instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[self alloc] init];
    });
    return _instance;
}

- (CGRect)ScreenBounce{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        self->_screenBounds = [UIScreen mainScreen].bounds;
    });
    return _screenBounds;
}

@end
