//
//  XCPageViewController.m
//  Objc-UI
//
//  Created by Alexcai on 2018/7/31.
//  Copyright © 2018年 Alexcai. All rights reserved.
//

#import "XCPageViewController.h"

@interface XCPageViewController ()
@property (weak, nonatomic) IBOutlet UIView *topHeadView;

@property (nonatomic, weak) UIViewController * currentController;



@end

@implementation XCPageViewController

+ (instancetype)pageViewControllers:(NSArray<UIViewController *> *)children{
 
    return [[self alloc]initWithControllers:children];
}

- (instancetype)initWithControllers:(NSArray <UIViewController *> *)controllers{
    if (self = [super init]) {
        for (UIViewController *c in controllers) {
            [self addChildViewController:c];
        }
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];

}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    if (_currentController == nil) {return;}
    [self.view insertSubview:_currentController.view atIndex:0];
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
