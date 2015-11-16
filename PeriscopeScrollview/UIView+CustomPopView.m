//
//  UIView+CustomPopView.m
//  滚动test
//
//  Created by keyan on 15/9/21.
//  Copyright (c) 2015年 keyan. All rights reserved.
//

#import "UIView+CustomPopView.h"
#import "ViewFrameAccessor.h"
@implementation UIView (CustomPopView)

- (void)showPopUpView:(UIView *)popView Frame:(CGRect)rect {
    popView.frame = rect;
    popView.top = self.height;
    [self addSubview:popView];
    [UIView animateWithDuration:0.3f animations:^{
        popView.top = 0.f;
    }];
}
@end
