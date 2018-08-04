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


@property (nonatomic, strong) UILabel *l1;
@property (nonatomic, strong) UILabel *l2;

@end

@implementation ANViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _l1 = [[UILabel alloc]init];
    _l1.frame = CGRectMake(20, self.containerView.height, 80, 20);
    _l1.backgroundColor = UIColor.redColor;
    
    [self.containerView addSubview:self.l1];
    _l2 = [[UILabel alloc] init];
    _l2.backgroundColor = UIColor.yellowColor;
    
    
}


- (void)starAnim{
    
    [UIView animateWithDuration:0.4 animations:^{
        self.l1.y = -self.l1.height;
    }];
    
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self starAnim];
}

@end
