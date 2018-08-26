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


@interface XCVideoViewController ()<SuperPlayerDelegate>

@property (nonatomic, strong) AVPlayer *xc_player;

@property (nonatomic, strong)TXVodPlayer *vodPlayer;
@property (nonatomic, strong) TXLivePlayer *livePlayer;

@property (nonatomic, strong) SuperPlayerView *playerView;
@property (nonatomic, strong) SuperPlayerModel *playerModel;

@property (weak, nonatomic) IBOutlet UIView *containerView;

@end

@implementation XCVideoViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self superPlayerView];
    
}

-(void)playLive{
    _livePlayer = [[TXLivePlayer alloc]init];
     NSString *url = @"http://flashfish.oss-cn-hangzhou.aliyuncs.com/CDN/image/android_1534917672881_1.mp4";
    [_livePlayer setupVideoWidget:self.containerView.bounds containView:self.containerView insertIndex:0];
    [_livePlayer startPlay:url type:PLAY_TYPE_VOD_MP4];
}
- (void)playVod{
    _vodPlayer = [[TXVodPlayer alloc]init];
    
    [_vodPlayer setupVideoWidget:self.containerView insertIndex:0];
    NSString *url = @"http://flashfish.oss-cn-hangzhou.aliyuncs.com/CDN/image/android_1534917672881_1.mp4";
    [_vodPlayer startPlay:url];
}
- (void)superPlayerView{
    _playerView = [[SuperPlayerView alloc] init];
    _playerModel = [[SuperPlayerModel alloc] init];
    _playerModel.videoURL = @"http://flashfish.oss-cn-hangzhou.aliyuncs.com/CDN/image/android_1534917672881_1.mp4";
    // 设置代理
    _playerView.delegate = self;
    
    // 设置父View
    _playerView.fatherView = self.containerView;
    
    // 开始播放
    [_playerView playWithModel:self.playerModel];
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
