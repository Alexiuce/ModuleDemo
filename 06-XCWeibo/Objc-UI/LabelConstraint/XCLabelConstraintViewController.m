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

@end
