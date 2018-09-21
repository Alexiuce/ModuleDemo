//
//  XCLabelConstraintViewController.m
//  Objc-UI
//
//  Created by Alexcai on 2018/9/19.
//  Copyright © 2018年 Alexcai. All rights reserved.
//

#import "XCLabelConstraintViewController.h"

@interface XCLabelConstraintViewController ()

@property (weak, nonatomic) IBOutlet UIView *containerView;
@property (weak, nonatomic) IBOutlet UILabel *l1;
@property (weak, nonatomic) IBOutlet UILabel *l2;
@property (weak, nonatomic) IBOutlet UILabel *l3;

@property (strong, nonatomic) IBOutlet NSLayoutConstraint *label3ToSuperLeftConstraint;

@property (strong, nonatomic) IBOutlet NSLayoutConstraint *label3LeftMarginConstraint;


@property (nonatomic, strong)UILayoutGuide *layoutGuide;

@property (weak, nonatomic) IBOutlet UILabel *l4;
@property (weak, nonatomic) IBOutlet UILabel *l5;


@end

@implementation XCLabelConstraintViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
  
}


- (IBAction)clickLeft:(UIButton *)sender {
    
    [self.label3LeftMarginConstraint setActive:NO];
    
    [UIView animateWithDuration:0.35 animations:^{
        self.l1.alpha = self.l2.alpha = 0;
        self.label3ToSuperLeftConstraint.constant = 16.0f;
        [self.label3ToSuperLeftConstraint setActive:YES];
        [self.containerView layoutIfNeeded];
        
    }];
    
}
- (IBAction)clickReset:(UIButton *)sender {
    [self.label3ToSuperLeftConstraint setActive:NO];
    [UIView animateWithDuration:0.35 animations:^{
      
        self.l1.alpha = self.l2.alpha = 1;
        [self.label3LeftMarginConstraint setActive:YES];
       
        [self.containerView layoutIfNeeded];
        
    }];

}

#pragma mark - UILayoutGuide

- (void)guideForLayout{
        self.layoutGuide = [UILayoutGuide new];
        [self.view addLayoutGuide:self.layoutGuide];
    
        [self.layoutGuide.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor].active = YES;
        [self.layoutGuide.leftAnchor constraintEqualToAnchor:self.view.leftAnchor].active = YES;
        [self.layoutGuide.rightAnchor constraintEqualToAnchor:self.view.rightAnchor].active = YES;
        [self.layoutGuide.heightAnchor constraintEqualToConstant:100].active = YES;
    
        self.l4.translatesAutoresizingMaskIntoConstraints = NO;
    
        UIView *bgView = [UIView new];
        bgView.translatesAutoresizingMaskIntoConstraints = NO;
        bgView.backgroundColor = UIColor.redColor;
        [self.view insertSubview:bgView atIndex:0];
    
        [self.l4.topAnchor constraintEqualToAnchor:self.layoutGuide.topAnchor constant:20].active = YES;
    
        [self.l4.leftAnchor constraintEqualToAnchor:self.layoutGuide.leftAnchor constant:50].active = YES;
        [self.l5.bottomAnchor constraintEqualToAnchor:self.layoutGuide.bottomAnchor].active = YES;
        [self.l5.rightAnchor constraintEqualToAnchor:self.layoutGuide.rightAnchor].active = YES;
    
        [bgView.topAnchor constraintEqualToAnchor:self.layoutGuide.topAnchor].active = YES;
        [bgView.leftAnchor constraintEqualToAnchor:self.layoutGuide.leftAnchor].active = YES;
        [bgView.widthAnchor constraintEqualToAnchor:self.layoutGuide.widthAnchor].active = YES;
        [bgView.heightAnchor constraintEqualToAnchor:self.layoutGuide.heightAnchor].active = YES;
}
#pragma mark - AutoresizingMaskIntoConstraints
- (void)maskToConstraint{
    
    NSLog(@"%@",self.l4.translatesAutoresizingMaskIntoConstraints ? @"Y":@"N");
    self.l4.translatesAutoresizingMaskIntoConstraints = NO;
    self.l4.frame = CGRectMake(100, 130, 100, 20);
    
}

@end
