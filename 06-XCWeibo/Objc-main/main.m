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
        // insert code here...
        my_test();
        
   
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
    
    Tasklock task = ^{
        if (operaterNumber % 2) {
            NSLog(@"===%@",[NSThread currentThread]);
            [_mArray addObject:@(operaterNumber)];
            operaterNumber += 1;
        }
    };
    Tasklock task1 = ^{
        if (operaterNumber % 2 == 0) {
            NSLog(@"===%@",[NSThread currentThread]);
            [_mArray addObject:@(operaterNumber)];
             operaterNumber += 1;
        }
    };
    
    // 队列中添加异步任务
    
    for (int i = 0; i < 10; i ++) {
        Tasklock execTask = i % 2 ? task : task1;
        dispatch_async(queue, execTask);
    }
    NSLog(@"----------");
    NSLog(@"%@",_mArray);
}
