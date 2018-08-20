//
//  XCSearchViewController.m
//  Objc-UI
//
//  Created by Alexcai on 2018/8/20.
//  Copyright © 2018年 Alexcai. All rights reserved.
//

#import "XCSearchViewController.h"

@interface XCSearchViewController ()

@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;

@end

@implementation XCSearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.searchBar setImage:[UIImage imageNamed:@"icon_search1"] forSearchBarIcon:UISearchBarIconSearch state:UIControlStateNormal];
    
    
    
}


@end
