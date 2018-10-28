//
//  XCMusicManager.h
//  ObjcUI
//
//  Created by Alexcai on 2018/10/27.
//  Copyright © 2018 dongjiu. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface XCMusicManager : NSObject

/**
 类方法: 快速创建一个单利实力

 @return 创建好的单利对象
 */
+ (instancetype)shareManager;


/**
 开始播放背景音乐
 */
- (void)playBackgroundMusic:(NSString *)musicName;

/**
 停止播放背景音乐
 */
- (void)stopBackgroundMusic;



@end

NS_ASSUME_NONNULL_END
