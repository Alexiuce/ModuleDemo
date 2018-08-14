//
//  ViewController.m
//  Objc-UI
//
//  Created by Alexcai on 2018/7/18.
//  Copyright © 2018年 Alexcai. All rights reserved.
//

#import "ViewController.h"
#import "HelloView.h"
#import "SDAutoLayout.h"
#import "PersonViewController.h"
#import "TransAnimationManager.h"






@interface ViewController ()

@property (nonatomic, strong)TransAnimationManager *transManager;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
   
    
    HelloView *v = [[NSBundle mainBundle]loadNibNamed:@"HelloView" owner:self options:nil].firstObject;
    //[[HelloView alloc]init];
//    v.frame = CGRectMake(100, 100, 30, 30);
    [self.view addSubview:v];
    
    v.sd_layout.widthIs(100).heightIs(50).xIs(50).yIs(60);
    
    UITextView *demoLabel = [UITextView new];
    demoLabel.backgroundColor = [UIColor redColor];
    [self.view addSubview:demoLabel];
    UIFont *originalFont = [UIFont fontWithName:@"American Typewriter" size:24.0];
    demoLabel.sd_layout.xIs(50).topSpaceToView(v, 20).widthIs(200).heightIs(100);
    
    
    UIFontDescriptor *fd = [originalFont.fontDescriptor fontDescriptorWithSymbolicTraits:UIFontDescriptorTraitBold];
    UIFont *newFont = [UIFont fontWithDescriptor:fd size:originalFont.pointSize];
    NSMutableAttributedString *text = [[NSMutableAttributedString alloc]initWithString:@"Hello Wrold~, this is a demo for trail mode Text on more content ..., if you can see a button in the last,this's ok~"];
    [text addAttributes:@{NSFontAttributeName:newFont} range:NSMakeRange(0, 5)];
    demoLabel.attributedText = text;
    
    
    
    NSTextContainer *tc = demoLabel.textContainer;
    UIBezierPath *exclusPath = [UIBezierPath bezierPathWithRect:CGRectMake(0, 0, 50, 30)];
    tc.exclusionPaths = @[exclusPath];
    
//    UITableView *tableView = [UITableView new];
    /** 1、beginUpdates 和 endUpdates必须成对使用
     2、使用beginUpdates和endUpdates可以在改变一些行（row）的高度时自带动画，并且不需要Reload row（不用调用cellForRow，仅仅需要调用heightForRow，这样效率最高）。
     3、在beginUpdates和endUpdates中执行insert,delete,select,reload row时，动画效果更加同步和顺滑，否则动画卡顿且table的属性（如row count）可能会失效。
     4、在beginUpdates 和 endUpdates中执行 reloadData 方法和直接reloadData一样，没有相应的中间动画
     */
//    [tableView beginUpdates];
//    [tableView endUpdates];
    
    
    /** CATransaction
    [CATransaction begin];
    [CATransaction setAnimationDuration:2];
    [CATransaction setAnimationTimingFunction:<#(nullable CAMediaTimingFunction *)#>];
    [CATransaction commit];
    
     */
    
    
//    NSTextStorage *storage = [[NSTextStorage alloc]initWithString:@"good morning~"];
//    NSLayoutManager *layoutManager = [[NSLayoutManager alloc]init];
//    [storage addLayoutManager:layoutManager];
//    
//    NSTextContainer *textContainer = [[NSTextContainer alloc]init];
//    
//    [layoutManager addTextContainer:textContainer];
    
    // Do any additional setup after loading the view, typically from a nib.
}
- (IBAction)clickBtn:(UIButton *)sender {
    PersonViewController *pvc = [[PersonViewController alloc]init];
    pvc.modalPresentationStyle = UIModalPresentationCustom;
    pvc.transitioningDelegate = self.transManager;
    [self presentViewController:pvc animated:YES completion:nil];
}


- (TransAnimationManager *)transManager{
    if (_transManager == nil) {
        _transManager = [TransAnimationManager new];
    }
    return _transManager;
}

typedef NSString *MYNotificationName NS_EXTENSIBLE_STRING_ENUM;


UIKIT_EXTERN MYNotificationName const WORKING;
UIKIT_EXTERN MYNotificationName const SLEEPING;
UIKIT_EXTERN MYNotificationName const EATING;

@end
