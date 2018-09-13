//
//  XCTagViewController.m
//  Objc-UI
//
//  Created by Alexcai on 2018/9/13.
//  Copyright © 2018年 Alexcai. All rights reserved.
//

#import "XCTagViewController.h"
#import "XCTagView.h"

@interface XCTagViewController ()

@end

@implementation XCTagViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    CGRect tagFrame = CGRectMake(0, 100, self.view.bounds.size.width, 100);
    XCTagView *tagView = [[XCTagView alloc]initWithFrame:tagFrame];
    tagView.tagTitles = @[@"王者荣耀",@"QQ (234)",@"LoL (100)",@"王个大者(345345345111)",@"特别农药 (234)",@"各位辛苦农药 (100)",@"王个大者(345345345111)",@"特别农药 (2341)",@"各位辛苦农药 (1009)"];

    [self.view addSubview:tagView];
    tagView.rowHeight = 30;
    tagView.fontSize = 13;

}



@end
