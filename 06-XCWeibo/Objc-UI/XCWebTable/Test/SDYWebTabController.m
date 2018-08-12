//
//  SDYWebTabController.m
//  Flashfish
//
//  Created by Alexcai on 2018/8/12.
//  Copyright © 2018年 杭州东九网络科技有限公司. All rights reserved.
//

#import "SDYWebTabController.h"
#import "SDYWebTabController+SDYWebTab.h"

@interface SDYWebTabController ()
@end

@implementation SDYWebTabController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.scrollViewContainerView addSubview:self.topView];
    [self.scrollViewContainerView addSubview:self.webView];
    [self.scrollViewContainerView addSubview:self.tableView];
    [self.scrollView addSubview:self.scrollViewContainerView];
    [self.view addSubview:self.scrollView];
    
    NSURL *url = [NSURL URLWithString:@"https://www.jianshu.com/p/b6b30d38255e"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [self.webView loadRequest:request];
    
    self.scrollViewContainerView.frame = CGRectMake(0, 0, self.view.width, self.view.height * 2);
    
    self.webView.y = self.topView.height;
    self.webView.height = self.view.height;
    self.tableView.y = CGRectGetMaxY(self.scrollView.bounds);
    [self startRequest];
}


- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.tableView addObserver:self forKeyPath:@"contentSize" options:NSKeyValueObservingOptionNew context:nil];
    [self.webView addObserver:self forKeyPath:@"scrollView.contentSize" options:NSKeyValueObservingOptionNew context:nil];
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.tableView removeObserver:self forKeyPath:@"contentSize"];
    [self.webView removeObserver:self forKeyPath:@"scrollView.contentSize"];
}

#pragma mark - Networking request
- (void)startRequest{
    
}


#pragma mark - lazy getter method
- (UIScrollView *)scrollView{
    if (_scrollView == nil) {
        _scrollView = [[UIScrollView alloc]initWithFrame:self.view.bounds];
        _scrollView.delegate = self;
        _scrollView.alwaysBounceVertical = YES;
    }
    return _scrollView;
}

- (UIView *)scrollViewContainerView{
    if (_scrollViewContainerView == nil) {
        _scrollViewContainerView = [[UIView alloc]init];
    }
    return _scrollViewContainerView;
}

- (WKWebView *)webView{
    if (_webView == nil) {
        WKWebViewConfiguration *config = [[WKWebViewConfiguration alloc]init];
        _webView = [[WKWebView alloc]initWithFrame:self.view.bounds configuration:config];
        _webView.scrollView.scrollEnabled = NO;
    }
    return _webView;
}

- (UITableView *)tableView{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _tableView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView = [UIView new];
        _tableView.scrollEnabled = NO;
    }
    return _tableView;
}
- (UIView *)topView{
    if (_topView == nil) {
        _topView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.width, 70)];
        _topView.backgroundColor = UIColor.redColor;
        
    }
    return _topView;
}
@end
