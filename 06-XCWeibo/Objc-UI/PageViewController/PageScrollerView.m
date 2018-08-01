//
//  PageScrollerView.m
//  Objc-UI
//
//  Created by Alexcai on 2018/8/1.
//  Copyright © 2018年 Alexcai. All rights reserved.
//

#import "PageScrollerView.h"

@implementation PageScrollerView

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    return YES;
}


@end
