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

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    HelloView *v = [[NSBundle mainBundle]loadNibNamed:@"HelloView" owner:self options:nil].firstObject;//[[HelloView alloc]init];
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
    
    
    UITableView *tableView = [UITableView new];
    [tableView beginUpdates];
    [tableView endUpdates];
    
    
    
//    NSTextStorage *storage = [[NSTextStorage alloc]initWithString:@"good morning~"];
//    NSLayoutManager *layoutManager = [[NSLayoutManager alloc]init];
//    [storage addLayoutManager:layoutManager];
//    
//    NSTextContainer *textContainer = [[NSTextContainer alloc]init];
//    
//    [layoutManager addTextContainer:textContainer];
    
    
   
    
    
    
     
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
