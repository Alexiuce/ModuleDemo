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
    
    NSLog(@"offsetX =%f, offsetY = %f",offsetX,offsetY);
    
    CGFloat ScreenWidth = UIScreen.mainScreen.bounds.size.width;
    CGFloat newX = self.frame.origin.x + offsetX;
    CGFloat newY = self.frame.origin.y + offsetY;
    newX = MAX(newX, 0);
    newX = MIN(newX, ScreenWidth - self.bounds.size.width);
    
    self.frame = CGRectMake(newX, newY, self.bounds.size.width, self.bounds.size.height);
    
}

@end
