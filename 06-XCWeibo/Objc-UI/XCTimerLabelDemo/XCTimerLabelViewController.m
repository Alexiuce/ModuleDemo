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

@property (nonatomic, strong) dispatch_source_t gcdTimer;

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
            weakSelf.textLayer.string = [NSString stringWithFormat:@"%zd",weakSelf.timerCount];
        });
    });
    dispatch_resume(_gcd_timer);
    
    //1.队列
//    dispatch_queue_t queue = dispatch_get_global_queue(0, 0);
//    //2.创建定时器
//    self.gcdTimer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
//    //3.设置时间
//    // start 秒后开始执行
//    uint64_t start = 2.0;
//    // 每隔interval执行
//    uint64_t interval = 1.0;
//
//    dispatch_source_set_timer(self.gcdTimer, dispatch_time(DISPATCH_TIME_NOW, start * NSEC_PER_SEC), interval * NSEC_PER_SEC, 0);
//
//    //4.设置回调
//    __weak typeof(self)weakSelf = self;
//    dispatch_source_set_event_handler(self.gcdTimer, ^{
//        weakSelf.timerCount++;
//        dispatch_async(dispatch_get_main_queue(), ^{
//            [weakSelf countDownTimer];
//        });
//    });
//    //5.启动定时器
//    dispatch_resume(self.gcdTimer);
    
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
