//
//  XCSwitchDemoController.m
//  Objc-UI
//
//  Created by Alexcai on 2018/8/16.
//  Copyright © 2018年 Alexcai. All rights reserved.
//

#import "XCSwitchDemoController.h"

#import "XMSSliderView.h"

@interface XCSwitchDemoController ()

@end

@implementation XCSwitchDemoController

- (void)viewDidLoad {
    [super viewDidLoad];
    
   
    
    XMSSliderView *slider = [XMSSliderView sliderView];
    slider.frame = CGRectMake(100, 100, 100, 30);
    [self.view addSubview:slider];
    slider.layer.cornerRadius = 15.0f;
    
}



@end
