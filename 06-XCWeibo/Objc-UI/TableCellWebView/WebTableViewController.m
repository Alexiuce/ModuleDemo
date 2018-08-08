//
//  WebTableViewController.m
//  Objc-UI
//
//  Created by Alexcai on 2018/8/8.
//  Copyright © 2018年 Alexcai. All rights reserved.
//


#import "WebTableViewController.h"
#import "WebTableViewCell.h"


@interface WebTableViewController ()

@end

@implementation WebTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.rowHeight = 200;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    WebTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"web_cell" forIndexPath:indexPath];
    

    
    return cell;
}

@end
