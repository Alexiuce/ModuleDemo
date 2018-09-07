//
//  XCFileManager.h
//  Objc-main
//
//  Created by Alexcai on 2018/9/7.
//  Copyright © 2018年 Alexcai. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XCFileManager : NSObject

+ (instancetype)shareManager;


/**
 列出指定目录的下的所有文件

 @param targetPath 指定的目标路径
 */
- (NSArray *)listAllFilesInPath:(NSString *)targetPath;

@end
