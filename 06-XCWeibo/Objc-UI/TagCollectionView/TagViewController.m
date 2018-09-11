//
//  TagViewController.m
//  Objc-UI
//
//  Created by Alexcai on 2018/9/11.
//  Copyright © 2018年 Alexcai. All rights reserved.
//

#import "TagViewController.h"

@interface TagViewController ()<UICollectionViewDataSource,UICollectionViewDelegate>

@end

@implementation TagViewController

- (void)viewDidLoad {
    [super viewDidLoad];

}



#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 10;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"tagCell" forIndexPath:indexPath];
    
    return cell;
}

@end
