//
//  XCTagView.m
//  Objc-UI
//
//  Created by Alexcai on 2018/9/13.
//  Copyright © 2018年 Alexcai. All rights reserved.
//

#import "XCTagView.h"
#import "XCTagViewFlowLayout.h"

@interface XCTagView()<UICollectionViewDataSource,UICollectionViewDelegate>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) XCTagViewFlowLayout *flowLayout;


@end

@implementation XCTagView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self addSubview:self.collectionView];
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    self.collectionView.frame = self.bounds;
}


#pragma mark - UICollectionView data source
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.tagTitles.count;
}







#pragma mark - lazy getter

- (UICollectionView *)collectionView{
    if (_collectionView == nil) {
        self.flowLayout = [[XCTagViewFlowLayout alloc]init];
        _collectionView = [[UICollectionView alloc]initWithFrame:self.bounds collectionViewLayout:self.flowLayout];
    }
    return _collectionView;
}
@end
