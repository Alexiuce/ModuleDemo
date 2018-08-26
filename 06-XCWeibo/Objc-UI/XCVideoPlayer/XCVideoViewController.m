//
//  XCVideoViewController.m
//  Objc-UI
//
//  Created by Alexcai on 2018/8/23.
//  Copyright © 2018年 Alexcai. All rights reserved.
//

#import "XCVideoViewController.h"
#import <AVFoundation/AVFoundation.h>
#import "SuperPlayer.h"


@interface XCVideoViewController ()

@property (nonatomic, strong) AVPlayer *xc_player;


@property (weak, nonatomic) IBOutlet UIView *containerView;

@end

@implementation XCVideoViewController

- (void)viewDidLoad {
    [super viewDidLoad];

  
    
    
}


- (void)superPlayerView{
    
}

- (void)avplayerDemo{
    NSString *viderUrl =  @"http://flashfish.oss-cn-hangzhou.aliyuncs.com/CDN/image/android_1534917672881_1.mp4";
    //@"http://clips.vorwaerts-gmbh.de/big_buck_bunny.mp4";
    _xc_player = [[AVPlayer alloc]initWithURL:[NSURL URLWithString:viderUrl]];
    
    AVPlayerLayer *playLayer = [AVPlayerLayer playerLayerWithPlayer:_xc_player];
    playLayer.videoGravity = AVLayerVideoGravityResizeAspect;
    //AVLayerVideoGravityResizeAspect
    //AVLayerVideoGravityResizeAspectFill
    playLayer.frame = self.view.bounds;
    [self.view.layer addSublayer:playLayer];
    [_xc_player play];
}

@end
