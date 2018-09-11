//
//  TagViewController.m
//  Objc-UI
//
//  Created by Alexcai on 2018/9/11.
//  Copyright © 2018年 Alexcai. All rights reserved.
//

#import "TagViewController.h"
#import "TagCollectionViewCell.h"

@interface TagViewController ()<UICollectionViewDataSource,UICollectionViewDelegate>

@property (nonatomic, strong) NSArray  <NSString *>*titles;

@end

@implementation TagViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _titles = @[@"王者荣耀",@"QQ (234)",@"LoL (100)",@"王个大者(111)",@"特别农药 (234)",@"各位辛苦农药 (100)"];
}



#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return _titles.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    TagCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"tagCell" forIndexPath:indexPath];
    cell.customLabel.text = _titles[indexPath.item];
    return cell;
}

#pragma mark - UICollectionViewDelegate


- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    NSString * containString = _titles[indexPath.item];
    CGFloat width = [self getWidthWithText:containString height:30 font:13];
    return CGSizeMake( width +25, 30.0f);

}



- (CGFloat)getWidthWithText:(NSString *)text height:(CGFloat)height font:(CGFloat)font{
    //加上判断，防止传nil等不符合的值，导致程序奔溃
    if (text == nil || [text isEqualToString:@""]){
        text = @"无";
    }
    if (font <= 0){
        font = 13;
    }
    if (height < 0){
        height = 0;
    }
    CGRect rect = [text boundingRectWithSize:CGSizeMake(MAXFLOAT, height)
                                     options:NSStringDrawingUsesLineFragmentOrigin
                                  attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:font]}
                                     context:nil];
    return rect.size.width;
    
}


@end
