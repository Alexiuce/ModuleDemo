//
//  XCCycleController.m
//  Objc-UI
//
//  Created by Alexcai on 2018/8/15.
//  Copyright © 2018年 Alexcai. All rights reserved.
//

#import "XCCycleController.h"
#import <SDCycleScrollView/SDCycleScrollView.h>

@interface XCCycleController ()

@end

@implementation XCCycleController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIView *topView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 200)];
    topView.backgroundColor = UIColor.lightGrayColor;
    [self.view addSubview:topView];
    
    NSArray *imagesURLStrings = @[
                                  @"https://ss2.baidu.com/-vo3dSag_xI4khGko9WTAnF6hhy/super/whfpf%3D425%2C260%2C50/sign=a4b3d7085dee3d6d2293d48b252b5910/0e2442a7d933c89524cd5cd4d51373f0830200ea.jpg",
                                  @"https://ss0.baidu.com/-Po3dSag_xI4khGko9WTAnF6hhy/super/whfpf%3D425%2C260%2C50/sign=a41eb338dd33c895a62bcb3bb72e47c2/5fdf8db1cb134954a2192ccb524e9258d1094a1e.jpg",
                                  @"http://c.hiphotos.baidu.com/image/w%3D400/sign=c2318ff84334970a4773112fa5c8d1c0/b7fd5266d0160924c1fae5ccd60735fae7cd340d.jpg"
                                  ];
    
     SDCycleScrollView *cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, topView.bounds.size.width, 180) delegate:nil placeholderImage:[UIImage imageNamed:@"h7"]];
     cycleScrollView.imageURLStringsGroup = imagesURLStrings;
    [topView addSubview:cycleScrollView];
    
    
    
    
}



@end
