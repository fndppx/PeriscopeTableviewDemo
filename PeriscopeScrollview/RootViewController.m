

//
//  RootViewController.m
//  PeriscopeScrollview
//
//  Created by SXJH on 2017/7/12.
//  Copyright © 2017年 keyan. All rights reserved.
//

#import "RootViewController.h"
#import "UIView+CustomPopView.h"
#import "MoveScrollViewController.h"
#import "PeriscopLiveViewController.h"
@interface RootViewController ()
@property (nonatomic,strong)PeriscopLiveViewController * periscopLiveViewController;

@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)popAction:(id)sender {
    PeriscopLiveViewController * tableView = [[PeriscopLiveViewController alloc]initWithNibName:@"PeriscopLiveViewController" bundle:nil withStartFrame:self.view.frame];
    self.periscopLiveViewController = tableView;
    //    self.periscopLiveViewController.view.frame = [UIScreen mainScreen].applicationFrame;
    [self.view showPopUpView:self.periscopLiveViewController.view Frame:self.view.frame];
    

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
