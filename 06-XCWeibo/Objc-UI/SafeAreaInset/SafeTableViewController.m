//
//  SafeTableViewController.m
//  Objc-UI
//
//  Created by Alexcai on 2018/8/18.
//  Copyright © 2018年 Alexcai. All rights reserved.
//

#import "SafeTableViewController.h"

@interface SafeTableViewController ()<UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *sa_tableView;

@end

@implementation SafeTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;

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
    
    return cell;
}








@end
