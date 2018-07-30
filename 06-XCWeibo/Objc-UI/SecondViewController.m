//
//  SecondViewController.m
//  Objc-UI
//
//  Created by Alexcai on 2018/7/30.
//  Copyright © 2018年 Alexcai. All rights reserved.
//

#import "SecondViewController.h"

@interface SecondViewController ()
@property (weak, nonatomic) IBOutlet UIView *one;
@property (weak, nonatomic) IBOutlet UIView *two;
@property (weak, nonatomic) IBOutlet UIView *containView;

@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self oneAnim];
}

- (void)oneAnim{
    self.one.transform = CGAffineTransformMakeTranslation(0, 100);
    [UIView beginAnimations:@"" context:nil];
    [UIView setAnimationRepeatCount:MAXFLOAT];
    [UIView setAnimationDuration:0.4];
    
    self.one.alpha = 0;
    self.one.transform = CGAffineTransformMakeTranslation(0, -100);
    
    [UIView commitAnimations];
   
}

@end
