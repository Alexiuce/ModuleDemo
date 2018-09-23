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
    
//    NSString *viderUrl =
    //@"http://flashfish.oss-cn-hangzhou.aliyuncs.com/CDN/image/android_1534917672881_1.mp4";
    //@"http://clips.vorwaerts-gmbh.de/big_buck_bunny.mp4";
//    _xc_player = [[AVPlayer alloc]initWithURL:[NSURL fileURLWithPath:videoPath]];
//
//    AVPlayerLayer *playLayer = [AVPlayerLayer playerLayerWithPlayer:_xc_player];
//    playLayer.videoGravity = AVLayerVideoGravityResizeAspect;
//    //AVLayerVideoGravityResizeAspect
//    //AVLayerVideoGravityResizeAspectFill
//    playLayer.frame = self.containerView.bounds;
//    [self.containerView.layer addSublayer:playLayer];
//    [_xc_player play];
    
    
    UIImage *waterImage = [UIImage imageNamed:@"icon_fasong"];
    
    self.imageView.image = waterImage;
    
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




- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
//    [_xc_player ];
}

@end
