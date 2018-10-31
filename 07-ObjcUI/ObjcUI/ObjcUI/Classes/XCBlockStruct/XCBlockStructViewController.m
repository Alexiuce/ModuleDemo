//
//  XCBlockStructViewController.m
//  ObjcUI
//
//  Created by Alexcai on 2018/10/31.
//  Copyright © 2018 dongjiu. All rights reserved.
//

#import "XCBlockStructViewController.h"

#define MYBolck  void(^MYblock)(void) = ^


@interface XCBlockStructViewController ()

@end

@implementation XCBlockStructViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    void(^myBlock)(void) = ^{
        NSLog(@"this is a not param block func");
    };
    
    
    myBlock();
    
    MYBolck {
        NSLog(@"this define block ");
    };
    MYblock();
}



@end
