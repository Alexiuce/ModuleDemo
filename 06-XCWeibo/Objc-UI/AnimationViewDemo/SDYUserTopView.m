//
//  SDYUserTopView.m
//  Objc-UI
//
//  Created by Alexcai on 2018/8/12.
//  Copyright © 2018年 Alexcai. All rights reserved.
//

#import "SDYUserTopView.h"

@interface SDYUserTopView()
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *detailLabel;
@property (weak, nonatomic) IBOutlet UIImageView *sexImageView;

@property (weak, nonatomic) IBOutlet UIButton *followButton;

@end


@implementation SDYUserTopView


- (void)awakeFromNib{
    [super awakeFromNib];
    self.nameLabel.text = @"";
    self.detailLabel.text = @"";
   
}


@end
