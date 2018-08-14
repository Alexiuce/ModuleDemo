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
#import "WSServerGameCollectionView.h"

@interface FirstTableViewController ()<UICollectionViewDataSource>
@property (nonatomic, assign) BOOL canScroll;

@property (nonatomic, strong) WSServerGameCollectionView *collectView;

@end

@implementation FirstTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    CGRect collectRect = CGRectMake(0, 0,self.view.bounds.size.width , 50);
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    _collectView = [[WSServerGameCollectionView alloc]initWithFrame:collectRect collectionViewLayout:layout];
    _collectView.dataSource = self;
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

//侧滑允许编辑cell
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}
- (NSArray<UITableViewRowAction *> *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    // 添加一个删除按钮
    UITableViewRowAction *deleteRowAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDestructive title:@"删除"handler:^(UITableViewRowAction *action, NSIndexPath *indexPath) {
        NSLog(@"点击了删除");
    }];
    // 删除一个置顶按钮
    UITableViewRowAction *topRowAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault title:@"置顶"handler:^(UITableViewRowAction *action, NSIndexPath *indexPath) {
        NSLog(@"点击了置顶");
    }];
    topRowAction.backgroundColor = [UIColor blueColor];
    
    // 添加一个更多按钮
    UITableViewRowAction *moreRowAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleNormal title:@"更多"handler:^(UITableViewRowAction *action, NSIndexPath *indexPath) {
        NSLog(@"点击了更多");
        
        
    }];
    moreRowAction.backgroundEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
    
    // 将设置好的按钮放到数组中返回
    return @[deleteRowAction, topRowAction, moreRowAction];
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
