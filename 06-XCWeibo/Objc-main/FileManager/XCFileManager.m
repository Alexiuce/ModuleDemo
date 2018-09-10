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
   
    return [self listAllFilesInPath:targetPath fileType:DOT_STAR];
}

/**
 列出指定目录下的指定类型的所有文件
 
 @param targetPath 指定的目录
 @param type 指定的类型
 @return 返回搜索的结果数组
 */
- (NSArray <NSString *>*)listAllFilesInPath:(NSString *)targetPath fileType:(XCFileType)type{
    
    NSArray <NSString *>*result = [self.fileManager contentsOfDirectoryAtPath:targetPath error:nil];
    
    NSMutableArray <NSString *>*filesArray = [NSMutableArray arrayWithCapacity:10];
    
    for (NSString *fileName in result) {
        BOOL flag = YES;
        NSString *fullPath = [targetPath stringByAppendingPathComponent:fileName];
        [self.fileManager fileExistsAtPath:fullPath isDirectory:&flag];
        if (flag) {
           [filesArray addObjectsFromArray:[self listAllFilesInPath:fullPath fileType:type]];
        }else{
            // 判断文件类型是否匹配
            if (type & DOT_STAR) {
                NSLog(@"%@  >>>>> %@",targetPath.lastPathComponent, fileName);
                [filesArray addObject:fileName];
            }else if ((type & DOT_M) && [fileName hasSuffix:@".m"]){
                NSLog(@"%@  >>>>> %@",targetPath.lastPathComponent, fileName);
                 [filesArray addObject:fileName];
            }else if ((type & DOT_H) && [fileName hasSuffix:@".h"]){
                NSLog(@"%@  >>>>> %@",targetPath.lastPathComponent, fileName);
                 [filesArray addObject:fileName];
            }
        }
    }


    return [filesArray copy];
}



#pragma mark - lazy getter method

- (NSFileManager *)fileManager{
    if (_fileManager == nil) {
        _fileManager = NSFileManager.defaultManager;
    }
    return _fileManager;
}


@end
