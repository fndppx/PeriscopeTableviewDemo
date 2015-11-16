//
//  LiveVODChatViewController.m
//  滚动test
//
//  Created by keyan on 15/9/28.
//  Copyright © 2015年 keyan. All rights reserved.
//

#import "LiveVODChatViewController.h"
#import "CommonCommentView.h"
@interface LiveVODChatViewController ()
@property (nonatomic,assign)CGRect startViewFrame;//初始frame
@property (weak, nonatomic) IBOutlet UIView *keyboardView;

@property (weak, nonatomic) IBOutlet UITextField *keyboardTextField;

@end

@implementation LiveVODChatViewController
- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil withStartFrame:(CGRect)startFrame
{
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        self.startViewFrame = startFrame;
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [[CommonCommentView customKeyboard]textViewShowView:self customKeyboardDelegate:self];
    
}
-(void)talkBtnClick:(UITextView *)textViewGet
{
    NSLog(@"%@",textViewGet.text);
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
