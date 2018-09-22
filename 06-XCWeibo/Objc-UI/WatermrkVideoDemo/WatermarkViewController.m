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

@property (nonatomic, strong) AVPlayer *xc_player;

@end

@implementation WatermarkViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSString *videoPath = [NSBundle.mainBundle pathForResource:@"video.mp4" ofType:nil];
    
//    NSString *viderUrl =
    //@"http://flashfish.oss-cn-hangzhou.aliyuncs.com/CDN/image/android_1534917672881_1.mp4";
    //@"http://clips.vorwaerts-gmbh.de/big_buck_bunny.mp4";
    _xc_player = [[AVPlayer alloc]initWithURL:[NSURL fileURLWithPath:videoPath]];
    
    AVPlayerLayer *playLayer = [AVPlayerLayer playerLayerWithPlayer:_xc_player];
    playLayer.videoGravity = AVLayerVideoGravityResizeAspect;
    //AVLayerVideoGravityResizeAspect
    //AVLayerVideoGravityResizeAspectFill
    playLayer.frame = self.containerView.bounds;
    [self.containerView.layer addSublayer:playLayer];
    [_xc_player play];
    
    
    UIImage *waterImage = [UIImage imageNamed:@"icon_fasong"];
    
    AVAsset *originVideoAsset = [AVAsset assetWithURL:[NSURL fileURLWithPath:videoPath]];
    
    CIFilter *watermarkFilter = [CIFilter filterWithName:@"CISourceOverCompositing"];
    
   AVMutableVideoComposition *composition = [AVMutableVideoComposition videoCompositionWithAsset:originVideoAsset applyingCIFiltersWithHandler:^(AVAsynchronousCIImageFilteringRequest * _Nonnull request) {
        
        CIImage *watermarkImage  =  [[CIImage alloc] initWithCGImage:waterImage.CGImage];
        CIImage *source = request.sourceImage;
        [watermarkFilter setValue:source forKey:kCIInputBackgroundImageKey];
        [watermarkFilter setValue:[watermarkImage imageByApplyingTransform:CGAffineTransformMakeScale(source.extent.size.width/watermarkImage.extent.size.width, source.extent.size.height/watermarkImage.extent.size.height)] forKey:kCIInputImageKey];
        [request finishWithImage:watermarkFilter.outputImage context:nil];
        
    }];
    
    
    AVAssetExportSession *exportSession = [[AVAssetExportSession alloc]initWithAsset:composition presetName:AVAssetExportPresetHighestQuality];
    exportSession.outputURL = [NSURL fileURLWithPath:@"/Users/Alexcai/Desktop/video/d.mov"];
    exportSession.outputFileType = AVFileTypeMPEG4;
    exportSession.videoComposition = composition;
    
    
    
    
    

}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
//    [_xc_player ];
}

@end
