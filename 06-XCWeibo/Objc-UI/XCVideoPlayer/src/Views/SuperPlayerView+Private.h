//
//  SuperPlayerView+Private.h
//  TXLiteAVDemo
//
//  Created by annidyfeng on 2018/7/9.
//  Copyright © 2018年 Tencent. All rights reserved.
//

#ifndef SuperPlayerView_Private_h
#define SuperPlayerView_Private_h
#import "SuperPlayer.h"
#import "CFDanmakuView.h"
#import "SuperPlayerControlViewDelegate.h"
#import "NetWatcher.h"
#import <MediaPlayer/MediaPlayer.h>

// 枚举值，包含水平移动方向和垂直移动方向
typedef NS_ENUM(NSInteger, PanDirection){
    PanDirectionHorizontalMoved, // 横向移动
    PanDirectionVerticalMoved    // 纵向移动
};



@interface SuperPlayerView () <UIGestureRecognizerDelegate,UIAlertViewDelegate,
TXVodPlayListener, TXLivePlayListener, CFDanmakuDelegate, SuperPlayerControlViewDelegate>


/** 用来保存快进的总时长 */
@property (nonatomic, assign) CGFloat                sumTime;
@property (nonatomic, assign) CGFloat                startVeloctyPoint;

/** 定义一个实例变量，保存枚举值 */
@property (nonatomic, assign) PanDirection           panDirection;
/** 是否为全屏 */
//@property (nonatomic, assign) BOOL                   isFullScreen;
/** 是否锁定屏幕方向 */
//@property (nonatomic, assign) BOOL                   isLockScreen;

/** 是否在调节音量*/
@property (nonatomic, assign) BOOL                   isVolume;
/** 是否被用户暂停 */
@property (nonatomic, assign) BOOL                   isPauseByUser;
/** slider上次的值 */
@property (nonatomic, assign) CGFloat                sliderLastValue;
/** 是否再次设置URL播放视频 */
@property (nonatomic, assign) BOOL                   repeatToPlay;
/** 播放完了*/
@property (nonatomic, assign) BOOL                   playDidEnd;
/** 进入后台*/
@property (nonatomic, assign) BOOL                   didEnterBackground;
/** 单击 */
@property (nonatomic, strong) UITapGestureRecognizer *singleTap;
/** 双击 */
@property (nonatomic, strong) UITapGestureRecognizer *doubleTap;

@property (nonatomic, strong) UIButton               *lockTipsBtn;


@property (nonatomic, strong) SuperPlayerControlView *controlView;
@property (nonatomic, strong) SuperPlayerModel       *playerModel;


@property (class, readonly) UISlider *volumeViewSlider;
@property MPVolumeView *volumeView;
// 播放的数据
@property (nonatomic, assign) float                  seekTime;
@property (nonatomic, strong) NSString               *videoURL;
@property int                                        videoIndex;   // 多码率播放

// add for txvodplayer
@property BOOL  isLoaded;
@property (nonatomic, strong) CFDanmakuView *danmakuView;
@property (nonatomic, strong) NSDate *danmakuStartTime;

@property NSURLSessionDataTask *getInfoHttpTask;


@property (nonatomic) BOOL  isShiftPlayback;
@property NSInteger shiftStartTime;
@property NSInteger maxLiveProgressTime;    // 直播最大进度/总时间
@property NSInteger liveProgressTime;       // 直播播放器回调过来的时间
@property NSInteger hiddenProgressTime;     // 未显示时间，当liveProgressTime大于MAX_SHIFT_TIME，不显示超过之前的部分
#define MAX_SHIFT_TIME  2*60*60
/** 是否是直播流 */
@property BOOL isLive;

/** 腾讯点播播放器 */
@property (nonatomic, strong) TXVodPlayer                *vodPlayer;
/** 腾讯直播播放器 */
@property (nonatomic, strong) TXLivePlayer               *livePlayer;

@property NSDate *reportTime;

@property NetWatcher *netWatcher;

@end



#endif /* SuperPlayerView_Private_h */
