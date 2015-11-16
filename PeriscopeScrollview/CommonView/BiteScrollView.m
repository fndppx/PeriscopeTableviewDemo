//
//  BiteScrollView.m
//  滚动test
//
//  Created by keyan on 15/9/27.
//  Copyright © 2015年 keyan. All rights reserved.
//

#import "BiteScrollView.h"

@implementation BiteScrollView

//- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event {
//    //Using code from http://stackoverflow.com/questions/1042830/retrieving-a-pixel-alpha-value-for-a-uiimage
//    
//    unsigned char pixel[1] = {0};
//    CGContextRef context = CGBitmapContextCreate(pixel,
//                                                 1, 1, 8, 1, NULL,
//                                                 kCGImageAlphaOnly);
//    UIGraphicsPushContext(context);
////    [self.image drawAtPoint:CGPointMake(-point.x, -point.y)];
//    UIGraphicsPopContext();
//    CGContextRelease(context);
//    CGFloat alpha = pixel[0]/255.0f;
//    BOOL transparent = alpha < 0.01f;
//    
//    return !transparent;
//}
- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    
    
//    id currentControl = [self.scrollViewDelegate scrollviewJudgeClickViewisIncludeCurrentView:point withEvent:event currentView:self];
    
 BOOL isbite =   [self.biteDelegate isBiteViewwithPoint:point Event:event CurrentView:self];
//    
//    
//    if (currentControl==nil) {
//        return [super hitTest:point withEvent:event];
//        
//    }
//    
//    return currentControl;;
    if (isbite) {
        return nil;
    }
    
    return [super hitTest:point withEvent:event];
}
@end
