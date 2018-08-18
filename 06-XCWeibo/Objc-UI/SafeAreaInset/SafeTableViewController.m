//
//  SafeTableViewController.m
//  Objc-UI
//
//  Created by Alexcai on 2018/8/18.
//  Copyright © 2018年 Alexcai. All rights reserved.
//

#import "SafeTableViewController.h"
#import <MJRefresh/MJRefresh.h>
#import "SAFrameObj.h"

#define Screen_Height  [UIScreen mainScreen].bounds.size.height
#define IS_IPHONE_X (Screen_Height == 812.0f) ? YES : NO
#define Height_NavBar    (IS_IPHONE_X==YES)?88.0f: 64.0f
#define Height_TabBar    (IS_IPHONE_X==YES)?83.0f: 49.0f

@interface SafeTableViewController ()<UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *sa_tableView;

@end

@implementation SafeTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    self.sa_tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(startRequest)];
    
    self.sa_tableView.mj_footer = [MJRefreshBackStateFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMore)];
    if (@available(iOS 11.0, *)) {
        self.sa_tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
       
    }else{
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    self.sa_tableView.contentInset = UIEdgeInsetsMake(Height_NavBar, 0, Height_TabBar, 0);
    
    
    
    /** 使用对象方式缓存系统的screenBounds的效率要比直接使用多消耗一个对象的创建消耗时间 */
    static const int tc = 10000;
    CFAbsoluteTime beginTime = CFAbsoluteTimeGetCurrent();
    NSLog(@"begin time %f",beginTime);
    for (int i = 0; i < tc; i ++) {
        CGRect a = [UIScreen mainScreen].bounds;
        a.origin.x = 20;
    }
//        for (int i = 0; i < tc; i ++) {
//            CGRect b = [SAFrameObj shareFrame].screenBounds;
//            b.origin.x = 20;
//        }
    CFAbsoluteTime endTime = CFAbsoluteTimeGetCurrent();
     NSLog(@"end time %f",endTime);
    NSLog(@"delta time = %f", endTime - beginTime);
    
}

#pragma mark - Simulate request
- (void)startRequest{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.sa_tableView.mj_header endRefreshing];
    });
}

- (void)loadMore{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.sa_tableView.mj_footer endRefreshingWithNoMoreData];
    });
}

#pragma mark - Table view data source


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 30;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"sa"];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"sa"];
    }
    cell.contentView.backgroundColor = UIColor.orangeColor;
    cell.textLabel.text = @(indexPath.row).stringValue;
    cell.imageView.image = [UIImage imageNamed:@"h7"];
    
    return cell;
}








@end
