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

@property (nonatomic, strong) dispatch_source_t gcd_timer;

@end

@implementation XCTimerLabelViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    CATextLayer *textLayer = [CATextLayer layer];
    textLayer.bounds = self.timerLabel.bounds;
    textLayer.string = @"123";
    textLayer.backgroundColor = UIColor.redColor.CGColor;
    textLayer.anchorPoint = CGPointZero;
    [self.timerLabel.layer addSublayer:textLayer];
    _textLayer = textLayer;
    

//    _timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(countDownTimer) userInfo:nil repeats:YES];

    _gcd_timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0));

    dispatch_time_t start_time = dispatch_time(DISPATCH_TIME_NOW, 0 *NSEC_PER_SEC);
    dispatch_source_set_timer(_gcd_timer, start_time, 1.0 *NSEC_PER_SEC, 0);

    __weak typeof(self) weakSelf = self;

    dispatch_source_set_event_handler(weakSelf.gcd_timer, ^{

        NSLog(@"gcd timer thread %@",NSThread.currentThread);
         weakSelf.timerCount++;
        dispatch_async(dispatch_get_main_queue(), ^{
            weakSelf.textLayer.string = [NSString stringWithFormat:@"%zd",self.timerCount];
        });
    });
    dispatch_resume(_gcd_timer);
}

- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    dispatch_cancel(self.gcd_timer);
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
