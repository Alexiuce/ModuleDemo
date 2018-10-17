//
//  XCSelectedItemViewController.m
//  Objc-UI
//
//  Created by Alexcai on 2018/10/17.
//  Copyright © 2018 Alexcai. All rights reserved.
//

#import "XCSelectedItemViewController.h"

@interface XCSelectedItemViewController ()<UICollectionViewDataSource>
@property (strong, nonatomic) IBOutlet UIView *containerView;

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@property (nonatomic, strong)NSArray *dataArray;

@end

@implementation XCSelectedItemViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   _dataArray =   @[@"Alex",@"Good",@"Google",@"Safari"];
    
}


#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return _dataArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewCell *cell =  [collectionView dequeueReusableCellWithReuseIdentifier:@"item_collection" forIndexPath:indexPath];
    
    return cell;
}

@end
