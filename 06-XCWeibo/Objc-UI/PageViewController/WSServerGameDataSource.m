//
//  WSServerGameDataSource.m
//  Objc-UI
//
//  Created by Alexcai on 2018/8/4.
//  Copyright © 2018年 Alexcai. All rights reserved.
//

#import "WSServerGameDataSource.h"
#import <UIKit/UIKit.h>


@interface WSServerGameDataSource()<UICollectionViewDataSource>



@end

@implementation WSServerGameDataSource


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 10;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"" forIndexPath:indexPath];
    return cell;
}

@end
