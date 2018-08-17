//
//  NavTopViewController.m
//  Objc-UI
//
//  Created by Alexcai on 2018/8/17.
//  Copyright © 2018年 Alexcai. All rights reserved.
//

#import "NavTopViewController.h"

#import "NavHomeViewController.h"

@interface NavTopViewController ()

@end

@implementation NavTopViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
}
- (IBAction)push:(id)sender {
    
    NavHomeViewController *home = [[NavHomeViewController alloc]init];

    
    [self.navigationController pushViewController:home animated:YES];
}


@end
