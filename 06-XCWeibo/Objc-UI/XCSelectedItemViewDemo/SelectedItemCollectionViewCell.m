//
//  SelectedItemCollectionViewCell.m
//  Objc-UI
//
//  Created by Alexcai on 2018/10/17.
//  Copyright © 2018 Alexcai. All rights reserved.
//

#import "SelectedItemCollectionViewCell.h"

@implementation SelectedItemCollectionViewCell



- (void)setSelected:(BOOL)selected{
    [super setSelected:selected];
    if (selected) {
       self.nameLabel.textColor = UIColor.redColor;
    }else{
        self.nameLabel.textColor = UIColor.blackColor;
    }
}

@end
