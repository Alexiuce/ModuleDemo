//
//  MoveCollectionViewController.m
//  Objc-UI
//
//  Created by Alexcai on 2018/9/11.
//  Copyright © 2018年 Alexcai. All rights reserved.
//

#import "MoveCollectionViewController.h"
#import "MoveCollectionViewCell.h"


#define RandomColor  [UIColor colorWithRed:arc4random_uniform(255) / 255.0 green:arc4random_uniform(255) / 255.0 blue:arc4random_uniform(255) / 255.0 alpha:1]

@interface MoveCollectionViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@property (nonatomic, strong) NSMutableArray <NSNumber *>*cellDatas;

@property (nonatomic, weak) UICollectionViewCell *currentMoveCell;

@end

@implementation MoveCollectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
  
    _cellDatas = [@[@1,@2,@3,@4,@5,@6,@7,@8,@9,@10,@11,@12,@13,@14,@15] mutableCopy];
    
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(handleLongPressGesture:)];
    [self.collectionView addGestureRecognizer:longPress];
    
}

#pragma mark - Custom Methon
- (void)handleLongPressGesture:(UILongPressGestureRecognizer *)gesture{
    switch (gesture.state) {
        case UIGestureRecognizerStateBegan:{
            NSIndexPath *indexPath = [self.collectionView indexPathForItemAtPoint:[gesture locationInView:self.collectionView]];
            if (indexPath == nil) {
                break;
            }
            _currentMoveCell = [self.collectionView cellForItemAtIndexPath:indexPath];
            _currentMoveCell.transform = CGAffineTransformMakeScale(1.2, 1.2);
            [self.collectionView beginInteractiveMovementForItemAtIndexPath:indexPath];
            
            break;
        }
        case UIGestureRecognizerStateChanged:{
            [self.collectionView updateInteractiveMovementTargetPosition:[gesture locationInView:self.collectionView]];
            break;
        }
        case UIGestureRecognizerStateEnded:{
            
            [self.collectionView endInteractiveMovement];
            _currentMoveCell.transform = CGAffineTransformIdentity;
            break;
        }
            
        default:
            [self.collectionView cancelInteractiveMovement];
            _currentMoveCell.transform = CGAffineTransformIdentity;
            break;
    }
}


#pragma mark - UICollectionViewDelegate,UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return  _cellDatas.count;
}


- (nonnull __kindof UICollectionViewCell *)collectionView:(nonnull UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    MoveCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"moveCell" forIndexPath:indexPath];
    
    cell.backgroundColor = RandomColor;
   
    cell.textLabel.text =  _cellDatas[indexPath.item].stringValue;
    
    return cell;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canMoveItemAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}

- (void)collectionView:(UICollectionView *)collectionView moveItemAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath{
    [self.cellDatas exchangeObjectAtIndex:sourceIndexPath.item withObjectAtIndex:destinationIndexPath.item];
}


@end
