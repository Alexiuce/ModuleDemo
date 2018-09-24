//
//  XCVideoEditComposition.h
//  Objc-UI
//
//  Created by Alexcai on 2018/9/24.
//  Copyright © 2018年 Alexcai. All rights reserved.
//  视频编辑构图: 将原视频数据信息,添加到本类中进行视频编辑

#import <AVFoundation/AVFoundation.h>

@interface XCVideoEditComposition : NSObject



/**
 媒体合成器
 */
@property (nonatomic, strong, readonly) AVMutableComposition *mainComposition;
/**
 视频轨道信息
 */
@property (nonatomic, strong, readonly) AVMutableCompositionTrack *videoTrack;

/**
 视频轨道中的视频轨道资源
 */
@property (nonatomic, strong, readonly) AVAssetTrack *videoAssetTrack;

/**
 音频轨道消息
 */
@property (nonatomic, strong, readonly) AVMutableCompositionTrack *audioTrack;

/**
音频轨道中的音频轨道资源
 */
@property (nonatomic, strong, readonly) AVAssetTrack *audioAssetTrack;

/**
 视频时间
 */
@property (nonatomic, assign, readonly) CMTimeRange timeRange;


/**
 视频size
 */
@property (nonatomic, assign, readonly) CGSize renderSize;

/**
 视频的角度
 */
@property (nonatomic, assign, readonly) int videoDegree;


/**
 根据视频资源创建编辑构图类

 @param videoAsset 视频资源
 @return 创建好的视图编辑构图
 */
+ (instancetype)compositionWithAsset:(AVAsset *)videoAsset;


@end
