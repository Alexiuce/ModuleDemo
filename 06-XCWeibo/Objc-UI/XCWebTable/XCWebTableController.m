//
//  XCWebTableController.m
//  Objc-UI
//
//  Created by Alexcai on 2018/8/11.
//  Copyright © 2018年 Alexcai. All rights reserved.
//

#import "XCWebTableController.h"
#import "UIView+ACMediaExt.h"
#import <WebKit/WebKit.h>

@interface XCWebTableController ()<UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView *scrollView;     // 主滚动视图
@property (nonatomic, strong) UIView *scrollViewContainerView;    //  添加到scrollView中的容器视图
@property (nonatomic, strong) UITableView *tableView;       // 添加到scrollViewContainerView中的列表视图
@property (nonatomic, strong) WKWebView *webView;           // 添加到scrollViewContainerView中的web视图

@property (nonatomic, assign) CGFloat maxWebContentHeight;
@property (nonatomic, assign) CGFloat maxTabContentHeight;

@end

@implementation XCWebTableController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.scrollViewContainerView addSubview:self.webView];
    [self.scrollViewContainerView addSubview:self.tableView];
    [self.scrollView addSubview:self.scrollViewContainerView];
    [self.view addSubview:self.scrollView];
    
    NSURL *url = [NSURL URLWithString:@"https://www.jianshu.com/p/5ee6030aeb4f"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [self.webView loadRequest:request];
}

- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    self.scrollViewContainerView.frame = CGRectMake(0, 0, self.view.width, self.view.height * 2);
    self.tableView.y = CGRectGetMaxY(self.scrollView.bounds);
    self.scrollView.contentSize = CGSizeMake(0, self.view.height * 2);
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


#pragma mark - table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"xc_table_cell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"xc_table_cell"];
    }
    cell.textLabel.text = @(indexPath.row).stringValue;
    return cell;
}

#pragma mark - table view delegate

#pragma mark - UIScrollView delegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat offsetY = scrollView.contentOffset.y;

    CGFloat webHeight = self.webView.height;
    CGFloat tabHeight = self.tableView.height;

    CGFloat webContentHeight = self.webView.scrollView.contentSize.height;
    CGFloat tabContentHeight = self.tableView.contentSize.height;

    if (offsetY <= 0) {
        self.scrollViewContainerView.y = 0;
        self.webView.scrollView.contentOffset = self.tableView.contentOffset = CGPointZero;
    }else if (offsetY < webContentHeight - webHeight){
        self.scrollViewContainerView.y = offsetY;
        self.webView.scrollView.contentOffset = CGPointMake(0, offsetY);
        self.tableView.contentOffset = CGPointZero;;
    }else if (offsetY < webContentHeight){
        self.scrollViewContainerView.y = webContentHeight - webHeight;
        self.webView.scrollView.contentOffset = CGPointMake(0, webContentHeight - webHeight);
        self.tableView.contentOffset = CGPointZero;
    }else if (offsetY < webContentHeight + tabContentHeight - tabHeight){
        self.scrollViewContainerView.y = offsetY - webHeight;
        self.webView.scrollView.contentOffset = CGPointMake(0, webContentHeight - webHeight);
        self.tableView.contentOffset = CGPointMake(0, offsetY - webContentHeight);
    }else if (offsetY < webContentHeight + tabContentHeight){
        self.scrollViewContainerView.y = self.scrollView.contentSize.height - self.scrollViewContainerView.height;
        self.webView.scrollView.contentOffset = CGPointMake(0, webContentHeight - webHeight);
        self.tableView.contentOffset = CGPointMake(0, tabContentHeight - tabHeight);
    }else{
        NSLog(@"加载更多.....");
    }

}


#pragma mark - notification Handle

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    CGFloat webContentHeight = self.webView.scrollView.contentSize.height;
    CGFloat tabContentHeight = self.tableView.contentSize.height;
    
    if (webContentHeight == _maxWebContentHeight && tabContentHeight == _maxTabContentHeight) {return;}
    _maxWebContentHeight = webContentHeight;
    _maxTabContentHeight = tabContentHeight;
    self.scrollView.contentSize = CGSizeMake(self.view.width, webContentHeight + tabContentHeight);
    CGFloat webHeight = MIN( webContentHeight, self.view.height)  ;
    CGFloat tableHeight = MIN(tabContentHeight, self.view.height) ;
    self.webView.height = MAX(0.1, webHeight);
    self.scrollViewContainerView.height = webHeight + tableHeight;
    self.tableView.height = tableHeight;
    self.tableView.y = self.webView.bottom;
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
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView = [UIView new];
        _tableView.scrollEnabled = NO;
    }
    return _tableView;
}

@end












