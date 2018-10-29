//
//  XCUserInfoTool.m
//  ObjcUI
//
//  Created by Alexcai on 2018/10/28.
//  Copyright © 2018 dongjiu. All rights reserved.
//

#import "XCUserInfoTool.h"

@interface XCUserInfoTool ()



@end


@implementation XCUserInfoTool

+ (instancetype)shareTool{
    static dispatch_once_t onceToken;
    static XCUserInfoTool *__instance;
    dispatch_once(&onceToken, ^{
        __instance = [[self alloc]init];
    });
    return __instance;
}


#pragma mark - pulib method
- (void)saveInfo:(id)info forKey:(NSString *)infoKey{
    [NSUserDefaults.standardUserDefaults setObject:info forKey:infoKey];
    [NSUserDefaults.standardUserDefaults synchronize];
}

- (id)infoWithKey:(NSString *)infoKey{
    return  [NSUserDefaults.standardUserDefaults valueForKey:infoKey];
}
#pragma mark - private method


@end
