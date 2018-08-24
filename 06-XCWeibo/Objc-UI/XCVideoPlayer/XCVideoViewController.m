//
//  XCVideoViewController.m
//  Objc-UI
//
//  Created by Alexcai on 2018/8/23.
//  Copyright © 2018年 Alexcai. All rights reserved.
//

#import "XCVideoViewController.h"
#import <AVFoundation/AVFoundation.h>


@interface XCVideoViewController ()

@property (nonatomic, strong) AVPlayer *xc_player;


@property (weak, nonatomic) IBOutlet UIView *containerView;

@end

@implementation XCVideoViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    NSString *viderUrl =  @"http://clips.vorwaerts-gmbh.de/big_buck_bunny.mp4";
    _xc_player = [[AVPlayer alloc]initWithURL:[NSURL URLWithString:viderUrl]];
    
    AVPlayerLayer *playLayer = [AVPlayerLayer playerLayerWithPlayer:_xc_player];
    playLayer.frame = self.containerView.bounds;
    [self.containerView.layer addSublayer:playLayer];
    [_xc_player play];
    
    
}


@end
