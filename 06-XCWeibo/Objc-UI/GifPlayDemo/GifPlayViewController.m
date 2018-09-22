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
    NSMutableArray <UIImage *>*allImageArray = [NSMutableArray arrayWithCapacity:imgCount];
    NSTimeInterval allPlayDuration = 0;
    // 4. 根据索引获取指定位置的图片;
    for (int i = 0; i < imgCount; ++i) {
        // 4.0 获取图片引用;
        CGImageRef imgRef = CGImageSourceCreateImageAtIndex(imageSourceRef, i, NULL);
        UIImage *img = [UIImage imageWithCGImage:imgRef];
        [allImageArray addObject:img];
        // 释放cf 对象
        CFRelease(imgRef);
        // 4.1 获取gif图片相关属性;
        CFDictionaryRef dictRef = CGImageSourceCopyPropertiesAtIndex(imageSourceRef, i, NULL);
        // 4.2 获取gif 属性字典
        CFDictionaryRef gifDictRef = CFDictionaryGetValue(dictRef, kCGImagePropertyGIFDictionary);
        // 4.3 获取一帧的播放时长
        NSNumber *frameDuration = CFDictionaryGetValue(gifDictRef, kCGImagePropertyGIFDelayTime);
        allPlayDuration += frameDuration.doubleValue;
        // 释放cf 对象
        CFRelease(dictRef);
        
    }
    // 释放core foundation 对象
    CFRelease(imageSourceRef);
    // 5. 显示动画图片;
    self.imgView.animationImages = allImageArray;
    self.imgView.animationDuration = allPlayDuration;
    [self.imgView startAnimating];
    
    

}



@end
