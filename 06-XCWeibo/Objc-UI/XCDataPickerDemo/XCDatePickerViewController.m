//
//  XCDatePickerViewController.m
//  Objc-UI
//
//  Created by Alexcai on 2018/10/9.
//  Copyright © 2018 Alexcai. All rights reserved.
//

#import "XCDatePickerViewController.h"

@interface XCDatePickerViewController ()
@property (weak, nonatomic) IBOutlet UIDatePicker *datePickerView;

@end

@implementation XCDatePickerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    NSDate *date = [NSDate date];
    NSDate *after7date = [[NSDate alloc] initWithTimeInterval:7 *24 * 60 *60 sinceDate:date];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSCalendarUnit dateFlag = NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute;
    
    NSDateComponents *dateComponents =  [calendar components:dateFlag fromDate:date];
    
    NSLog(@"%zd,%zd: %zd-%zd",dateComponents.month,dateComponents.day,dateComponents.hour,dateComponents.minute);
    NSDateComponents *after7dateComponents = [calendar components:dateFlag fromDate:after7date];
    NSLog(@"%zd,%zd: %zd-%zd",after7dateComponents.month,after7dateComponents.day,after7dateComponents.hour,after7dateComponents.minute);
   
    
    
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
