//
//  SDYStrategyBottomInputView.m
//  Objc-UI
//
//  Created by Alexcai on 2018/8/13.
//  Copyright © 2018年 Alexcai. All rights reserved.
//

#import "SDYStrategyBottomInputView.h"
#import "UIView+ACMediaExt.h"


@interface SDYStrategyBottomInputView()

@property (weak, nonatomic) IBOutlet UITextField *inputTextField;

@property (weak, nonatomic) IBOutlet UIButton *shareButton;
@property (weak, nonatomic) IBOutlet UIButton *agreeButton;



@end



@implementation SDYStrategyBottomInputView

+ (instancetype)strategyBottomInputView{
    return [[NSBundle mainBundle]loadNibNamed:@"SDYStrategyBottomInputView" owner:nil options:nil].firstObject;
}



- (void)awakeFromNib{
    [super awakeFromNib];
    self.inputTextField.placeholder = @"说点什么吧.....";
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    
     [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHiden:) name:UIKeyboardWillHideNotification object:nil];
    
    
}


#pragma mark - Notification handler

- (void)keyboardWillShow:(NSNotification *)notification{
    NSDictionary *userInfo = notification.userInfo;
    CGRect endFrame = [userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    //获取键盘的高度
    //键盘的动画时长
    CGFloat duration = [userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    // 键盘的动画节奏
    UIViewAnimationOptions animationOption = [notification.userInfo[UIKeyboardAnimationCurveUserInfoKey] integerValue];
    
    
    [UIView animateWithDuration:duration delay:0 options:animationOption animations:^{
        self.transform = CGAffineTransformMakeTranslation(0, -endFrame.size.height);
        
    } completion:nil];


}

- (void)keyboardWillHiden:(NSNotification *)notification{
     NSDictionary *userInfo = notification.userInfo;
    CGFloat duration = [userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    // 键盘的动画节奏
    UIViewAnimationOptions animationOption = [notification.userInfo[UIKeyboardAnimationCurveUserInfoKey] integerValue];
    
    
    [UIView animateWithDuration:duration delay:0 options:animationOption animations:^{
        self.transform = CGAffineTransformIdentity;
        
    } completion:nil];
}



@end
