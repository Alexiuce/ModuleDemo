//
//  SuperPlayerPrefs.m
//  TXLiteAVDemo
//
//  Created by annidyfeng on 2018/6/26.
//  Copyright © 2018年 Tencent. All rights reserved.
//

#import "SuperPlayerGlobleConfig.h"
#import "SuperPlayer.h"

#define FLOAT_VIEW_WIDTH  200
#define FLOAT_VIEW_HEIGHT 112


@implementation SuperPlayerGlobleConfig

+ (instancetype)sharedInstance {
    static SuperPlayerGlobleConfig *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[SuperPlayerGlobleConfig alloc] init];
    });
    return instance;
}

- (instancetype)init {
    self = [super init];
    
    _enableFloatWindow = YES;
    _floatViewSize = CGSizeMake(FLOAT_VIEW_WIDTH, FLOAT_VIEW_HEIGHT);
    // 右下角
    _floatViewOrigin = CGPointMake(ScreenWidth-_floatViewSize.width, ScreenHeight-_floatViewSize.height);
    
    _enableHWAcceleration = YES;
    
    _renderMode = RENDER_MODE_FILL_EDGE;
    
    _playRate = 1.0;
    
    _mirror = NO;

    
    return self;
}

@end
