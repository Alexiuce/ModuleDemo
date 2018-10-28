//
//  XCMusicManager.m
//  ObjcUI
//
//  Created by Alexcai on 2018/10/27.
//  Copyright © 2018 dongjiu. All rights reserved.
//

#import "XCMusicManager.h"

#import <AVFoundation/AVFoundation.h>

@interface XCMusicManager ()<AVAudioPlayerDelegate>

@property (nonatomic, copy) NSString *m_name;
@property (nonatomic, strong)AVAudioPlayer *m_player;

@end



@implementation XCMusicManager

+ (instancetype)shareManager{
    static dispatch_once_t onceToken;
    static XCMusicManager *__instance;
    dispatch_once(&onceToken, ^{
        __instance =  [[self alloc]init];
    });
    return __instance;
}





- (void)playBackgroundMusic:(NSString *)musicName{
    NSString *path =  [NSBundle.mainBundle pathForResource:musicName ofType:@"mp3"];
    NSData *m_data = [NSData dataWithContentsOfFile:path];
    NSAssert(m_data != nil, @"musicName must be not Nil");
    AVAudioPlayer *player = [[AVAudioPlayer alloc]initWithData:m_data error:nil];
    [player prepareToPlay];
    player.numberOfLoops = -1;
    player.delegate = self;
    _m_player = player;
    
    
}


- (void)stopBackgroundMusic{
    
}


#pragma mark - AVAudioPlayerDelegate


@end
