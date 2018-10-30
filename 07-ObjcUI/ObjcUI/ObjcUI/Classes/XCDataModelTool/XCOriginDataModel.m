//
//  XCOriginDataModel.m
//  ObjcUI
//
//  Created by Alexcai on 2018/10/30.
//  Copyright © 2018 dongjiu. All rights reserved.
//

#import "XCOriginDataModel.h"
#import <MJExtension.h>

@implementation XCOriginDataModel


+ (instancetype)modelWithJson:(NSDictionary *)dict{
    return [self mj_objectWithKeyValues:dict];
}

+ (NSArray<XCOriginDataModel *> *)modelsWithJsonArray:(NSArray *)dicts{
    
    [self mj_setupReplacedKeyFromPropertyName:^NSDictionary *{
        return @{ @"game": @"gameName" };
    }];
    
    return [self mj_objectArrayWithKeyValuesArray:dicts];
}

@end
