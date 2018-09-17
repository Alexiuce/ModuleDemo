//
//  TagViewController.m
//  Objc-UI
//
//  Created by Alexcai on 2018/9/11.
//  Copyright © 2018年 Alexcai. All rights reserved.
//

#import "TagViewController.h"
#import "TagCollectionViewCell.h"
#import "MYFlowLayout.h"

@interface TagViewController ()<UICollectionViewDataSource,UICollectionViewDelegate>

@property (nonatomic, strong) NSArray  <NSString *>*titles;

@property (nonatomic, strong) NSArray <NSNumber *>*titlesWidths;

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@property (nonatomic, strong) MYFlowLayout *flowLayout;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *collectionViewHeight;

@end

@implementation TagViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _titles = @[@"王者荣耀",@"QQ (234)",@"LoL (100)",@"王个大者(345345345111)",@"特别农药 (234)",@"各位辛苦农药 (100)",@"王个大者(345345345111)",@"特别农药 (2341)",@"各位辛苦农药 (1009)"];
    
    self.collectionView.collectionViewLayout = self.flowLayout;
    
    __block CGFloat caclWith = 0;
    __block int row = 1;  // 默认行数;
    [self.titlesWidths enumerateObjectsUsingBlock:^(NSNumber * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        caclWith += obj.floatValue + 25;
        if (caclWith > [UIScreen mainScreen].bounds.size.width) {
            row ++;
            caclWith = obj.floatValue;
        }
    }];
    
    self.collectionViewHeight.constant = (row * 30) + (row - 1) * 10;
    
}

#pragma mark - Notification handle
- (void)handleReadFileNotification:(NSNotification *)noti{
    NSLog(@"%@",NSThread.currentThread);
    NSData *fileData = noti.userInfo[NSFileHandleNotificationDataItem];
    NSString *fileText = [[NSString alloc]initWithData:fileData encoding:NSUTF8StringEncoding];
    NSLog(@"%@",fileText);
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
   
    return CGSizeMake( self.titlesWidths[indexPath.item].floatValue + 25, 30.0f);

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


#pragma mark - lazy getter method

- (NSArray <NSNumber *>*)titlesWidths{
    
    NSMutableArray *titleWidths = [NSMutableArray arrayWithCapacity:10];
    if (_titlesWidths == nil) {
        [_titles enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            CGFloat width = [self getWidthWithText:obj height:30 font:13];
            [titleWidths addObject:@(width)];
        }];
        
    }
    return [titleWidths copy];
}

- (MYFlowLayout *)flowLayout{
    if (_flowLayout == nil) {
        _flowLayout = [[MYFlowLayout alloc]init];
    }
    return _flowLayout;
}

@end
