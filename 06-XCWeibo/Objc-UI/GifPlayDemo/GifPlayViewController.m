//
//  GifPlayViewController.m
//  Objc-UI
//
//  Created by Alexcai on 2018/9/22.
//  Copyright © 2018年 Alexcai. All rights reserved.
//

#import "GifPlayViewController.h"
#import <ImageIO/ImageIO.h>
@interface GifPlayViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *imgView;

@end

@implementation GifPlayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    // 1. 获取gif 文件,并使用nsdata 加载;
    NSString *gifPath = [NSBundle.mainBundle pathForResource:@"demo.gif" ofType:nil];
    NSData *gifData = [NSData dataWithContentsOfFile:gifPath];
    NSLog(@"11111");
    // 2. 使用CGImageSource 读取图片数据;
    CGImageSourceRef imageSourceRef = CGImageSourceCreateWithData((__bridge CFDataRef)gifData, NULL);
    // 3. 获取gif 的图片总数;
    int imgCount = (int)CGImageSourceGetCount(imageSourceRef);
    // 4. 根据索引获取指定位置的图片;
    CGImageRef imgRef = CGImageSourceCreateImageAtIndex(imageSourceRef, imgCount - 1, NULL);
    // 5. 显示图片;
    self.imgView.image = [UIImage imageWithCGImage:imgRef];
    

}



@end
