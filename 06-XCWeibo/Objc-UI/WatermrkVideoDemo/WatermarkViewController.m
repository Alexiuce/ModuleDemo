//
//  WatermarkViewController.m
//  Objc-UI
//
//  Created by Alexcai on 2018/9/22.
//  Copyright © 2018年 Alexcai. All rights reserved.
//

#import "WatermarkViewController.h"
#import <AVFoundation/AVFoundation.h>

@interface WatermarkViewController ()

@property (weak, nonatomic) IBOutlet UIView *containerView;

@property (weak, nonatomic) IBOutlet UIImageView *imageView;


@property (nonatomic, strong) AVPlayer *xc_player;

@end

@implementation WatermarkViewController

- (void)viewDidLoad {
    [super viewDidLoad];
     NSString *videoPath = [NSBundle.mainBundle pathForResource:@"video.mp4" ofType:nil];
    [self addWaterPicWithVideoPath:videoPath];
   
}


- (void)addWaterPicWithVideoPath:(NSString*)path{
    //1 创建AVAsset实例
    AVURLAsset*videoAsset = [AVURLAsset assetWithURL:[NSURL fileURLWithPath:path]];
    
    AVMutableComposition *mixComposition = [[AVMutableComposition alloc] init];
    
    
    //3 视频通道
    AVMutableCompositionTrack *videoTrack = [mixComposition addMutableTrackWithMediaType:AVMediaTypeVideo
                                                                        preferredTrackID:kCMPersistentTrackID_Invalid];
    [videoTrack insertTimeRange:CMTimeRangeMake(kCMTimeZero, videoAsset.duration)
                        ofTrack:[[videoAsset tracksWithMediaType:AVMediaTypeVideo] firstObject]
                         atTime:kCMTimeZero error:nil];
    
    
    //2 音频通道
    AVMutableCompositionTrack *audioTrack = [mixComposition addMutableTrackWithMediaType:AVMediaTypeAudio
                                                                        preferredTrackID:kCMPersistentTrackID_Invalid];
    [audioTrack insertTimeRange:CMTimeRangeMake(kCMTimeZero, videoAsset.duration)
                        ofTrack:[[videoAsset tracksWithMediaType:AVMediaTypeAudio] firstObject]
                         atTime:kCMTimeZero error:nil];
    
    //3.1 AVMutableVideoCompositionInstruction 视频轨道中的一个视频，可以缩放、旋转等
    AVMutableVideoCompositionInstruction *mainInstruction = [AVMutableVideoCompositionInstruction videoCompositionInstruction];
    mainInstruction.timeRange = CMTimeRangeMake(kCMTimeZero, videoAsset.duration);
    
    // 3.2 AVMutableVideoCompositionLayerInstruction 一个视频轨道，包含了这个轨道上的所有视频素材
    AVMutableVideoCompositionLayerInstruction *videolayerInstruction = [AVMutableVideoCompositionLayerInstruction videoCompositionLayerInstructionWithAssetTrack:videoTrack];
    
    [videolayerInstruction setOpacity:0.0 atTime:videoAsset.duration];
    
    // 3.3 - Add instructions
    mainInstruction.layerInstructions = [NSArray arrayWithObjects:videolayerInstruction,nil];
    
    //AVMutableVideoComposition：管理所有视频轨道，水印添加就在这上面
    AVMutableVideoComposition *mainCompositionInst = [AVMutableVideoComposition videoComposition];
    
    AVAssetTrack *videoAssetTrack = [[videoAsset tracksWithMediaType:AVMediaTypeVideo] firstObject];
    CGSize naturalSize = videoAssetTrack.naturalSize;
    
    float renderWidth, renderHeight;
    renderWidth = naturalSize.width;
    renderHeight = naturalSize.height;
    mainCompositionInst.renderSize = CGSizeMake(renderWidth, renderHeight);
    mainCompositionInst.instructions = [NSArray arrayWithObject:mainInstruction];
    mainCompositionInst.frameDuration = CMTimeMake(1, 30);
    [self applyVideoEffectsToComposition:mainCompositionInst size:naturalSize];
    
    //    // 4 - 输出路径
//    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
//    NSString *documentsDirectory = [paths objectAtIndex:0];
//    NSString *myPathDocs =  [documentsDirectory stringByAppendingPathComponent:
//                             [NSString stringWithFormat:@"FinalVideo-%d.mp4",arc4random() % 1000]];
//    NSURL* videoUrl = [NSURL fileURLWithPath:myPathDocs];
    
    
    NSString *savePath = @"/Users/Alexcai/Desktop/video/d.mov";
    
    NSFileManager *fm = [[NSFileManager alloc] init];
    if ([fm fileExistsAtPath:savePath]) {
        NSLog(@"video is have. then delete that");
        if ([fm removeItemAtPath:savePath error:nil]) {
            NSLog(@"delete is ok");
        }else {
            NSLog(@"delete is no error = ");
        }
        // 5 - 视频文件输出
        AVAssetExportSession *exporter = [[AVAssetExportSession alloc] initWithAsset:mixComposition
                                                                          presetName:AVAssetExportPresetHighestQuality];
        exporter.outputURL = [NSURL fileURLWithPath:savePath];
        exporter.outputFileType = AVFileTypeMPEG4;
        exporter.shouldOptimizeForNetworkUse = YES;
        exporter.videoComposition = mainCompositionInst;
        [exporter exportAsynchronouslyWithCompletionHandler:^{
            if (exporter.status == AVAssetExportSessionStatusCompleted) {
                NSLog(@"wancheng.....");
            }
            // 保存到相册
//            dispatch_async(dispatch_get_main_queue(), ^{
//
//                if( exporter.status == AVAssetExportSessionStatusCompleted ){
//
//                    UISaveVideoAtPathToSavedPhotosAlbum(myPathDocs, nil, nil, nil);
//
//                }else if( exporter.status == AVAssetExportSessionStatusFailed )
//                {
//                    NSLog(@"failed");
//                }
//
//            });
        }];
    }
    
}


- (void)applyVideoEffectsToComposition:(AVMutableVideoComposition *)composition size:(CGSize)size{
    // 文字
    //    CATextLayer *subtitle1Text = [[CATextLayer alloc] init];
    //    //    [subtitle1Text setFont:@"Helvetica-Bold"];
    //    [subtitle1Text setFontSize:36];
    //    [subtitle1Text setFrame:CGRectMake(10, size.height-10-100, size.width, 100)];
    //    [subtitle1Text setString:@"ZHIMABAOBAO"];
    //    //    [subtitle1Text setAlignmentMode:kCAAlignmentCenter];
    //    [subtitle1Text setForegroundColor:[[UIColor whiteColor] CGColor]];
    
    //图片
    CALayer*picLayer = [CALayer layer];
    picLayer.contents = (id)[UIImage imageNamed:@"icon_fasong"].CGImage;
    picLayer.frame = CGRectMake(size.width-15-87, 15, 87, 26);
    
    // 2 - The usual overlay
    CALayer *overlayLayer = [CALayer layer];
    [overlayLayer addSublayer:picLayer];
    overlayLayer.frame = CGRectMake(0, 0, size.width, size.height);
    [overlayLayer setMasksToBounds:YES];
    
    CALayer *parentLayer = [CALayer layer];
    CALayer *videoLayer = [CALayer layer];
    parentLayer.frame = CGRectMake(0, 0, size.width, size.height);
    videoLayer.frame = CGRectMake(0, 0, size.width, size.height);
    [parentLayer addSublayer:videoLayer];
    [parentLayer addSublayer:overlayLayer];
    
    composition.animationTool = [AVVideoCompositionCoreAnimationTool
                                 videoCompositionCoreAnimationToolWithPostProcessingAsVideoLayer:videoLayer inLayer:parentLayer];
}


- (void)testCode{
    NSString *videoPath = [NSBundle.mainBundle pathForResource:@"video.mp4" ofType:nil];
    
    UIImage *waterImage = [UIImage imageNamed:@"icon_fasong"];
    
    
    AVAsset *originVideoAsset = [AVAsset assetWithURL:[NSURL fileURLWithPath:videoPath]];
    
    
    // 1. 创建可编辑的复合视频类;
    AVMutableComposition *compos = [AVMutableComposition composition];
    // 2. 准备视频轨道
    AVMutableCompositionTrack *videoTrack = [compos addMutableTrackWithMediaType:AVMediaTypeVideo preferredTrackID:kCMPersistentTrackID_Invalid];
    
    // 4. 获取视频资源中的视频轨道
    AVAssetTrack *videoAssetTrack =  [originVideoAsset tracksWithMediaType:AVMediaTypeVideo].firstObject;
    
    // 6. 添加资源视频轨道到可编复合类的视频轨道中;
    
    [videoTrack insertTimeRange:CMTimeRangeMake(kCMTimeZero, originVideoAsset.duration) ofTrack:videoAssetTrack atTime:kCMTimeZero error:nil];
    
    // 创建水印layer ,并设置水印图片
    CALayer *aLayer=[CALayer layer];
    aLayer.contents = (__bridge id _Nullable)(waterImage.CGImage);
    aLayer.frame = CGRectMake(0, 0, 90, 60);
    
    
    CALayer *parentLayer = [CALayer layer];
    parentLayer.frame = CGRectMake(0, 0, 100 ,100);
    CALayer *videoLayer = [CALayer layer];
    videoLayer.backgroundColor = UIColor.clearColor.CGColor;
    videoLayer.frame = parentLayer.frame;
    [parentLayer addSublayer:videoLayer];
    [parentLayer addSublayer:aLayer];
    parentLayer.backgroundColor = UIColor.yellowColor.CGColor;
    
    // 视频复合对象
    AVMutableVideoComposition *vcmp = [AVMutableVideoComposition videoComposition];
    vcmp.frameDuration= CMTimeMake(1, 24);
    vcmp.renderSize = CGSizeMake(videoAssetTrack.naturalSize.width, videoAssetTrack.naturalSize.height);
    
    vcmp.animationTool = [AVVideoCompositionCoreAnimationTool videoCompositionCoreAnimationToolWithPostProcessingAsVideoLayer:videoLayer inLayer:parentLayer];
    AVMutableVideoCompositionInstruction *vcins = [AVMutableVideoCompositionInstruction videoCompositionInstruction];
    vcins.timeRange = CMTimeRangeMake(kCMTimeZero, compos.duration);
    
    
    AVMutableVideoCompositionLayerInstruction *layerIns = [AVMutableVideoCompositionLayerInstruction videoCompositionLayerInstructionWithAssetTrack:videoAssetTrack];
    [layerIns setTransform:videoAssetTrack.preferredTransform atTime:kCMTimeZero];
    
    vcins.layerInstructions = @[layerIns];
    vcmp.instructions = @[vcins];
    
    
    NSString *savePath = @"/Users/Alexcai/Desktop/video/d.mov";
    
    NSFileManager *fm = [[NSFileManager alloc] init];
    if ([fm fileExistsAtPath:savePath]) {
        NSLog(@"video is have. then delete that");
        if ([fm removeItemAtPath:savePath error:nil]) {
            NSLog(@"delete is ok");
        }else {
            NSLog(@"delete is no error = ");
        }
        
    }
    
    
    AVAssetExportSession *exportSession = [[AVAssetExportSession alloc]initWithAsset:originVideoAsset presetName:AVAssetExportPresetHighestQuality];
    exportSession.outputURL = [NSURL fileURLWithPath:savePath];
    exportSession.outputFileType = AVFileTypeMPEG4;
    exportSession.shouldOptimizeForNetworkUse = YES;
    exportSession.videoComposition = vcmp;
    [exportSession exportAsynchronouslyWithCompletionHandler:^{
        if (exportSession.status == AVAssetExportSessionStatusCompleted) {
            NSLog(@"wancheng.....");
        }
    }];

}

@end
