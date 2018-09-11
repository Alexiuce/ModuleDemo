//
//  TagCollectionViewCell.m
//  Objc-UI
//
//  Created by Alexcai on 2018/9/11.
//  Copyright © 2018年 Alexcai. All rights reserved.
//

#import "TagCollectionViewCell.h"

@interface TagCollectionViewCell()


@end


@implementation TagCollectionViewCell


- (void)setSelected:(BOOL)selected{
    [super setSelected:selected];
    NSLog(@"%@",selected ? @"Selected":@"Deselected");
    self.customLabel.backgroundColor = selected ? UIColor.whiteColor : UIColor.yellowColor;
}

@end
