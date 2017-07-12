//
//  BiteScrollView.m
//  滚动test
//
//  Created by keyan on 15/9/27.
//  Copyright © 2015年 keyan. All rights reserved.
//

#import "BiteScrollView.h"

@implementation BiteScrollView

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    BOOL isbite =   [self.biteDelegate isBiteViewwithPoint:point Event:event CurrentView:self];
    if (isbite) {
        return nil;
    }
    return [super hitTest:point withEvent:event];
}
@end
