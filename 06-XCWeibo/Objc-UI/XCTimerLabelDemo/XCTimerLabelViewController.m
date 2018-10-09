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

@property (nonatomic, assign) NSUInteger timerCount;  // 计时数
@property (nonatomic, weak) CATextLayer *textLayer;

@end

@implementation XCTimerLabelViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.timerLabel.backgroundColor = UIColor.yellowColor;
    
    CATextLayer *textLayer = [CATextLayer layer];
    textLayer.bounds = self.timerLabel.bounds;
    textLayer.string = @"123";
    textLayer.backgroundColor = UIColor.redColor.CGColor;
    textLayer.anchorPoint = CGPointZero;
    [self.timerLabel.layer addSublayer:textLayer];
    _textLayer = textLayer;
    
    
    _timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(countDownTimer) userInfo:nil repeats:YES];
    
}

- (void)countDownTimer{
    NSLog(@"111111");
    self.timerCount++;
    self.textLayer.string = [NSString stringWithFormat:@"%zd",self.timerCount];
}

- (void)dealloc{
    NSLog(@"%s",__FUNCTION__);
}

@end
