//
//  WSServerGameCollectionView.m
//  Objc-UI
//
//  Created by Alexcai on 2018/8/4.
//  Copyright © 2018年 Alexcai. All rights reserved.
//

#import "WSServerGameCollectionView.h"

@implementation WSServerGameCollectionView

- (instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout{
    if (self = [super initWithFrame:frame collectionViewLayout:layout]) {
        UICollectionViewFlowLayout *flow = (UICollectionViewFlowLayout *)layout;
        flow.itemSize = CGSizeMake(60, 20);
        flow.minimumLineSpacing = 15;
        flow.minimumInteritemSpacing = 10;
        self.scrollEnabled = NO;
        self.backgroundColor = UIColor.whiteColor;
        self.contentInset = UIEdgeInsetsMake(15, 15, 0, 15);
    }
    return self;
}

@end
