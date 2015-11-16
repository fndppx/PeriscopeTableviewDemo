//
//  MyCommonScrollview.h
//  滚动test
//
//  Created by keyan on 15/9/23.
//  Copyright (c) 2015年 keyan. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol MyCommonScrollviewDelegate <NSObject>

- (id) customScrollViewHistTest: (CGPoint)point withEvent:(UIEvent *)event currentView:(UIView*)currentView;
- (BOOL) customGestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer;
- (id) scrollviewJudgeClickViewisIncludeCurrentView: (CGPoint) point withEvent: (UIEvent *)event currentView:(UIView*)currentView;
@end
@interface MyCommonScrollview : UIScrollView

@property (nonatomic, assign) id<MyCommonScrollviewDelegate>scrollViewDelegate;
- (instancetype)initWithFrame:(CGRect)frame withType:(NSString*)type;
- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event ;
@end
