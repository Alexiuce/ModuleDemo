//
//  XCDataModelViewController.m
//  ObjcUI
//
//  Created by Alexcai on 2018/10/29.
//  Copyright © 2018 dongjiu. All rights reserved.
//

#import "XCDataModelViewController.h"
#import "XCDataModelManager.h"
#import "XCDataModel.h"
#import "XCOriginDataModel.h"


@interface XCDataModelViewController ()

@end

@implementation XCDataModelViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    NSArray *data = @[@{@"name":@"Jobs",@"gameName":@"KingOfWin",@"age":@(20)},
                    @{@"name":@"Alex",@"gameName":@"Flight",@"age":@(21)},
                    @{@"name":@"Gates",@"gameName":@"King",@"age":@(22)}
                      ];
    
    NSArray *models = [XCDataModelManager modelsWithJsonAarray:data classInArray:XCDataModel.class];
    NSLog(@"%@",models);
    
    
    NSDictionary *param = @{@"name":@"Hello",@"game":@"world",@"age": @(18)};
    
    XCDataModel *m = [XCDataModelManager modelWithJson:param modelClass:XCDataModel.class];
    NSLog(@"name =%@ , game = %@ , age = %d",m.name,m.game,m.age);
    
    
    XCOriginDataModel *mo = [XCOriginDataModel modelWithJson:param];
    NSArray *mos = [XCOriginDataModel modelsWithJsonArray:data];
    NSLog(@"%@",mos);
    NSLog(@"name =%@ , game = %@ , age = %d",mo.name,mo.game,mo.age);
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
