//
//  XCInlineObj.m
//  ObjcUI
//
//  Created by Alexcai on 2018/11/2.
//  Copyright © 2018 dongjiu. All rights reserved.
//

#import "XCInlineObj.h"

#define XCCommentText fetchMyCustomText()

FOUNDATION_STATIC_INLINE  NSString * fetchMyCustomText(){
    return [NSString stringWithFormat:@"%@",NSDate.date.description];
}

@implementation XCInlineObj

- (void)test{
    NSString *a = fetchMyCustomText();
    NSLog(@"a date == %@",a);
    
    NSString *b = XCCommentText;
    NSLog(@"b date == %@",b);
    
}

@end
