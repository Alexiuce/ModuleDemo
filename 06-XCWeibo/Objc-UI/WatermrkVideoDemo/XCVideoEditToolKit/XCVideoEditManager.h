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




#pragma mark - method

+ (instancetype)defaultManager;

- (void)startEditVideo:(NSString *)videoName progress:(XCEditingProgressBlock)progressBlock success:(XCEditedSuccessBlock)successBlock failure:(XCEditedFailureBlock)failureBlock;

@end
