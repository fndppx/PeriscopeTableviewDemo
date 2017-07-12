//
//  MoveScrollViewController.m
//  滚动test
//
//  Created by keyan on 15/9/22.
//  Copyright (c) 2015年 keyan. All rights reserved.
//

#import "MoveScrollViewController.h"

@interface MoveScrollViewController ()
{
    UIScrollView * scrollView1;
    UIScrollView * scrollView2;
}
@end

@implementation MoveScrollViewController

- (void)viewDidLoad

{
    
    
    [super viewDidLoad];
    
    
    
    
    scrollView1 = [[UIScrollView alloc] initWithFrame:CGRectMake(10, 200, 100, 300)];
    
    scrollView2 = [[UIScrollView alloc] initWithFrame:CGRectMake(130, 200, 100, 300)];
    
    
    
    scrollView1.backgroundColor = [UIColor blueColor];
    
    scrollView2.backgroundColor = [UIColor orangeColor];
    
    scrollView2.contentSize = scrollView1.contentSize = CGSizeMake(100, 1000);
    
    scrollView1.delegate = self;
    
    
    
    [self.view addSubview:scrollView1];
    
    [self.view addSubview:scrollView2];
    
    
    
    for (int i=0; i<50; i++) {
        
        UILabel *lbl = [[UILabel alloc] initWithFrame:CGRectMake(0, i*20, 100, 20)];
        
        lbl.textColor = [UIColor whiteColor];
        
        lbl.textAlignment = UITextAlignmentCenter;
        
        lbl.text = [NSString stringWithFormat:@"Test text %d", i+1];
        
        [scrollView1 addSubview:lbl];
        
    }
    
    
    
    for (int i=0; i<50; i++) {
        
        UILabel *lbl = [[UILabel alloc] initWithFrame:CGRectMake(0, i*20, 100, 20)];
        
        lbl.textColor = [UIColor whiteColor];
        
        lbl.textAlignment = UITextAlignmentCenter;
        
        lbl.text = [NSString stringWithFormat:@"Test text %d", i+1];
        
        [scrollView2 addSubview:lbl];
        
    }
    
}


// delegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView

{
    
    scrollView2.contentOffset = scrollView.contentOffset;
    
  
    
    
    
    
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
