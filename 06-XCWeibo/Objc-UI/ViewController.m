//
//  ViewController.m
//  Objc-UI
//
//  Created by Alexcai on 2018/7/18.
//  Copyright © 2018年 Alexcai. All rights reserved.
//

#import "ViewController.h"
#import "HelloView.h"
#import "SDAutoLayout.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    HelloView *v = [[NSBundle mainBundle]loadNibNamed:@"HelloView" owner:self options:nil].firstObject;//[[HelloView alloc]init];
    v.frame = CGRectMake(100, 100, 30, 30);
    [self.view addSubview:v];
    
    
    
     
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
