//
//  ViewController.m
//  Objc-ios
//
//  Created by Alexcai on 2018/7/17.
//  Copyright © 2018年 alexiuce.github.io. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIWebView *web = [[UIWebView alloc]init];
    [web respondsToSelector:NSSelectorFromString(@"")];
    
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
