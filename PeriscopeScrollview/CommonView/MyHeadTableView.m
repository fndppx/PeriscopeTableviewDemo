//
//  MyHeadTableView.m
//  滚动test
//
//  Created by keyan on 15/9/23.
//  Copyright (c) 2015年 keyan. All rights reserved.
//

#import "MyHeadTableView.h"

@implementation MyHeadTableView


- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    
   id currentControl = [self.delegate judgeClickViewisIncludeCurrentView:point withEvent:event currentClass:self ];
//    if ([currentControl isKindOfClass:[UIButton class]]) {
//        return currentControl;
//    }

    if (!currentControl) {
         return [super hitTest:point withEvent:event];
    }
    return currentControl;
//    UIView *toucheView = [super hitTest:point withEvent:event];
//    
//    UIView *view = [self.delegate customViewHistTest:point withEvent:event withView: toucheView];
//    
//    if (!view) {
//        return [super hitTest:point withEvent:event];
//    }
//    
//    return view;
}



@end
