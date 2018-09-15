//
//  XCFileManager.h
//  Objc-main
//
//  Created by Alexcai on 2018/9/7.
//  Copyright © 2018年 Alexcai. All rights reserved.
//

#import <Foundation/Foundation.h>


typedef NS_OPTIONS(NSUInteger, XCFileType){
    DOT_STAR = 1 << 0,  /** .* 所有文件  */
    DOT_M = 1 << 1,  /** .m 文件*/
    DOT_H = 1 << 2,  /** .h 文件 */
};


@interface XCFileManager : NSObject

+ (instancetype)shareManager;


- (void)testReadFile:(NSNotification *)notification;

/**
 列出指定目录的下的所有文件

 @param targetPath 指定的目标路径
 */
- (NSArray *)listAllFilesInPath:(NSString *)targetPath;


/**
 列出指定目录下的指定类型的所有文件

 @param targetPath 指定的目录
 @param type 指定的类型
 @return 返回搜索的结果数组
 */
- (NSArray *)listAllFilesInPath:(NSString *)targetPath fileType:(XCFileType)type;

@end
