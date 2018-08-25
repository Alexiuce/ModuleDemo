//
//  SuperPlayerMoreView.h
//  TXLiteAVDemo
//
//  Created by annidyfeng on 2018/7/4.
//  Copyright © 2018年 Tencent. All rights reserved.
//

#import <UIKit/UIKit.h>

#define MoreViewWidth 330

@class SuperPlayerControlView;

@interface MoreContentView : UIView

@property (weak) SuperPlayerControlView *controlView;

@property UISlider *soundSlider;

@property UISlider *lightSlider;

- (void)updateContents:(BOOL)isLive;

- (void)updateData;

@end
