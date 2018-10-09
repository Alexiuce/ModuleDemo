//
//  XCTimerLabelViewController.m
//  Objc-UI
//
//  Created by Alexcai on 2018/10/9.
//  Copyright © 2018 Alexcai. All rights reserved.
//

#import "XCTimerLabelViewController.h"

@interface XCTimerLabelViewController ()
@property (weak, nonatomic) IBOutlet UILabel *timerLabel;

@property (nonatomic, strong) NSTimer *timer;  // 定时器

@end

@implementation XCTimerLabelViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(countDownTimer) userInfo:nil repeats:YES];
    
    // Do any additional setup after loading the view.
}

- (void)countDownTimer{
    NSLog(@"111111");
}

- (void)dealloc{
    NSLog(@"%s",__FUNCTION__);
}

@end
