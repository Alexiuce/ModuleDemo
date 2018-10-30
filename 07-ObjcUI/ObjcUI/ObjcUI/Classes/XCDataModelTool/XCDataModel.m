//
//  XCDataModel.m
//  ObjcUI
//
//  Created by Alexcai on 2018/10/29.
//  Copyright © 2018 dongjiu. All rights reserved.
//

#import "XCDataModel.h"
#import "XCDataModelManager.h"

@interface XCDataModel()<XCDataModelDataSource>

@end

@implementation XCDataModel


+ (NSDictionary *)replacePropertyName{
    return @{@"game":@"gameName"};
}

@end
