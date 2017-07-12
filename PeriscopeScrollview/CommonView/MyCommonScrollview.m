//
//  MyCommonScrollview.m
//  滚动test
//
//  Created by keyan on 15/9/23.
//  Copyright (c) 2015年 keyan. All rights reserved.
//

#import "MyCommonScrollview.h"
@interface MyCommonScrollview()
@property (nonatomic,strong)NSString * currentType;
@end
@implementation MyCommonScrollview


- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    
    
    id currentControl = [self.scrollViewDelegate scrollviewJudgeClickViewisIncludeCurrentView:point withEvent:event currentView:self];


    if (currentControl==nil) {
        return [super hitTest:point withEvent:event];

    }

    return currentControl;;
}



- (BOOL) gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer
shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    
    return [_scrollViewDelegate customGestureRecognizer:gestureRecognizer
     shouldRecognizeSimultaneouslyWithGestureRecognizer:otherGestureRecognizer];
}

@end
