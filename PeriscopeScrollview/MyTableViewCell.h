//
//  MyTableViewCell.h
//  滚动test
//
//  Created by keyan on 15/9/21.
//  Copyright (c) 2015年 keyan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyTableViewCell : UITableViewCell
@property(nonatomic,assign)BOOL isDissmiss;
+ (CGFloat)tableViewHeightWithWidth:(CGFloat)width;
@end
