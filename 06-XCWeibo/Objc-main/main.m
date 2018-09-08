//
//  main.m
//  Objc-main
//
//  Created by Alexcai on 2018/8/19.
//  Copyright © 2018年 Alexcai. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XCFileManager.h"


int my_sum(int a,int b);
void my_test(void);
void my_float_4to5(void *);

typedef void(^Tasklock)(void);

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        
        XCFileManager *m = [XCFileManager shareManager];
        [m listAllFilesInPath:@"/Users/Alexcai/GitApp/ModuleDemo/06-XCWeibo" fileType:DOT_H | DOT_M];
        
    }
    return 0;
}


void decimalExample(){
    NSDecimalNumberHandler *handle = [NSDecimalNumberHandler decimalNumberHandlerWithRoundingMode:NSRoundPlain scale:2 raiseOnExactness:NO raiseOnOverflow:NO raiseOnUnderflow:NO raiseOnDivideByZero:YES];
    
    NSDecimalNumber *dn = [[NSDecimalNumber alloc]initWithFloat:12.451632];
    NSDecimalNumber *result = [dn decimalNumberByRoundingAccordingToBehavior:handle];
    NSLog(@"%f",result.floatValue);
    
    NSLocale *lo = [NSLocale currentLocale];
    NSDecimal d = result.decimalValue;
    NSLog(@"%@",NSDecimalString(&d, lo));
    
}

void suspendDemo(){
    dispatch_queue_t q1 = dispatch_queue_create("queue_one", DISPATCH_QUEUE_SERIAL);
    
    dispatch_async(q1, ^{
        NSLog(@"start q1");
    });
    dispatch_suspend(q1);
    
    for (int i = 0; i < 5; i++) {
        NSLog(@"%@", [NSString stringWithFormat:@"%d",i]);
    }
    dispatch_resume(q1);
    NSLog(@"end ");
}

void dispatchFunc(){
    dispatch_queue_t q1 = dispatch_queue_create("queue_one", DISPATCH_QUEUE_SERIAL);
    dispatch_async_f(q1, @"good morning", my_float_4to5);
}

void my_float_4to5(void * s){
    NSLog(@"param -- %@",s);
    float f = 12.343434;
    float f1 = floorf(f * 100 + 0.5 ) / 100;
    NSLog(@"%.2f",f1);
}

void gcd_queue_suspend(){
    dispatch_queue_t q1 = dispatch_queue_create("queue_one", DISPATCH_QUEUE_SERIAL);
    dispatch_queue_t q2 = dispatch_queue_create("queue_two", DISPATCH_QUEUE_SERIAL);
    dispatch_async(q1, ^{
        NSLog(@"task 1...");
    });
    dispatch_async(q2, ^{
        NSLog(@"task 2...");
    });

    NSLog(@"end");
    
}

void gcd_test(){
    dispatch_queue_t q1 = dispatch_queue_create("queue_one", DISPATCH_QUEUE_SERIAL);
    dispatch_queue_t q2 = dispatch_queue_create("queue_two", DISPATCH_QUEUE_SERIAL);
    
    dispatch_semaphore_t semap = dispatch_semaphore_create(1);
    dispatch_semaphore_t semap1 = dispatch_semaphore_create(0);
    
    for (int i = 0; i < 101; i++) {
        if (i % 2 ) {
            dispatch_async(q1, ^{
                dispatch_semaphore_wait(semap, DISPATCH_TIME_FOREVER);
                NSLog(@"one %d",i);
                
                dispatch_semaphore_signal(semap);
                if (i == 100) {
                    dispatch_semaphore_signal(semap1);
                }
            });
            
        }else{
            dispatch_async(q2, ^{
                dispatch_semaphore_wait(semap, DISPATCH_TIME_FOREVER);
                NSLog(@"two %d",i);
                
                dispatch_semaphore_signal(semap);
                if (i == 100) {
                    dispatch_semaphore_signal(semap1);
                }
            });
            
        }
        
    }
    
    dispatch_semaphore_wait(semap1, DISPATCH_TIME_FOREVER);
    NSLog(@"end");
    dispatch_semaphore_signal(semap1);
}

int my_sum(int a,int b){
    return  a + b;
}

void my_test(){
    NSMutableArray *_mArray = [NSMutableArray array];
    
    __block int operaterNumber = 0;
    
    // 串行队列
    dispatch_queue_t queue =  dispatch_queue_create("threand-one",DISPATCH_QUEUE_SERIAL);
    
   
    
    // 队列中添加异步任务
    
    for (int i = 0; i < 10; i ++) {
        
        Tasklock task = ^{
            if (operaterNumber % 2) {
                NSLog(@"00000%@perator number %d",[NSThread currentThread],operaterNumber);
                [_mArray addObject:@(operaterNumber)];
                operaterNumber += 1;
            }
        };
        Tasklock task1 = ^{
            if (operaterNumber % 2 == 0) {
                NSLog(@"1111%@ perator number %d",[NSThread currentThread],operaterNumber);
                [_mArray addObject:@(operaterNumber)];
                operaterNumber += 1;
            }
        };
        
        Tasklock execTask = i % 2 ? task : task1;
        NSLog(@"for ....");
        dispatch_async(queue, execTask);
    }
 
    dispatch_sync(queue, ^{
        NSLog(@"----------");
        NSLog(@"%zd",_mArray.count);
        for (NSNumber *number in _mArray) {
            NSLog(@"%d", number.intValue);
        }
        
    });
}
