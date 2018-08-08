//
//  WebTableViewController.m
//  Objc-UI
//
//  Created by Alexcai on 2018/8/8.
//  Copyright © 2018年 Alexcai. All rights reserved.
//


#import "WebTableViewController.h"
#import "WebTableViewCell.h"


@interface WebTableViewController ()<UIWebViewDelegate,UIScrollViewDelegate>

@property (nonatomic, strong) UIWebView *webView;

@end

@implementation WebTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.tableHeaderView = self.webView;
    
    NSURL *url = [NSURL URLWithString:@"http://www.baidu.com"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [self.webView loadRequest:request];
    self.webView.frame = CGRectMake(0, 0, 200, 200);
    [self.tableView addSubview:self.webView];
    
}


#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    WebTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"web_cell" forIndexPath:indexPath];

    return cell;
}


#pragma mark - scroll view delegate



#pragma mark - kvo
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    if (![keyPath isEqualToString:@"contentSize"]) {return;}
    CGSize webSize = [self.webView sizeThatFits:CGSizeZero];
    NSLog(@"kvo content size = %@",NSStringFromCGSize(webSize));
//    self.webView.frame = CGRectMake(0, 0, webSize.width, webSize.height);
//    [self.tableView beginUpdates];
//    [self.tableView setTableHeaderView:self.webView];
//    [self.tableView endUpdates];
    
}

#pragma mark - lazy getter


- (UIWebView *)webView{
    if (_webView == nil) {
        _webView = [[UIWebView alloc]init];
        [_webView.scrollView addObserver:self forKeyPath:@"contentSize" options:NSKeyValueObservingOptionNew context:nil];
        
    }
    return _webView;
}


- (void)dealloc{
    [_webView.scrollView removeObserver:self forKeyPath:@"contentSize"];
}
@end
