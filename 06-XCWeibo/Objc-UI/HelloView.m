//
//  HelloView.m
//  Objc-UI
//
//  Created by Alexcai on 2018/7/18.
//  Copyright © 2018年 Alexcai. All rights reserved.
//

#import "HelloView.h"

@implementation HelloView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)awakeFromNib{
    [super awakeFromNib];
    NSLog(@"hello view ~");
    
}

@end
