//
//  BiteScrollView.h
//  滚动test
//
//  Created by keyan on 15/9/27.
//  Copyright © 2015年 keyan. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol BiteScrollViewDelegate <NSObject>

- (BOOL)isBiteViewwithPoint:(CGPoint)point Event:(UIEvent*)event CurrentView:(UIView*)currentView;

@end
@interface BiteScrollView : UIScrollView
@property (nonatomic,assign)id<BiteScrollViewDelegate>biteDelegate;
@end
