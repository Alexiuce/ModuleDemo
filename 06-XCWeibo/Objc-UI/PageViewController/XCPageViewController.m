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
#import "FirstTableViewController.h"
#import "SecTableViewController.h"
#import "XCPageViewConfig.h"

#define kScreenWidth                        [UIScreen mainScreen].bounds.size.width
#define kScreenHeight                       [UIScreen mainScreen].bounds.size.height



@interface XCPageViewController ()<UIScrollViewDelegate,WMPageControllerDelegate>

@property (nonatomic, strong) PageScrollerView *psv;   // scrollView 容器,包含 topView和contain View

@property (nonatomic, strong) UIView *topView;   // 顶部视图
@property (nonatomic, strong) UIView *containerView;  // 容器视图,用来显示childeViewController 内容

@property (nonatomic, strong) WMPageController *containerController;  // 控制器容器,用来管理childController
@property (nonatomic, assign) BOOL isFirstShow;  // 是否第一次显示界面,用来处理左右滑动时,禁止上下滑动;

@property (nonatomic, assign) BOOL canScroll;

@end

@implementation XCPageViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = UIColor.grayColor;
    [self.view addSubview:self.psv];
    [self.psv addSubview:self.topView];
    [self.psv addSubview:self.containerView];
     _canScroll = _isFirstShow = true;
    [self.containerView addSubview:self.containerController.view];
     [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(acceptMsg:) name:PageLeaveTopNotification object:nil];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self.psv mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.right.equalTo(self.view);
    }];

    [self.topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.leading.trailing.equalTo(self.psv);
        make.width.equalTo(self.psv);
        make.height.mas_equalTo(150);
    }];

    [self.containerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.bottom.trailing.equalTo(self.psv);
        make.top.equalTo(self.topView.mas_bottom);
        make.width.equalTo(self.psv);
        make.height.mas_equalTo(kScreenHeight - 64);
    }];
    self.containerController.viewFrame = CGRectMake(0, 0, kScreenWidth, kScreenHeight-64);
}

#pragma mark - UIScrollerViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat maxOffset = 150 - 64;
    CGFloat offsetY = scrollView.contentOffset.y;
    self.navigationController.navigationBar.alpha = offsetY / maxOffset;
    // 1. 上滑动到顶部时,固定选项卡位置;
    if (offsetY >= maxOffset) {
        scrollView.contentOffset = CGPointMake(0, maxOffset);
        
        [[NSNotificationCenter defaultCenter] postNotificationName:PageGoTopNotification object:nil userInfo:@{@"canScroll":@"1"}];
        _canScroll = NO;
        return;
    }
    
    // 2.如果选择卡在顶端,向下滑动childController 中的内容时,未达到内容头部,不滚动容器scrollView;
    if (!_canScroll) {
        scrollView.contentOffset = CGPointMake(0, maxOffset);
//        return;
    }
    // 3. 下拉放大 顶部视图
    if (offsetY < 0) {
        
        [self.topView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.psv).offset(offsetY);
            make.height.mas_equalTo(150 - offsetY);
        }];
        [UIView animateWithDuration:0 animations:^{
            [self.view layoutIfNeeded];
        }];
        
    }
    
    
    
}


#pragma mark - WMPageControllerDelegate
- (void)pageController:(WMPageController *)pageController willEnterViewController:(__kindof UIViewController *)viewController withInfo:(NSDictionary *)info{
    if (_isFirstShow) {_isFirstShow = false;return;}
    NSLog(@"-------");
    _psv.scrollEnabled = false;
    
}

- (void)pageController:(WMPageController *)pageController didEnterViewController:(__kindof UIViewController *)viewController withInfo:(NSDictionary *)info{
    NSLog(@"========");
    _psv.scrollEnabled = true;
}


#pragma mark - notification

-(void)acceptMsg : (NSNotification *)notification{
    NSDictionary *userInfo = notification.userInfo;
    NSString *canScroll = userInfo[@"canScroll"];
    if ([canScroll isEqualToString:@"1"]) {
        _canScroll = YES;
    }
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

- (WMPageController *)containerController{
    if (_containerController == nil) {
        _containerController = [[WMPageController alloc]initWithViewControllerClasses:@[[FirstTableViewController class],[SecTableViewController class]] andTheirTitles:@[@"动态",@"资料"]];
        _containerController.menuViewStyle = WMMenuViewStyleLine;
        _containerController.menuHeight = 44;
        _containerController.titleSizeNormal = 15;
        _containerController.titleSizeSelected = 17;
        _containerController.titleColorNormal = UIColor.grayColor;
        _containerController.titleColorSelected = UIColor.redColor;
        _containerController.delegate = self;
    }
    return _containerController;
}


@end
