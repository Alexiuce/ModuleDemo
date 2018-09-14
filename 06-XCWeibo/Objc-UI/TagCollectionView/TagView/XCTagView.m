//
//  XCTagView.m
//  Objc-UI
//
//  Created by Alexcai on 2018/9/13.
//  Copyright © 2018年 Alexcai. All rights reserved.
//

#import "XCTagView.h"
#import "XCTagViewFlowLayout.h"
#import "XCTagViewCell.h"


static NSString *const ReusedKey = @"XC_TAG_CELL";

@interface XCTagView()<
UICollectionViewDataSource,
UICollectionViewDelegate,
UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) XCTagViewFlowLayout *flowLayout;

@property (nonatomic, strong) NSMutableArray <NSNumber *>*cellWidths; // 保存每个cell 的宽度;


@end

@implementation XCTagView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self addSubview:self.collectionView];
        self.backgroundColor = UIColor.whiteColor;
        self.collectionView.backgroundColor = UIColor.whiteColor;
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

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    XCTagViewCell *tagCell = [collectionView dequeueReusableCellWithReuseIdentifier:ReusedKey forIndexPath:indexPath];
    
    tagCell.textLabel.text = self.tagTitles[indexPath.item];
    tagCell.textLabel.font = [UIFont systemFontOfSize:self.fontSize];
    return tagCell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(self.cellWidths[indexPath.item].floatValue + 20, self.rowHeight);
}

#pragma mark privated method

- (CGFloat)getWidthWithText:(NSString *)text height:(CGFloat)height font:(CGFloat)font{
    //加上判断，防止传nil等不符合的值，导致程序奔溃
    if (text == nil || [text isEqualToString:@""]){
        return 0.0f;
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

- (void)setupViewHeight{
    // 计算自身的视图高度
    __block CGFloat caclWith = 0;
    __block int row = 1;  // 默认行数;
    [self.cellWidths enumerateObjectsUsingBlock:^(NSNumber * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        caclWith += obj.floatValue + self.tagMargin;
        if (caclWith > self.maxRowWidth) {
            row ++;
            caclWith = obj.floatValue;
        }
    }];
   
    NSLog(@"%d",row);
    CGFloat height = (row * self.rowHeight) + (row - 1) * self.rowMargin;
    self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, height);
    [self.collectionView reloadData];
}

#pragma mark - setter method

- (void)setTagTitles:(NSArray<NSString *> *)tagTitles{
    _tagTitles = tagTitles;
    // 计算每个item 宽度,保存到数组中
    _cellWidths = [NSMutableArray arrayWithCapacity:tagTitles.count];
    [tagTitles enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        CGFloat width = [self getWidthWithText:obj height:self.rowHeight font:self.fontSize];
        [self.cellWidths addObject:@(width)];
    }];
    
    [self setupViewHeight];
}

- (void)setFontSize:(CGFloat)fontSize{
    _fontSize = fontSize;
    [self setupViewHeight];
}
- (void)setRowHeight:(CGFloat)rowHeight{
    _rowHeight = rowHeight;
    [self setupViewHeight];
}
- (void)setTagMargin:(CGFloat)tagMargin{
    _tagMargin = tagMargin;
    self.flowLayout.minimumInteritemSpacing = tagMargin;
     [self setupViewHeight];
}

#pragma mark - lazy getter

- (UICollectionView *)collectionView{
    if (_collectionView == nil) {
        self.flowLayout = [[XCTagViewFlowLayout alloc]init];
        self.flowLayout.minimumLineSpacing = 0;
        _collectionView = [[UICollectionView alloc]initWithFrame:self.bounds collectionViewLayout:self.flowLayout];
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        [_collectionView registerClass:[XCTagViewCell class] forCellWithReuseIdentifier:ReusedKey];
        _collectionView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
    }
    return _collectionView;
}
- (CGFloat)maxRowWidth{
    if (_maxRowWidth == 0) {
        _maxRowWidth = [UIScreen mainScreen].bounds.size.width;
    }
    return _maxRowWidth;
}

@end
