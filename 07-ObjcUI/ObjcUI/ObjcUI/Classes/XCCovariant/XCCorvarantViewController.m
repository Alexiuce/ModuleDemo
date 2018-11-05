//
//  XCCorvarantViewController.m
//  ObjcUI
//
//  Created by Alexcai on 2018/11/4.
//  Copyright © 2018 dongjiu. All rights reserved.
//

#import "XCCorvarantViewController.h"
#import "XCCovarantObj.h"

@interface XCCorvarantViewController ()

@end

@implementation XCCorvarantViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    XCCovarantObj<NSString *> *obj = [XCCovarantObj new];
    obj.obj = @"Hello covariant string";
    
    XCCovarantObj<NSDictionary *> *obj2 = [XCCovarantObj new];
    obj2.obj = @{@"hello":@"convariant"};
    NSString *h = obj2.obj[@"hello"];
    NSLog(@"%@",h);
    XCCovarantObj *obj3 = [XCCovarantObj new];
    obj3.obj = @"none";
    
    
    
    // Do any additional setup after loading the view.
}



@end
