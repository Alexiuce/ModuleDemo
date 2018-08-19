//
//  XCPresentationController.m
//  Objc-UI
//
//  Created by Alexcai on 2018/8/19.
//  Copyright © 2018年 Alexcai. All rights reserved.
//

#import "XCPresentationController.h"


@interface XCPresentationController()

@property (nonatomic, strong) UIView *backView;

@end

@implementation XCPresentationController


//- (void)containerViewWillLayoutSubviews;
//- (void)containerViewDidLayoutSubviews;



// Position of the presented view in the container view by the end of the presentation transition.
// (Default: container view bounds)


// By default each new presentation is full screen.
// This behavior can be overriden with the following method to force a current context presentation.
// (Default: YES)
//- (BOOL)shouldPresentInFullscreen;

// Indicate whether the view controller's view we are transitioning from will be removed from the window in the end of the
// presentation transition
// (Default: NO)
//- (BOOL)shouldRemovePresentersView;
//#endif


- (CGRect)frameOfPresentedViewInContainerView{
    return CGRectMake(100, 100, 100, 200);
}

- (void)presentationTransitionWillBegin{
    [self.containerView addSubview:self.backView];
    [self.containerView addSubview:self.presentedView];
    self.presentedView.frame = self.containerView.bounds;
    
    NSLog(@"frame %@",NSStringFromCGRect(self.presentedView.frame));
    
}
- (void)presentationTransitionDidEnd:(BOOL)completed{
    
}
- (void)dismissalTransitionWillBegin{
    
}
- (void)dismissalTransitionDidEnd:(BOOL)completed{
    [self.backView removeFromSuperview];

}


#pragma mark - lazy getter
- (UIView *)backView{
    if (_backView == nil) {
        _backView = [[UIView alloc]initWithFrame:self.containerView.bounds];
        _backView.backgroundColor = UIColor.redColor;
    }
    return _backView;
}

@end
