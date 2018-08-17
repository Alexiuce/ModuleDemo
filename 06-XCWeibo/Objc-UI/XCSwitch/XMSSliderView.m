//
//  XMSSliderView.m
//  Objc-UI
//
//  Created by Alexcai on 2018/8/16.
//  Copyright © 2018年 Alexcai. All rights reserved.
//

#import "XMSSliderView.h"



@interface XMSSliderView()
    
    
@property (weak, nonatomic) IBOutlet UIButton *leftButton;
    
@property (weak, nonatomic) IBOutlet UIButton *rightButton;
    
@property (nonatomic, strong) CALayer *animateLayer;
    
@property (nonatomic, strong) CABasicAnimation *moveAnimation;  // 移动动画

@property (nonatomic, weak) UIButton *currentSelecteButton;
    
@end


@implementation XMSSliderView
    
+ (instancetype)sliderView{
    
    return [[NSBundle mainBundle] loadNibNamed:@"XMSSliderView" owner:nil options:nil].firstObject;
}

- (void)awakeFromNib{
    [super awakeFromNib];
    self.leftButton.selected = YES;
    [self.layer addObserver:self forKeyPath:@"cornerRadius" options:NSKeyValueObservingOptionNew context:nil];
    self.currentSelecteButton = self.leftButton;
    _currentSelectedIndex = 0;
}

    
    
#pragma mark - animation handle
    
// 点击左边按钮
- (IBAction)clickLeftButton:(UIButton *)sender {
   NSValue *toValue = [NSValue valueWithCGPoint:CGPointMake(0, 0)];
    [self startAnimation:sender toValue:toValue];
}
    
// 点击右边按钮
- (IBAction)clickRightButton:(UIButton *)sender {
    NSValue *toValue =[NSValue valueWithCGPoint:CGPointMake(self.bounds.size.width * 0.5, 0)];
    [self startAnimation:sender toValue:toValue];
}

- (void)startAnimation:(UIButton *)button toValue:(NSValue *)toValue{
    if (button == self.currentSelecteButton){return;}
    self.currentSelecteButton.selected = NO;
    button.selected = YES;
    self.currentSelecteButton = button;
    self.moveAnimation.toValue = toValue;
    [self.animateLayer addAnimation:self.moveAnimation forKey:nil];
    if ([self.select_delegate conformsToProtocol:@protocol(XMSSliderViewDelegate)]) {
        [self.select_delegate sliderView:self didSelectedAtIndex:button == self.leftButton ? 0 : 1];
    }
}
    
#pragma mark KVO observer methon
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    if (object != self.layer){return;}
    CGFloat newCornerRadius = [change[NSKeyValueChangeNewKey] floatValue];
    self.animateLayer.cornerRadius = newCornerRadius;
}
    
#pragma mark - lazy getter method
    
- (CALayer *)animateLayer{
    if (_animateLayer == nil){
        _animateLayer = [CALayer layer];
        _animateLayer.frame = CGRectMake(0, 0, self.bounds.size.width * 0.5, self.bounds.size.height);
        _animateLayer.backgroundColor = UIColor.orangeColor.CGColor;
        _animateLayer.anchorPoint = CGPointZero;
        [self.layer insertSublayer:self.animateLayer atIndex:0];
        _animateLayer.position = CGPointZero;
    }
    return _animateLayer;
}

- (CABasicAnimation *)moveAnimation{
    if (_moveAnimation == nil){
        _moveAnimation = [CABasicAnimation animationWithKeyPath:@"position"];
        _moveAnimation.duration = 0.25f;
        _moveAnimation.removedOnCompletion = NO;
        _moveAnimation.fillMode = kCAFillModeForwards;
    }
    return _moveAnimation;
}

- (void)setCurrentSelectedIndex:(NSUInteger)currentSelectedIndex{
    _currentSelectedIndex = currentSelectedIndex;
    currentSelectedIndex == 0 ?[self clickLeftButton:self.leftButton] : [self clickRightButton:self.rightButton];
}

- (void)dealloc{
    [self.layer removeObserver:self forKeyPath:@"cornerRadius"];
}
@end
