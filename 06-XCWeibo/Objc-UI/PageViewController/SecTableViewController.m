//
//  SecTableViewController.m
//  Objc-UI
//
//  Created by Alexcai on 2018/7/31.
//  Copyright © 2018年 Alexcai. All rights reserved.
//

#import "SecTableViewController.h"

#import "XCPageViewConfig.h"



@interface SecTableViewController ()

@property (nonatomic, assign) BOOL canScroll;

@end

@implementation SecTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(acceptMsg:) name:PageGoTopNotification object:nil];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 30;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"second"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"second"];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"second row ==%ld",(long)indexPath.row];
    return cell;
    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (!self.canScroll) {
        [scrollView setContentOffset:CGPointZero];
    }
    CGFloat offsetY = scrollView.contentOffset.y;
    if (offsetY < 0) {
        [[NSNotificationCenter defaultCenter] postNotificationName:PageLeaveTopNotification object:nil userInfo:@{@"canScroll":@"1"}];
        self.tableView.contentOffset = CGPointZero;
        self.canScroll = NO;
        self.tableView.showsVerticalScrollIndicator = NO;
    }
}

#pragma mark - notification

-(void)acceptMsg:(NSNotification *)notification {
    NSDictionary *userInfo = notification.userInfo;
    NSString *canScroll = userInfo[@"canScroll"];
    if ([canScroll isEqualToString:@"1"]) {
        self.canScroll = YES;
        self.tableView.showsVerticalScrollIndicator = YES;
    }
}


@end
