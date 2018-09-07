//
//  RequestModel.h
//  Objc-UI
//
//  Created by Alexcai on 2018/9/7.
//  Copyright © 2018年 Alexcai. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RequestModel : NSObject



/**
 *  网络请求参数
 */
@property (nonatomic, strong) NSString *apiMethodPath;              //网络请求地址
@property (nonatomic, strong) NSDictionary *parameters;             //请求参数



@end
