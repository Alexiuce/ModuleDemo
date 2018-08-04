//
//  FirstTableViewController.m
//  Objc-UI
//
//  Created by Alexcai on 2018/7/31.
//  Copyright © 2018年 Alexcai. All rights reserved.
//

#import "FirstTableViewController.h"
#import "WSServerGameCell.h"
#import "XCPageViewConfig.h"

@interface FirstTableViewController ()<UICollectionViewDataSource>
@property (nonatomic, assign) BOOL canScroll;

@property (nonatomic, strong) UICollectionView *collectView;

@end

@implementation FirstTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    CGRect collectRect = CGRectMake(0, 0,self.view.bounds.size.width , 60);
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    layout.itemSize = CGSizeMake(60, 20);
    layout.minimumLineSpacing = 15;
    layout.minimumInteritemSpacing = 10;
    _collectView = [[UICollectionView alloc]initWithFrame:collectRect collectionViewLayout:layout];
    _collectView.dataSource = self;
    _collectView.scrollEnabled = NO;
    _collectView.backgroundColor = UIColor.whiteColor;
    _collectView.contentInset = UIEdgeInsetsMake(15, 15, 0, 15);
    
    [_collectView registerNib:[UINib nibWithNibName:@"WSServerGameCell" bundle:nil] forCellWithReuseIdentifier:@"ws_server_game"];
    
    self.tableView.tableHeaderView = _collectView;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(acceptMsg:) name:PageGoTopNotification object:nil];
}


#pragma mark - Collection View data source

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 10;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    WSServerGameCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ws_server_game" forIndexPath:indexPath];
    
    
    return cell;
}


#pragma mark - Table view data source



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 30;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"first"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"first"];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"first row ==%ld",(long)indexPath.row];
    return cell;
    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (!self.canScroll) {  // 1. 选择没有到顶时,不移动内容
        [scrollView setContentOffset:CGPointZero];
    }
    if (scrollView.contentOffset.y < 0) { // 2. 如果内容从开始位置向下拉,通知容器视图,
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
