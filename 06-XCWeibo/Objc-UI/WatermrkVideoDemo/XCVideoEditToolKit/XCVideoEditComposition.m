//
//  XCVideoEditComposition.m
//  Objc-UI
//
//  Created by Alexcai on 2018/9/24.
//  Copyright © 2018年 Alexcai. All rights reserved.
//

#import "XCVideoEditComposition.h"

@interface XCVideoEditComposition()

@property (nonatomic, strong)AVMutableComposition *mainComposition;

@end


@implementation XCVideoEditComposition

+ (instancetype)compositionWithAsset:(AVAsset *)videoAsset{
    return [[self alloc]initWithVideoAsset:videoAsset];
}

- (instancetype)initWithVideoAsset:(AVAsset *)asset{
    if (self = [super init]) {
        _mainComposition = [AVMutableComposition composition];
        
        _timeRange = CMTimeRangeMake(kCMTimeZero, asset.duration);
        
        _videoTrack = [_mainComposition addMutableTrackWithMediaType:AVMediaTypeVideo preferredTrackID:kCMPersistentTrackID_Invalid];
        
        _audioTrack = [_mainComposition addMutableTrackWithMediaType:AVMediaTypeAudio preferredTrackID:kCMPersistentTrackID_Invalid];
        
        
        
        
        
    }
    return self;
}


#pragma mark - lazy



@end
