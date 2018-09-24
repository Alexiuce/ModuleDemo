//
//  XCVideoEditManager.h
//  Objc-UI
//
//  Created by Alexcai on 2018/9/24.
//  Copyright © 2018年 Alexcai. All rights reserved.
//  视频编辑器

#import <Foundation/Foundation.h>

typedef void(^XCEditingProgressBlock)(float progress) ;
typedef void(^XCEditedSuccessBlock) (NSString *editedSavePath);
typedef void(^XCEditedFailureBlock) (NSError *error);

#pragma mark - Class

@interface XCVideoEditManager : NSObject

#pragma mark - property

/**
 水印图片
 */
@property (nonatomic, copy) NSString *waterImageName ;

/**
 水印文字
 */
@property (nonatomic, copy) NSString *waterText;


#pragma mark - method

+ (instancetype)defaultManager;



/**
 开始视频编辑

 @param videoName 本地视频名称(非全路径)
 @param progressBlock 进度回调 (会执行 copy 操作)
 @param successBlock 成功回调
 @param failureBlock 失败回调
 */
- (void)startEditVideo:(NSString *)videoName progress:(XCEditingProgressBlock)progressBlock success:(XCEditedSuccessBlock)successBlock failure:(XCEditedFailureBlock)failureBlock;

@end
