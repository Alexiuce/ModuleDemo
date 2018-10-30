//
//  XCDataModelManager.h
//  ObjcUI
//
//  Created by Alexcai on 2018/10/29.
//  Copyright © 2018 dongjiu. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol  XCDataModelDataSource <NSObject>

+ (NSDictionary *)replacePropertyName;

@end


NS_ASSUME_NONNULL_BEGIN

@interface XCDataModelManager : NSObject

/**
 根据json 数组快速创建 模型数组

 @param dicts json 数组
 @parma cls: 数组中包含的模型类型;
 @return 返回包含模型的数组对象;
 */
+ (NSArray *)modelsWithJsonAarray:(NSArray *)dicts classInArray:(Class)cls;



/**
 根据json 字典创建模型对象

 @param dict json 字典
 @param cls 指定返回的模型类
 @return 返回创建好的模型对象
 */
+ (id)modelWithJson:(NSDictionary *)dict modelClass:(Class)cls;

@end

NS_ASSUME_NONNULL_END
