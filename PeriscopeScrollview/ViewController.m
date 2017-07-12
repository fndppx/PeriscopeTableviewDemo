//
//  ViewController.m
//  滚动test
//
//  Created by keyan on 15/9/18.
//  Copyright (c) 2015年 keyan. All rights reserved.
//

#import "ViewController.h"
#import "UIView+CustomPopView.h"
#import "MoveScrollViewController.h"
#import "PeriscopLiveViewController.h"
@interface ViewController ()
@property (nonatomic,strong)PeriscopLiveViewController * periscopLiveViewController;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.view.backgroundColor = [UIColor whiteColor];
    
}
- (IBAction)sendAction:(id)sender {
    
}
- (IBAction)popAction:(id)sender {
    

    PeriscopLiveViewController * tableView = [[PeriscopLiveViewController alloc]initWithNibName:@"PeriscopLiveViewController" bundle:nil withStartFrame:self.view.frame];
    self.periscopLiveViewController = tableView;
//    self.periscopLiveViewController.view.frame = [UIScreen mainScreen].applicationFrame;
    [self.view showPopUpView:self.periscopLiveViewController.view Frame:self.view.frame];


}

@end
