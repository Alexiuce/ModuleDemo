//
//  SAFrameObj.h
//  Objc-UI
//
//  Created by Alexcai on 2018/8/18.
//  Copyright © 2018年 Alexcai. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface SAFrameObj : NSObject
+ (instancetype)shareFrame;


@property (nonatomic, assign,) CGRect screenBounds;

@end
