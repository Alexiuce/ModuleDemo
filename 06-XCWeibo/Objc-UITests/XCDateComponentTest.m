//
//  XCDateComponentTest.m
//  Objc-UITests
//
//  Created by Alexcai on 2018/10/10.
//  Copyright © 2018 Alexcai. All rights reserved.
//

#import <XCTest/XCTest.h>


#define onExit __strong void(^block)(void) __attribute__((cleanup(blockCleanUp), unused)) = ^


@interface XCDateComponentTest : XCTestCase

@property (nonatomic, strong)NSArray <NSString *>*allDateInfo;

@end

@implementation XCDateComponentTest

// void(^block)(void)的指针是void(^*block)(void)
static void blockCleanUp(__strong void(^*block)(void)) {
    (*block)();
}


- (void)setUp {
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    for (NSString *dayText in self.allDateInfo) {
        NSLog(@"%@",dayText);
    }
}

- (void)testExample {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
    int a = 0;

    void (^MyBlock)(void) = ^{
        NSLog(@"this is my block code");
    };
    
    onExit{
        NSLog(@"hello exit");
    };
    a++;
    NSLog(@"a = %d",a);
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        [self dateInCalendar];
    }];
}

- (void)testPerformanceDateFormat{
    [self measureBlock:^{
        [self dateFromFormat];
    }];
}


- (void)dateInCalendar{
    NSDate *date = [NSDate date];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSCalendarUnit dateFlag = NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute;
    NSMutableArray <NSString *>*result = [NSMutableArray array];
    for (int i = 1; i< 8 ; i++) {
        NSDate *afterDate = [[NSDate alloc] initWithTimeInterval:i *24 * 60 *60 sinceDate:date];
        NSDateComponents *dateComponents =  [calendar components:dateFlag fromDate:afterDate];
        NSString *dateString = [NSString stringWithFormat:@"%zd月%zd日",dateComponents.month,dateComponents.day];
        [result addObject:dateString];
    }
    self.allDateInfo = [result copy];
}

- (void)dateFromFormat{
    NSDate *date = [NSDate date];
    NSDateFormatter *dateFormater = [[NSDateFormatter alloc]init];
    dateFormater.dateFormat = @"MM月-dd日";
    NSMutableArray <NSString *>*result = [NSMutableArray array];
    for (int i = 1; i < 8; i++) {
         NSDate *afterDate = [[NSDate alloc] initWithTimeInterval:i *24 * 60 *60 sinceDate:date];
         NSString *dateString = [dateFormater stringFromDate:afterDate];
        [result addObject:dateString];
    }
    self.allDateInfo = [result copy];
}

@end
