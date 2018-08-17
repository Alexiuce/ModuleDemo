//
//  XCSwitchDemoController.m
//  Objc-UI
//
//  Created by Alexcai on 2018/8/16.
//  Copyright © 2018年 Alexcai. All rights reserved.
//

#import "XCSwitchDemoController.h"

#import "XMSSliderView.h"

@interface XCSwitchDemoController ()<XMSSliderViewDelegate>

@property (nonatomic, weak) XMSSliderView *sliderView;

@end

@implementation XCSwitchDemoController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    XMSSliderView *slider = [XMSSliderView sliderView];
    slider.frame = CGRectMake(100, 100, 100, 30);
    [self.view addSubview:slider];
    slider.layer.cornerRadius = 15.0f;
    slider.select_delegate = self;
    _sliderView = slider;
    
   
    
}

- (void)sliderView:(XMSSliderView *)view didSelectedAtIndex:(NSUInteger)index{
    NSLog(@"%lu",(unsigned long)index);
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
  
    static int index = 0;
    
    self.sliderView.currentSelectedIndex = (++index) % 2;
}
@end
