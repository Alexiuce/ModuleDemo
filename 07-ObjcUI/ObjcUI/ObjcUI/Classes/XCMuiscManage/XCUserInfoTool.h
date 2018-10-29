//
//  XCUserInfoTool.h
//  ObjcUI
//
//  Created by Alexcai on 2018/10/28.
//  Copyright © 2018 dongjiu. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface XCUserInfoTool : NSObject

+ (instancetype)shareTool;

- (void)saveInfo:(id)info forKey:(NSString *)infoKey;

- (id)infoWithKey:(NSString *)infoKey;


@end

NS_ASSUME_NONNULL_END
