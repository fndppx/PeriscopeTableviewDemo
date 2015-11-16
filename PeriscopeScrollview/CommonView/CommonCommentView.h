//
//  CommonCommentView.h
//  cztvVideoiPhone
//
//  Created by keyan on 15/6/7.
//  Copyright (c) 2015年 letv. All rights reserved.
//


#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
typedef void(^CommentBlock)(NSString* commentPeople);

@protocol CommonCommentViewDelegate <NSObject>

@required
-(void)talkBtnClick:(UITextField *)textViewGet;
@end





@interface CommonCommentView : NSObject<UITextFieldDelegate>

@property (nonatomic,assign) id<CommonCommentViewDelegate>mDelegate;
@property (nonatomic,strong)UIView *mBackView;
@property (nonatomic,strong)UIView *mTopHideView;
@property (nonatomic,strong)UITextField * mTextView;
@property (nonatomic,strong)UIView *mHiddeView;
@property (nonatomic,strong)UIViewController *mViewController;
@property (nonatomic,strong)UIView *mSecondaryBackView;
@property (nonatomic,strong)UIButton *mTalkBtn;
@property (nonatomic) BOOL isTop;//用来判断评论按钮的位置

@property (nonatomic,copy)NSString * textFieldStr;//显示文字

@property (nonatomic,copy)CommentBlock commentBlcok;

+(CommonCommentView *)customKeyboard;

-(void)textViewShowView:(UIViewController *)viewController customKeyboardDelegate:(id)delegate;



- (void)gotoCommentPeople:(void(^)(NSString* commentPeople))commentBlock;


//改变显示文字
- (void)changeTextFieldStr:(NSString*)textFieldStr;
@end