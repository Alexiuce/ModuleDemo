//
//  XCMusicManager.m
//  ObjcUI
//
//  Created by Alexcai on 2018/10/27.
//  Copyright © 2018 dongjiu. All rights reserved.
//

#import "XCMusicManager.h"

@implementation XCMusicManager

+ (instancetype)shareManager{
    static dispatch_once_t onceToken;
    static XCMusicManager *__instance;
    dispatch_once(&onceToken, ^{
        __instance =  [[self alloc]init];
    });
    return __instance;
}

@end
