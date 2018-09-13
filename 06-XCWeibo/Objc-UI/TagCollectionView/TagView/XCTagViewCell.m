//
//  XCTagViewCell.m
//  Objc-UI
//
//  Created by Alexcai on 2018/9/13.
//  Copyright © 2018年 Alexcai. All rights reserved.
//

#import "XCTagViewCell.h"

@implementation XCTagViewCell

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self.contentView addSubview:self.textLabel];
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    self.textLabel.frame = self.contentView.bounds;
}



#pragma mark - lazy getter

- (UILabel *)textLabel{
    if (_textLabel == nil) {
        _textLabel = [[UILabel alloc]init];
    }
    return _textLabel;
}

@end
