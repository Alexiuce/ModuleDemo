//
//  PHViewController.m
//  Objc-UI
//
//  Created by Alexcai on 2018/7/31.
//  Copyright © 2018年 Alexcai. All rights reserved.
//

#import "PHViewController.h"
#import "XCPageViewController.h"


@interface PHViewController ()



@end

@implementation PHViewController

- (void)viewDidLoad {
    [super viewDidLoad];

}

- (IBAction)pushAction:(id)sender {
    XCPageViewController *pvc = [[XCPageViewController alloc]init];
    [self.navigationController pushViewController:pvc animated:YES];
    
}

@end
