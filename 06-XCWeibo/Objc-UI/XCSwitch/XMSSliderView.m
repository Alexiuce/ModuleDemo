//
//  XMSSliderView.m
//  Objc-UI
//
//  Created by Alexcai on 2018/8/16.
//  Copyright © 2018年 Alexcai. All rights reserved.
//

#import "XMSSliderView.h"



@interface XMSSliderView()
    
    
    @property (weak, nonatomic) IBOutlet UIButton *leftButton;
    
    @property (weak, nonatomic) IBOutlet UIButton *rightButton;
    
@end


@implementation XMSSliderView
    
+ (instancetype)sliderView{
    
    return [[NSBundle mainBundle] loadNibNamed:@"XMSSliderView" owner:nil options:nil].firstObject;
}

- (void)awakeFromNib{
    [super awakeFromNib];
    
}

@end
