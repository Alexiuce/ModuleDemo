//
//  XCDataModelManager.m
//  ObjcUI
//
//  Created by Alexcai on 2018/10/29.
//  Copyright © 2018 dongjiu. All rights reserved.
//

#import "XCDataModelManager.h"
#import <MJExtension/MJExtension.h>

@implementation XCDataModelManager


+ (NSArray *)modelsWithJsonAarray:(NSArray *)dicts classInArray:(Class)cls {
    
    return [cls mj_objectArrayWithKeyValuesArray:dicts];
}



@end
