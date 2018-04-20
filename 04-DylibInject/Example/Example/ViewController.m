//
//
// ViewController.m
// Created by Alex on 2018/4/20
// Copyright © 2018年 hfapp.com.joinf.www. All rights reserved.

//

#import "ViewController.h"


@interface ViewController()

@property (weak) IBOutlet NSTextField *titleLabel;

@end


@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (IBAction)click:(NSButton *)sender {
    
    self.titleLabel.stringValue = @"clicked the button";
    
}

@end
