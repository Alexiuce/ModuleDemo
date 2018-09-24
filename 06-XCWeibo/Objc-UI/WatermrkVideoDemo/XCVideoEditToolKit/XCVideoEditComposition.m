//
//  XCVideoEditComposition.m
//  Objc-UI
//
//  Created by Alexcai on 2018/9/24.
//  Copyright © 2018年 Alexcai. All rights reserved.
//

#import "XCVideoEditComposition.h"

@interface XCVideoEditComposition()



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
        
        _videoAssetTrack = [asset tracksWithMediaType:AVMediaTypeVideo].firstObject;
        _audioAssetTrack = [asset tracksWithMediaType:AVMediaTypeAudio].firstObject;
        if (_videoAssetTrack) {
            [_videoTrack insertTimeRange:_timeRange ofTrack:_videoAssetTrack atTime:kCMTimeZero error:nil];
        }
        if (_audioAssetTrack) {
            [_audioTrack insertTimeRange:_timeRange ofTrack:_audioAssetTrack atTime:kCMTimeZero error:nil];            
        }
        
        _videoDegree = [self degressFromVideoFileWithVideoAssetTrack:_videoAssetTrack];
        BOOL videoIsLandscape = _videoDegree == 90 || _videoDegree == 270 ;
        _renderSize = videoIsLandscape ? CGSizeMake(_videoAssetTrack.naturalSize.height, _videoAssetTrack.naturalSize.width) : _videoAssetTrack.naturalSize;
    }
    return self;
}


/**
 获取视频轨道中的视频角度信息
 
 @param videoAssetTrack 视频轨道
 @return 视频的角度值
 */
- (int)degressFromVideoFileWithVideoAssetTrack:(AVAssetTrack *)videoAssetTrack {
    int degress = 0;
    CGAffineTransform t = videoAssetTrack.preferredTransform;
    if(t.a == 0 && t.b == 1.0 && t.c == -1.0 && t.d == 0){
        // Portrait
        degress = 90;
    } else if(t.a == 0 && t.b == -1.0 && t.c == 1.0 && t.d == 0){
        // PortraitUpsideDown
        degress = 270;
    } else if(t.a == 1.0 && t.b == 0 && t.c == 0 && t.d == 1.0){
        // LandscapeRight
        degress = 0;
    } else if(t.a == -1.0 && t.b == 0 && t.c == 0 && t.d == -1.0){
        // LandscapeLeft
        degress = 180;
    } else if(t.a == -1.0 && t.b == 0 && t.c == 0 && t.d == -1.0){
        // LandscapeLeft
        degress = 180;
    } else if(t.a == 1.0 && t.b == 0 && t.c == 0 && t.d == -1.0){
        // x-axis
        degress = -180;
    }
    
    return degress;
}

@end
