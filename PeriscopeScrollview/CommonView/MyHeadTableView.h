//
//  MyHeadTableView.h
//  滚动test
//
//  Created by keyan on 15/9/23.
//  Copyright (c) 2015年 keyan. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol MyHeadTableViewDelegate <NSObject>

- (id) customViewHistTest: (CGPoint) point
                withEvent: (UIEvent *)event
                 withView: (UIView *)view;
- (id) judgeClickViewisIncludeCurrentView: (CGPoint) point withEvent: (UIEvent *)event currentClass:(UIView*)currentClass;
@end
@interface MyHeadTableView : UIView

@property (nonatomic, assign) id<MyHeadTableViewDelegate>delegate;
@end
