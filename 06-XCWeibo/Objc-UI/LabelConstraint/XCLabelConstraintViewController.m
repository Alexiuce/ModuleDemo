//
//  XCLabelConstraintViewController.m
//  Objc-UI
//
//  Created by Alexcai on 2018/9/19.
//  Copyright © 2018年 Alexcai. All rights reserved.
//

#import "XCLabelConstraintViewController.h"

@interface XCLabelConstraintViewController ()


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
    self.label3ToSuperLeftConstraint.constant = 16.0f;
    [self.label3ToSuperLeftConstraint setActive:YES];
    
}
- (IBAction)clickReset:(UIButton *)sender {
    self.label3LeftMarginConstraint.constant = 26.0f;
    [self.label3LeftMarginConstraint setActive:YES];
//    self.label3ToSuperLeftConstraint.constant = 16.0f;
    [self.label3ToSuperLeftConstraint setActive:NO];
}

@end
