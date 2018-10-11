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
    
    CGFloat ScreenWidth = UIScreen.mainScreen.bounds.size.width;
    CGFloat ScreenHeight = UIScreen.mainScreen.bounds.size.height;
    CGFloat newX = self.frame.origin.x + offsetX;
    CGFloat newY = self.frame.origin.y + offsetY;
    
    newX = MAX(newX, 0);  // 设置x最小值不低于0;
    newX = MIN(newX, ScreenWidth - self.bounds.size.width);  // 设置x最大值不超过屏幕宽度 - 自身宽度;
    
    newY = MAX(newY, 0);
    newY = MIN(newY, ScreenHeight - self.bounds.size.height);
    
    
    
    self.frame = CGRectMake(newX, newY, self.bounds.size.width, self.bounds.size.height);
    
}

@end
