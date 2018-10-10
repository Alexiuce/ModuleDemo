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
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    [calendar ]
    
    
    
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
