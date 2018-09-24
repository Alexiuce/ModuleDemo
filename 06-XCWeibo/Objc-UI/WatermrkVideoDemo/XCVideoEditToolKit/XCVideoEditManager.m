//
//  XCVideoEditManager.m
//  Objc-UI
//
//  Created by Alexcai on 2018/9/24.
//  Copyright © 2018年 Alexcai. All rights reserved.
//

#import "XCVideoEditManager.h"
#import <AVFoundation/AVFoundation.h>
#import <UIKit/UIKit.h>
#import "XCVideoEditComposition.h"


typedef NS_ENUM(NSInteger,XCEditVideoErroeCode) {
    XCEditVideoNotFoundError = 100
};


@interface XCVideoEditManager()

@property (nonatomic, strong)NSDictionary <NSNumber *,NSString*>*errorDict;

@end


@implementation XCVideoEditManager

+ (instancetype)defaultManager{
    return [[self alloc]init];
}



- (void)startEditVideo:(NSString *)videoName progress:(XCEditingProgressBlock)progressBlock success:(XCEditedSuccessBlock)successBlock failure:(XCEditedFailureBlock)failureBlock{
    // 1. 加载本地视频资源
    AVAsset *videoAsset = [self loadLocalAsset:videoName];
    // 2. 判断视频加载是否正常
    if (videoAsset == nil) {
        failureBlock?: failureBlock([self errorWithCode:XCEditVideoNotFoundError]);
        return;
    }
    XCVideoEditComposition *composition = [XCVideoEditComposition compositionWithAsset:videoAsset];
    
    
}



- (AVAsset *)loadLocalAsset:(NSString *)path{
    NSString *localPath = [NSBundle.mainBundle pathForResource:path ofType:nil];
    AVAsset *asset = [AVAsset assetWithURL:[NSURL fileURLWithPath:localPath]];
    return asset;
}

- (NSError *)errorWithCode:(NSInteger)errorCode{
    
    return  [NSError errorWithDomain:@"XCVideoErrorDomain" code:errorCode userInfo:@{NSLocalizedDescriptionKey:self.errorDict[@(errorCode)]}];
}

#pragma mark - lazy

- (NSDictionary<NSNumber *,NSString *> *)errorDict{
    if (_errorDict == nil) {
        NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithCapacity:10];
        dict[@(XCEditVideoNotFoundError)] = @"video file not found";
        
        _errorDict = [dict copy];
    }
    return _errorDict;
}

@end
