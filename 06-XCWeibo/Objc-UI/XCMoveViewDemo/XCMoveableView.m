//
//  XCMoveableView.m
//  Objc-UI
//
//  Created by Alexcai on 2018/10/11.
//  Copyright © 2018 Alexcai. All rights reserved.
//

#import "XCMoveableView.h"

@implementation XCMoveableView

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
    //做UIView拖拽
    UITouch *touch = [touches anyObject];
    
    
    //求偏移量 = 手指当前点的X - 手指上一个点的X
    CGPoint curP = [touch locationInView:self];
    CGPoint preP = [touch previousLocationInView:self];

    
    CGFloat offsetX = curP.x - preP.x;
    CGFloat offsetY = curP.y - preP.y;
    
    //平移
    self.transform = CGAffineTransformTranslate(self.transform, offsetX, offsetY);
}

@end
