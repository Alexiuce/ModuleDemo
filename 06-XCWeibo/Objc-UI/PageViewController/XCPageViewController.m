//
//  XCPageViewController.m
//  Objc-UI
//
//  Created by Alexcai on 2018/7/31.
//  Copyright © 2018年 Alexcai. All rights reserved.
//

#import "XCPageViewController.h"
#import "PageScrollerView.h"
#import "WMPageController.h"
#import "Masonry.h"


#define kScreenWidth                        [UIScreen mainScreen].bounds.size.width
#define kScreenHeight                       [UIScreen mainScreen].bounds.size.height

@interface XCPageViewController ()<UIScrollViewDelegate>

@property (nonatomic, strong) PageScrollerView *psv;   // scrollView 容器,包含 topView和contain View

@property (nonatomic, strong) UIView *topView;   // 顶部视图
@property (nonatomic, strong) UIView *containerView;  // 容器视图,用来显示childeViewController 内容

@property (nonatomic, strong) WMPageController *containerController;  // 控制器容器,用来管理childController

@end

@implementation XCPageViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self.view addSubview:self.psv];
    [self.psv addSubview:self.topView];
    [self.psv addSubview:self.containerView];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self.psv mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.right.equalTo(self.view);
    }];
//
    [self.topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.leading.trailing.equalTo(self.psv);
        make.width.equalTo(self.psv);
        make.height.mas_equalTo(150);
    }];
//
    [self.containerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.bottom.trailing.equalTo(self.psv);
        make.top.equalTo(self.topView.mas_bottom);
        make.width.equalTo(self.psv);
        make.height.mas_equalTo(kScreenHeight - 64);
    }];
}

#pragma mark - UIScrollerViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
}


#pragma mark - getter
- (PageScrollerView *)psv{
    if (_psv == nil) {
        _psv = [[PageScrollerView alloc]init];
        _psv.delegate = self;
        _psv.showsVerticalScrollIndicator = NO;
    }
    return _psv;
}

- (UIView *)topView{
    if (_topView == nil) {
        _topView = [[UIView alloc] init];
        _topView.backgroundColor = UIColor.redColor;
    }
    return _topView;
}

- (UIView *)containerView{
    if (_containerView == nil) {
        _containerView = [[UIView alloc] init];
        _containerView.backgroundColor = [UIColor yellowColor];
    }
    return _containerView;
}

@end
