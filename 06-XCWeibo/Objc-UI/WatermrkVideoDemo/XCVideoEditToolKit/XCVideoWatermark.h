//
//  XCVideoWatermark.h
//  Objc-UI
//
//  Created by Alexcai on 2018/9/24.
//  Copyright © 2018年 Alexcai. All rights reserved.
//  视频水印类

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>

@class XCVideoEditComposition;

@interface XCVideoWatermark : NSObject

@property (nonatomic, strong, readonly)AVMutableVideoComposition *videoComposition;

/** 图片水印 */
+ (instancetype)waterImageMark:(UIImage *)waterImage withComposition:(XCVideoEditComposition *)composition;
/** 文字水印 */
+ (instancetype)waterTextMark:(NSString *)waterText withComposition:(XCVideoEditComposition *)composition;

/** 图文水印 */
+ (instancetype)watermark:(UIImage *)waterImage text:(NSString *)waterText withComposition:(XCVideoEditComposition *)composition;

@end
