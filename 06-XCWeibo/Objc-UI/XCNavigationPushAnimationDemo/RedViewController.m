//
//  RedViewController.m
//  Objc-UI
//
//  Created by Alexcai on 2018/10/12.
//  Copyright © 2018 Alexcai. All rights reserved.
//

#import "RedViewController.h"
#import "XCTransitionPushManager.h"

@interface RedViewController ()<UINavigationControllerDelegate>

@end

@implementation RedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = UIColor.redColor;
}


- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.delegate = self;
}


#pragma mark -- UINavigationControllerDelegate --

- (id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC{
    if (operation == UINavigationControllerOperationPop) {
        XCTransitionPushManager *tm = [XCTransitionPushManager new];
        tm.isPOP = YES;
        return tm;
    }else{
        return nil;
    }
}

@end
