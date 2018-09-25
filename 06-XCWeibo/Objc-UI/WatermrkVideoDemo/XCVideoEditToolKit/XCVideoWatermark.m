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

/**
 图片layer: 显示水印图片
 */
@property (nonatomic, strong) CALayer *pictureLayer;

/**
 文字layer: 显示文字水印
 */
@property (nonatomic, strong) CATextLayer *textLayer;

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
        if (_waterImage == nil && _waterText == nil) {return self;}
        
        _videoComposition = [AVMutableVideoComposition videoComposition];
        _videoComposition.frameDuration= CMTimeMake(1, 30);
        _videoComposition.renderSize = comp.renderSize ;
        [self addWatermarkLayerToVideoComposition];

        
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


- (void)addWatermarkLayerToVideoComposition{
   
    CGFloat videoWidth = _videoComposition.renderSize.width;
    CGFloat videoHeight = _videoComposition.renderSize.height;
    
    CALayer *parentLayer = [CALayer layer];
    parentLayer.frame = CGRectMake(0, 0, videoWidth ,videoHeight);
    
    CALayer *videoLayer = [CALayer layer];
    videoLayer.frame = parentLayer.frame;
    
    [parentLayer addSublayer:videoLayer];
    
    // 文字
    if (self.waterText != nil) {
        [parentLayer addSublayer:self.textLayer];
    }
    // 图片
    if (self.waterImage != nil) {
        [parentLayer addSublayer:self.pictureLayer];
    }
  
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


#pragma mark - lazy getter method

- (CALayer *)pictureLayer{
    if (_pictureLayer == nil) {
        _pictureLayer = [CALayer layer];
        _pictureLayer.contents = (__bridge id )(_waterImage.CGImage);
        _pictureLayer.frame = CGRectMake(100, 0, 90, 60);
    }
    return _pictureLayer;
}

- (CATextLayer *)textLayer{
    if (_textLayer == nil) {
        
        //create a text layer
        _textLayer = [CATextLayer layer];
        [_textLayer setFrame:CGRectMake(0, 0, 40, 60)];

        //set text attributes
        _textLayer.foregroundColor = [UIColor blackColor].CGColor;
        _textLayer.backgroundColor = UIColor.yellowColor.CGColor;

        
        //choose a font
        UIFont *font = [UIFont systemFontOfSize:15];
        
        //set layer font
        CFStringRef fontName = (__bridge CFStringRef)font.fontName;
        CGFontRef fontRef = CGFontCreateWithFontName(fontName);
        _textLayer.contentsScale = UIScreen.mainScreen.scale;
        _textLayer.fontSize = font.pointSize;
        _textLayer.font =  fontRef;
        CGFontRelease(fontRef);

        //choose some text
        NSString *text = @"Lorem ipsum dolor sit amet";
        
        //set layer text
        _textLayer.string = text;
        _textLayer.position = CGPointZero;
        _textLayer.anchorPoint = CGPointZero;

    }
    return _textLayer;
}

@end
