//
//  XCOriginDataModel.h
//  ObjcUI
//
//  Created by Alexcai on 2018/10/30.
//  Copyright © 2018 dongjiu. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface XCOriginDataModel : NSObject


@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *game;
@property (nonatomic, assign) int  age;


+ (NSArray <XCOriginDataModel *>*)modelsWithJsonArray:(NSArray *)dicts;

+ (instancetype)modelWithJson:(NSDictionary *)dict;

@end

NS_ASSUME_NONNULL_END
