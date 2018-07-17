//
//  ViewController.m
//  OBjcDemo
//
//  Created by Alexcai on 2018/7/12.
//  Copyright © 2018年 alexiuce.github.io. All rights reserved.
//

#import "ViewController.h"
#import "Person.h"


@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    Person *p = [[Person alloc]init];
    NSLog(@"%@",p);
    NSLog(@"%d",OCInt);
    
    
    // Do any additional setup after loading the view.
}


- (void)setRepresentedObject:(id)representedObject {
    [super setRepresentedObject:representedObject];

    // Update the view, if already loaded.
}


@end
