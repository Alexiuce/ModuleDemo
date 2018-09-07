//
//  XCFileManager.m
//  Objc-main
//
//  Created by Alexcai on 2018/9/7.
//  Copyright © 2018年 Alexcai. All rights reserved.
//

#import "XCFileManager.h"


@interface XCFileManager()

@property (nonatomic, strong)NSFileManager *fileManager;

@end


@implementation XCFileManager

+ (instancetype)shareManager{
    static dispatch_once_t onceToken;
    static XCFileManager * __shareInstance = nil;
    dispatch_once(&onceToken, ^{
        __shareInstance = [[self alloc] init];
    });
    return __shareInstance;
}

/**
 列出指定目录的下的所有文件
 
 @param targetPath 指定的目标路径
 */
- (NSArray *)listAllFilesInPath:(NSString *)targetPath{
   
    NSArray <NSString *>*result = [self.fileManager contentsOfDirectoryAtPath:targetPath error:nil];

    for (NSString *fileName in result) {
        BOOL flag = YES;
        NSString *fullPath = [targetPath stringByAppendingPathComponent:fileName];
        [self.fileManager fileExistsAtPath:fullPath isDirectory:&flag];
        if (flag) {
            [self listAllFilesInPath:fullPath];
        }
        NSLog(@"---------------------------------------");
        
    }
    
    [result enumerateObjectsUsingBlock:^(NSString *fileName, NSUInteger idx, BOOL * _Nonnull stop) {
        NSLog(@"%lu : %@", (unsigned long)idx,fileName);
    }];
    return result;
}





#pragma mark - lazy getter method

- (NSFileManager *)fileManager{
    if (_fileManager == nil) {
        _fileManager = NSFileManager.defaultManager;
    }
    return _fileManager;
}


@end
