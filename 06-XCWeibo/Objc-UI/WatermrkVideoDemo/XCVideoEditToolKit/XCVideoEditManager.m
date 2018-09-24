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

@interface XCVideoEditManager()

@end


@implementation XCVideoEditManager





/**
 根据视频的角度,调整形变属性

 @param videoAssetTrack 视频轨道数据
 @return 返回调整后的形变数据;
 */
- (CGAffineTransform)videoAssetTrackTransform:(AVAssetTrack *)videoAssetTrack {
    int degrees = [self degressFromVideoFileWithVideoAssetTrack:videoAssetTrack];
    CGAffineTransform transform = CGAffineTransformIdentity;
    if (degrees != 0) {
        CGAffineTransform translateToCenter = CGAffineTransformIdentity;
        if (degrees == 90) {
            // 顺时针旋转90°
            translateToCenter = CGAffineTransformMakeTranslation(videoAssetTrack.naturalSize.height, 0.0);
            transform = CGAffineTransformRotate(translateToCenter, M_PI_2);
        } else if(degrees == 180){
            // 顺时针旋转180°
            translateToCenter = CGAffineTransformMakeTranslation(videoAssetTrack.naturalSize.width, videoAssetTrack.naturalSize.height);
            transform = CGAffineTransformRotate(translateToCenter, M_PI);
        } else if(degrees == 270){
            // 顺时针旋转270°
            translateToCenter = CGAffineTransformMakeTranslation(0.0, videoAssetTrack.naturalSize.width);
            transform = CGAffineTransformRotate(translateToCenter, M_PI_2 + M_PI);
        }else if(degrees == -180){
            // 绕x轴旋转180度
            transform = CGAffineTransformScale(transform, 1.0, -1.0); // 上下颠倒视频
            transform = CGAffineTransformTranslate(transform, 0, -videoAssetTrack.naturalSize.height);
        }
    }
    
    return transform;
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
