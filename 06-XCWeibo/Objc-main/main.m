//
//  main.m
//  Objc-main
//
//  Created by Alexcai on 2018/8/19.
//  Copyright © 2018年 Alexcai. All rights reserved.
//

#import <Foundation/Foundation.h>



int my_sum(int a,int b);
void my_test(void);

typedef void(^Tasklock)(void);

int main(int argc, const char * argv[]) {
    @autoreleasepool {
       
 
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
    return 0;
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
