//
//  XCSubViewFrameView.m
//  Objc-UI
//
//  Created by Alexcai on 2018/9/21.
//  Copyright © 2018年 Alexcai. All rights reserved.
//

#import "XCSubViewFrameView.h"

@implementation XCSubViewFrameView

+ (instancetype)xibView{
    return [[NSBundle mainBundle]loadNibNamed:@"XCSubViewFrame" owner:nil options:nil].firstObject;
}

@end
