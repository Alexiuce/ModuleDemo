//
//  XCVideoEditManager.m
//  Objc-UI
//
//  Created by Alexcai on 2018/9/24.
//  Copyright © 2018年 Alexcai. All rights reserved.
//

#import "XCVideoEditManager.h"
#import <AVFoundation/AVFoundation.h>
#import <UIKit/UIKit.h>
#import "XCVideoEditComposition.h"
#import "XCVideoWatermark.h"


typedef NS_ENUM(NSInteger,XCEditVideoErroeCode) {
    XCEditVideoNotFoundError = 100
};


@interface XCVideoEditManager()

@property (nonatomic, strong)NSDictionary <NSNumber *,NSString*>*errorDict;

@property (nonatomic, copy) XCEditingProgressBlock progressBlock;

@property (nonatomic, strong)AVAssetExportSession *export;

@property (nonatomic, strong)NSTimer *timer;

@end


@implementation XCVideoEditManager

+ (instancetype)defaultManager{
    return [[self alloc]init];
}

- (void)startEditVideo:(NSString *)videoName progress:(XCEditingProgressBlock)progressBlock success:(XCEditedSuccessBlock)successBlock failure:(XCEditedFailureBlock)failureBlock{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        // 1. 加载本地视频资源
        AVAsset *videoAsset = [self loadLocalAsset:videoName];
        // 2. 判断视频加载是否正常
        if (videoAsset == nil) {
            dispatch_async(dispatch_get_main_queue(), ^{
                failureBlock? failureBlock([self errorWithCode:XCEditVideoNotFoundError]) : nil;
            });
            return;
        }
        // 3. 设置视频编辑器
        XCVideoEditComposition *composition = [XCVideoEditComposition compositionWithAsset:videoAsset];
        
        UIImage *waterImage = [UIImage imageNamed:self.waterImageName];
        // 4. 设置视频水印
        XCVideoWatermark *waterMark = [XCVideoWatermark waterImageMark:waterImage withComposition:composition];
        self.progressBlock = progressBlock;
        // 5. 导出编辑后的视频
        [self exportWaterVideo:videoName watermark:waterMark avasset:composition.mainComposition success:successBlock];
    });
}
// 导出方法
- (void)exportWaterVideo:(NSString *)name watermark:(XCVideoWatermark *)watermark avasset:(AVAsset *)video success:(XCEditedSuccessBlock)block{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *savePath=  [documentsDirectory stringByAppendingPathComponent:
                          [NSString stringWithFormat:@"XCEditVideo-%@",name]];
    
    AVAssetExportSession *exportSession = [[AVAssetExportSession alloc]initWithAsset:video presetName:AVAssetExportPresetHighestQuality];
    exportSession.outputURL = [NSURL fileURLWithPath:savePath];
    exportSession.outputFileType = AVFileTypeMPEG4;
    exportSession.shouldOptimizeForNetworkUse = YES;
    exportSession.videoComposition = watermark.videoComposition;
    _export = exportSession;
    [self removeIfFileExist:savePath];
    [self timer];
    [exportSession exportAsynchronouslyWithCompletionHandler:^{
        if (exportSession.status == AVAssetExportSessionStatusCompleted) {
            dispatch_async(dispatch_get_main_queue(), ^{
                block? block(savePath) : nil;
            });
            // 释放定时器
            [self.timer invalidate];
            self.timer = nil;
            // 导出完成,释放progress block 防止循环引用;
            self.progressBlock = nil;
        }else {
            // 导出发生错误,清理文件;
            [self removeIfFileExist:savePath];
        }
    }];
    
    
}

- (void)checkProgress{
    dispatch_async(dispatch_get_main_queue(), ^{
        if (self.progressBlock) {
            self.progressBlock(self.export.progress);
        }        
    });
}

- (void)removeIfFileExist:(NSString *)path{
    NSFileManager *fm = NSFileManager.defaultManager;
    if ([fm fileExistsAtPath:path]) {
        if ([fm removeItemAtPath:path error:nil]) {
            NSLog(@"delete is ok");
        }else {
            NSLog(@"delete is error");
        }
    }
}

- (AVAsset *)loadLocalAsset:(NSString *)path{
    NSString *localPath = [NSBundle.mainBundle pathForResource:path ofType:nil];
    AVAsset *asset = [AVAsset assetWithURL:[NSURL fileURLWithPath:localPath]];
    return asset;
}

- (NSError *)errorWithCode:(NSInteger)errorCode{
    
    return  [NSError errorWithDomain:@"XCVideoErrorDomain" code:errorCode userInfo:@{NSLocalizedDescriptionKey:self.errorDict[@(errorCode)]}];
}

#pragma mark - lazy

- (NSDictionary<NSNumber *,NSString *> *)errorDict{
    if (_errorDict == nil) {
        NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithCapacity:10];
        dict[@(XCEditVideoNotFoundError)] = @"video file not found";
        
        _errorDict = [dict copy];
    }
    return _errorDict;
}

- (NSTimer *)timer{
    if (_timer == nil) {
        _timer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(checkProgress) userInfo:nil repeats:YES];
    }
    return _timer;
}


@end
