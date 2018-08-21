//
//  XCSearchTableViewController.m
//  Objc-UI
//
//  Created by Alexcai on 2018/8/20.
//  Copyright © 2018年 Alexcai. All rights reserved.
//

#import "XCSearchTableViewController.h"
#import "UIView+ACMediaExt.h"

@interface XCSearchTableViewController ()<UISearchBarDelegate>

@end

@implementation XCSearchTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UISearchBar *searchBar = [[UISearchBar alloc]initWithFrame:CGRectMake(0, 0, self.view.width, 56)];
    searchBar.delegate = self;
    [searchBar setImage:[UIImage imageNamed:@"icon_search1"] forSearchBarIcon:UISearchBarIconSearch state:UIControlStateNormal];
    [searchBar setBackgroundImage:[UIImage imageNamed:@"searchBg"]];
   
    searchBar.barTintColor = [UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1];
    self.tableView.tableHeaderView = searchBar;

    [self filterArray];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 30;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"search_xc"];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"search_xc"];
    }
    
    cell.textLabel.text = @(indexPath.row).stringValue;
    return cell;
}

#pragma mark - UISearch bar delegate
- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar{
    [searchBar setShowsCancelButton:YES animated:YES];
    return YES;
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar{
    [searchBar setShowsCancelButton:NO animated:YES];
}


#pragma mark - Custom method
- (void)filterArray{
    NSArray *allInfos = @[@{@"sort":@"1",@"price":@"1.24",@"name":@"wzry"},
                          @{@"sort":@"2",@"price":@"1.35",@"subDict":@{@"name":@"sub-name"}},
                          @{@"sort":@"3",@"price":@"1.26"},
                          @{@"sort":@"4",@"price":@"1.77"},
                          @{@"sort":@"5",@"price":@"1.28"},
                          @{@"sort":@"6",@"price":@"1.89"},
                          @{@"sort":@"7",@"price":@"1.20"},
                          ];
    
    
    
    
//    NSArray *sorts = [allInfos valueForKeyPath:@"name"];
    // 排序
    NSSortDescriptor *sort = [NSSortDescriptor sortDescriptorWithKey:@"price" ascending:YES];
    NSArray *sorts = [allInfos sortedArrayUsingDescriptors:@[sort]];
    NSLog(@"%@",sorts);
}

@end
