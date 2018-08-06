//
//  ANViewController.m
//  Objc-UI
//
//  Created by Alexcai on 2018/8/4.
//  Copyright © 2018年 Alexcai. All rights reserved.
//

#import "ANViewController.h"
#import "UIView+ACMediaExt.h"

@interface ANViewController ()
@property (weak, nonatomic) IBOutlet UIView *containerView;

@property (nonatomic, strong) NSArray <NSString *>*titleArray;

@property (nonatomic, strong) UILabel *l1;
@property (nonatomic, strong) UILabel *l2;
@property (nonatomic, assign) NSUInteger titleIndex;

@end

@implementation ANViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _titleArray = @[@"text1",@"text2",@"txt3"];
    _l1 = [[UILabel alloc]init];
    _l1.frame = CGRectMake(20, self.containerView.height, 80, 20);
    _l1.backgroundColor = UIColor.redColor;
    self.containerView.clipsToBounds = YES;
    [self.containerView addSubview:self.l1];
    _l2 = [[UILabel alloc] init];
    _l2.frame =  CGRectMake(20, self.containerView.height + self.l1.y + self.l1.height, 100, 20);
    _l2.backgroundColor = UIColor.yellowColor;
    [self.containerView addSubview:self.l2];
    
    
}


- (void)starAnim{
    
    self.l1.text = self.titleArray[self.titleIndex];
    self.l1.alpha = 0;
 
    [UIView animateWithDuration:1.2 delay:0 options:UIViewAnimationOptionCurveEaseIn  animations:^{
        self.l1.y = self.containerView.height * 0.5;
        self.l1.alpha = 1;
    } completion:^(BOOL finished) {
        
        [UIView animateWithDuration:1.2 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
            self.l1.y = - self.l1.height;
            self.l1.alpha = 0;
    
        } completion:^(BOOL finished) {
            self.l1.y = self.containerView.height;
            self.titleIndex += 1;
            if (self.titleIndex > self.titleArray.count - 1) {
                self.titleIndex = 0;
            }
            [self starAnim];
        }];
    }];
    
}

- (void)startL2Anim{
    self.l2.text = self.titleArray[self.titleIndex];
    self.l2.alpha = 0;
    
    [UIView animateWithDuration:1.2 delay:0 options:UIViewAnimationOptionCurveEaseIn  animations:^{
        self.l2.y = self.containerView.height * 0.5;
        self.l2.alpha = 1;
    } completion:^(BOOL finished) {
        
        [UIView animateWithDuration:1.2 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
            self.l2.y = - self.l1.height;
            self.l2.alpha = 0;
            
        } completion:^(BOOL finished) {
            self.l2.y = self.containerView.height;
            self.titleIndex += 1;
            if (self.titleIndex > self.titleArray.count - 1) {
                self.titleIndex = 0;
            }
            [self startL2Anim];
        }];
    }];
}


- (void)l1LayerAnim{
    CALayer *layer = self.l1.layer;
    
    CABasicAnimation *baseAnim = [CABasicAnimation animation];
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self starAnim];
//    [self startL2Anim];
}

@end
