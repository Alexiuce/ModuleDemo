//
//  XCBlockStructViewController.m
//  ObjcUI
//
//  Created by Alexcai on 2018/10/31.
//  Copyright © 2018 dongjiu. All rights reserved.
//

#import "XCBlockStructViewController.h"

#define MYBolck  void(^MYblock)(void) = ^


typedef struct {
    int a;
    int b;
    void *func;
}MYBlockStruck;

void testFunc(){
    NSLog(@"hello test Func");
}

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
    
    MYBlockStruck ms = {10,20,testFunc};
    
    NSLog(@"a =%d ,b = %d",ms.a,ms.b);
    
    
}

- (void)test{
    NSLog(@"hello struce");
}

@end
