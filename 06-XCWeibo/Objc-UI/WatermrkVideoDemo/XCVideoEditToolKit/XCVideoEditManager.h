//
//  XCVideoEditManager.h
//  Objc-UI
//
//  Created by Alexcai on 2018/9/24.
//  Copyright © 2018年 Alexcai. All rights reserved.
//

#import <Foundation/Foundation.h>

@class XCVideoEditManager;

#pragma mark - Data Source
@protocol XCVideoEditManagerDataSource <NSObject>

@required

/**
 提供需要进行编辑视频的文件路径

 @param editManager 视频编辑管理器
 @return 需要被编辑的视频在本地的路径信息
 */
- (nonnull NSString  *)xcvidePathNameForEditManager:(XCVideoEditManager *)editManager;

@end


typedef void(^XCEditingProgressBlock)(float progress) ;
typedef void(^XCEditedSuccessBlock) (NSString *editedSavePath);
typedef void(^XCEditedFailureBlock) (NSError *error);

#pragma mark - Class

@interface XCVideoEditManager : NSObject

#pragma mark - property

@property (nonatomic, weak) id <XCVideoEditManagerDataSource> videoDataSource;



#pragma mark - method

+ (instancetype)defaultManager;

- (void)startEditVideo:(NSString *)videoName progress:(XCEditingProgressBlock)progressBlock success:(XCEditedSuccessBlock)successBlock failure:(XCEditedFailureBlock)failureBlock;

@end
