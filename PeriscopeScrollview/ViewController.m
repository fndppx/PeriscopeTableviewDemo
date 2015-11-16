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
    
}
- (IBAction)sendAction:(id)sender {
//    DemoListViewController * tableView = [[DemoListViewController alloc]initWithNibName:@"DemoListViewController" bundle:nil];
//    self.middleSendView = tableView;
//    self.middleSendView.view.frame = self.view.bounds;
//    [self.view showPopUpView:self.middleSendView.view Frame:[[UIScreen mainScreen] bounds]];

  //    MoveScrollViewController * moveScrollView = [[MoveScrollViewController alloc]initWithNibName:@"MoveScrollViewController" bundle:nil];
//    UINavigationController * nav  = [[UINavigationController alloc]initWithRootViewController:moveScrollView];
//    self.view.window.rootViewController = nav;
    
    
}
- (IBAction)popAction:(id)sender {
    

    PeriscopLiveViewController * tableView = [[PeriscopLiveViewController alloc]initWithNibName:@"PeriscopLiveViewController" bundle:nil withStartFrame:self.view.frame];
    self.periscopLiveViewController = tableView;
//    self.periscopLiveViewController.view.frame = [UIScreen mainScreen].applicationFrame;
    [self.view showPopUpView:self.periscopLiveViewController.view Frame:self.view.frame];


}

@end
