//
//  RequestModel.h
//  Objc-UI
//
//  Created by Alexcai on 2018/9/7.
//  Copyright © 2018年 Alexcai. All rights reserved.
//  网络请求数据模型

#import <Foundation/Foundation.h>


typedef NS_ENUM(NSUInteger,RequestType){
    POST,
    GET
} ;

@interface RequestModel : NSObject

/**
 *  网络请求参数
 */
@property (nonnull, nonatomic, strong) NSString *apiMethodPath;              //网络请求地址
@property (nullable, nonatomic, strong) NSDictionary *parameters;             //请求参数
@property (nonatomic, assign) RequestType apiMethodType;                      // 请求类型: 默认POST

@end
