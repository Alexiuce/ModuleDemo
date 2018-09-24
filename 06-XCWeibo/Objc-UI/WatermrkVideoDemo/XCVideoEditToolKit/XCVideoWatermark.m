//
//  XCVideoWatermark.m
//  Objc-UI
//
//  Created by Alexcai on 2018/9/24.
//  Copyright © 2018年 Alexcai. All rights reserved.
//

#import "XCVideoWatermark.h"
#import "XCVideoEditComposition.h"
#import <UIKit/UIKit.h>

@interface XCVideoWatermark()


@property (nonatomic, strong)UIImage *waterImage;
@property (nonatomic, copy) NSString *waterText;

@end

@implementation XCVideoWatermark


+ (instancetype)waterImageMark:(UIImage *)waterImage withComposition:(XCVideoEditComposition *)composition{
    return [[self alloc]initWithWater:waterImage text:nil composition:composition];
}

+ (instancetype)waterTextMark:(NSString *)waterText withComposition:(XCVideoEditComposition *)composition{
    return [[self alloc]initWithWater:nil text:waterText composition:composition];
}

+ (instancetype)watermark:(UIImage *)waterImage text:(NSString *)waterText withComposition:(XCVideoEditComposition *)composition{
    return [[self alloc] initWithWater:waterImage text:waterText composition:composition];
}

- (instancetype)initWithWater:(UIImage *)image text:(NSString *)waterText composition:(XCVideoEditComposition *)comp{
    if (self = [super init]) {
        _waterText = waterText;
        _waterImage = image;
        _videoComposition = [AVMutableVideoComposition videoComposition];
        _videoComposition.frameDuration= CMTimeMake(1, 30);
        _videoComposition.renderSize = comp.renderSize ;
        

        
        AVMutableVideoCompositionInstruction *vcins = [AVMutableVideoCompositionInstruction videoCompositionInstruction];
        vcins.timeRange = comp.timeRange;
        
        
        AVMutableVideoCompositionLayerInstruction *layerIns = [AVMutableVideoCompositionLayerInstruction videoCompositionLayerInstructionWithAssetTrack:comp.videoAssetTrack];
        
        [layerIns setTransform:[self videoAssetTrackTransform:comp.videoDegree naturalSize:comp.videoAssetTrack.naturalSize] atTime:kCMTimeZero];
        //    [layerIns setOpacity:0.0 atTime:originVideoAsset.duration];
        
        vcins.layerInstructions = @[layerIns];
        _videoComposition.instructions = @[vcins];
    }
    return self;
}


- (void)addWatermarkLayerToVideoComposition:(AVMutableVideoComposition *)videoCompostion{
   
    // 创建水印layer ,并设置水印图片
    CALayer *aLayer=[CALayer layer];
    aLayer.contents = (__bridge id )(_waterImage.CGImage);
    aLayer.frame = CGRectMake(0, 0, 90, 60);

    CALayer *parentLayer = [CALayer layer];
    
    parentLayer.frame = CGRectMake(0, 0, videoCompostion.renderSize.width ,videoCompostion.renderSize.height);
    CALayer *videoLayer = [CALayer layer];
    
    videoLayer.frame = parentLayer.frame;
    [parentLayer addSublayer:videoLayer];
    [parentLayer addSublayer:aLayer];
    _videoComposition.animationTool = [AVVideoCompositionCoreAnimationTool videoCompositionCoreAnimationToolWithPostProcessingAsVideoLayer:videoLayer inLayer:parentLayer];
}




/**
 根据视频的角度,调整形变属性
 @return 返回调整后的形变数据;
 */
- (CGAffineTransform)videoAssetTrackTransform:(int)degrees naturalSize:(CGSize)naturalSize {
    CGAffineTransform transform = CGAffineTransformIdentity;
    if (degrees != 0) {
        CGAffineTransform translateToCenter = CGAffineTransformIdentity;
        if (degrees == 90) {
            // 顺时针旋转90°
            translateToCenter = CGAffineTransformMakeTranslation(naturalSize.height, 0.0);
            transform = CGAffineTransformRotate(translateToCenter, M_PI_2);
        } else if(degrees == 180){
            // 顺时针旋转180°
            translateToCenter = CGAffineTransformMakeTranslation(naturalSize.width, naturalSize.height);
            transform = CGAffineTransformRotate(translateToCenter, M_PI);
        } else if(degrees == 270){
            // 顺时针旋转270°
            translateToCenter = CGAffineTransformMakeTranslation(0.0, naturalSize.width);
            transform = CGAffineTransformRotate(translateToCenter, M_PI_2 + M_PI);
        }else if(degrees == -180){
            // 绕x轴旋转180度
            transform = CGAffineTransformScale(transform, 1.0, -1.0); // 上下颠倒视频
            transform = CGAffineTransformTranslate(transform, 0, -naturalSize.height);
        }
    }
    
    return transform;
}


@end
