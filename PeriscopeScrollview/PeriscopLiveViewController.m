//
//  PeriscopLiveViewController.m
//  滚动test
//
//  Created by keyan on 15/9/23.
//  Copyright (c) 2015年 keyan. All rights reserved.
//

#import "PeriscopLiveViewController.h"
#import "MyCommonScrollview.h"
#import "MyHeadTableView.h"
#import "ViewFrameAccessor.h"
#import "BiteScrollView.h"
#import "MyTableViewCell.h"
#define TableViewScrollViewToTopOffSetY 153//
#define TableViewHeadViewHeight 100
#define UISCREENFRAME [UIScreen mainScreen].applicationFrame
@interface PeriscopLiveViewController ()<UITableViewDataSource,UITableViewDelegate,MyCommonScrollviewDelegate,MyHeadTableViewDelegate,UIGestureRecognizerDelegate,BiteScrollViewDelegate>
{
    BOOL isHideButton;
    
    
    NSMutableArray * dataArray;
    float lastContentOffsetY;
    
    CGPoint _beginPoint;
    CGPoint _currentPoint;
    CGPoint _endPoint;
    CGFloat _distanceY;
    
    
    UIPanGestureRecognizer * panView;
}
@property (nonatomic,strong) BiteScrollView *pageScrollView;//最外层的scrollview
@property (nonatomic,strong) MyCommonScrollview *tableScrollView;//tableView所在的scrollview
@property (nonatomic,strong) UIView *vedioView;;//播放视频的view
@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) MyHeadTableView *headerView;//tableview上边的view

@property (nonatomic,strong) UIActivityIndicatorView * playButtonActivity;
@property (nonatomic,strong)UIButton * playVideoButton;
@property (nonatomic,strong)UIButton * bigPlayVideoButton;
@property (nonatomic,strong)UIView * playVideoButtonView;
@property (nonatomic,strong)UIButton * closeButton;
@property (nonatomic,strong)UILabel * topReminderLabel;//提示关闭的label
@property (nonatomic,strong)UIView * rightContentView;
@property (nonatomic,assign)CGRect startViewFrame;//初始frame
@end

@implementation PeriscopLiveViewController
- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil withStartFrame:(CGRect)startFrame
{
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        self.startViewFrame = startFrame;
    }
    return self;
}

#pragma mark-设置contentsize
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:YES];
    
    // 重新设置 tableScrollView 的 contentSize 和 _tableView 的 height;
    
    [_tableScrollView setContentSize:CGSizeMake(_tableView.width,TableViewScrollViewToTopOffSetY+self.startViewFrame.size.height)];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    //    NSLog(@"")
    dataArray = [[NSMutableArray alloc]initWithObjects:@"ios",@"ios",@"ios",@"安卓",@"ios",@"ios",@"ios",@"安卓",@"ios",@"jsp",@"java",@"ios",@"ios",@"ios",@"安卓",@"ios",@"ios",@"ios",@"安卓",@"ios",@"jsp",@"java", nil];
    
    
    self.view.backgroundColor = [UIColor blackColor];
    
    
    _vedioView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.startViewFrame.size.width , self.startViewFrame.size.height)];
    //  [vedioView setImage:tempImage];
    [_vedioView setBackgroundColor:[UIColor yellowColor]];
    [_vedioView setClipsToBounds:YES];
    [_vedioView setContentMode:UIViewContentModeScaleToFill];
    [self.view addSubview:_vedioView];
    
    
    
    _closeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _closeButton.backgroundColor = [UIColor whiteColor];
    _closeButton.frame = CGRectMake(UISCREENFRAME.size.width-70, 10, 50, 50);
    [_closeButton addTarget:self action:@selector(closeButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [_vedioView addSubview:_closeButton];
    
    
    _topReminderLabel = [[UILabel alloc]initWithFrame:CGRectMake((_vedioView.frame.size.width-80)/2, 10, 80, 30)];
    _topReminderLabel.text = @"松开以关闭";
    _topReminderLabel.textColor = [UIColor blackColor];
    _topReminderLabel.font = [UIFont boldSystemFontOfSize:13];
    _topReminderLabel.layer.opacity = 0;
    [_vedioView addSubview:_topReminderLabel];
    
    
    
    
    _pageScrollView = [[BiteScrollView alloc] initWithFrame:CGRectMake(0, 0, UISCREENFRAME.size.width, self.startViewFrame.size.height)];
    [_pageScrollView setDirectionalLockEnabled:YES];
    [_pageScrollView setShowsHorizontalScrollIndicator:NO];
    [_pageScrollView setShowsVerticalScrollIndicator:NO];
    [_pageScrollView setPagingEnabled:YES];
    _pageScrollView.biteDelegate= self;
    _pageScrollView.backgroundColor = [UIColor clearColor];
    _pageScrollView.userInteractionEnabled = YES;
    
    [_pageScrollView setContentSize:CGSizeMake(UISCREENFRAME.size.width*2 , self.startViewFrame.size.height-100)];
    [self.view addSubview:_pageScrollView];
    
    
    
    _tableScrollView = [[MyCommonScrollview alloc] initWithFrame:CGRectMake(0, 0, UISCREENFRAME.size.width, self.startViewFrame.size.height)];
    [_tableScrollView setScrollViewDelegate:self];
    [_tableScrollView setDelegate:self];
    _tableScrollView.scrollEnabled = YES;
    _tableScrollView.backgroundColor = [UIColor clearColor];
    [_tableScrollView setShowsHorizontalScrollIndicator:NO];
    [_tableScrollView setShowsVerticalScrollIndicator:NO];
    [_pageScrollView addSubview:_tableScrollView];
    
    
    _playVideoButtonView = [[UIView alloc]initWithFrame:CGRectMake((UISCREENFRAME.size.width-100)/2, 100, 100, 100)];
    _playVideoButtonView.backgroundColor = [UIColor redColor];
    [_tableScrollView addSubview:_playVideoButtonView];
    
    _bigPlayVideoButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _bigPlayVideoButton.backgroundColor = [UIColor blackColor];
    _bigPlayVideoButton.hidden = YES;
    _bigPlayVideoButton.frame = CGRectMake(0, 0, 100, 100);
    [_bigPlayVideoButton addTarget:self action:@selector(gotoPlayVideoAction) forControlEvents:UIControlEventTouchUpInside];
    [_playVideoButtonView addSubview:_bigPlayVideoButton];
    
    
    
    _playButtonActivity = [[UIActivityIndicatorView alloc]initWithFrame:CGRectMake(0, 0, 100, 100)];
    //    [_playButtonActivity isAnimating];
    [_playVideoButtonView addSubview:_playButtonActivity];
    [_playButtonActivity startAnimating];
    
    
    [self playActivityStartLoading:NO];
    
    
    //右侧的view
    
    _rightContentView = [[UIView alloc]initWithFrame:CGRectMake(UISCREENFRAME.size.width, 0, UISCREENFRAME.size.width, self.startViewFrame.size.height)];
    _rightContentView.backgroundColor = [UIColor clearColor];
    [_pageScrollView addSubview:_rightContentView];
    UIPanGestureRecognizer *rightpanView = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePan:)];
    rightpanView.delegate = self;
    [_rightContentView addGestureRecognizer:rightpanView];
    
    //    UIPanGestureRecognizer *rightpanView = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePan:)];
    //    rightpanView.delegate = self;
    //    [_liveVODChatViewController.view addGestureRecognizer:rightpanView];
    
    
    
    _tableView = [[UITableView alloc]
                  initWithFrame:CGRectMake(15, 330, self.startViewFrame.size.width - 30, 370)
                  style:UITableViewStylePlain];
    [_tableView setDelegate:self];
    [_tableView setDataSource:self];
    [_tableView setBounces:NO];
    [_tableView setShowsVerticalScrollIndicator:NO];
    [_tableView setShowsHorizontalScrollIndicator:NO];
    [_tableView setClipsToBounds:YES];
    [_tableView.layer setCornerRadius:4];
    [_tableScrollView addSubview:_tableView];
    
    
    
    _headerView = [[MyHeadTableView alloc] initWithFrame:CGRectMake(_tableView.left + 10, _tableView.top - TableViewHeadViewHeight, _tableView.width - 20, TableViewHeadViewHeight)];
    
    [_headerView setBackgroundColor:[UIColor greenColor]];
    [_headerView setDelegate:self];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, _headerView.frame.size.width-100, _headerView.frame.size.height-40)];
    [label setTextColor:[UIColor blackColor]];
    [label setFont:[UIFont boldSystemFontOfSize:16]];
    [label setText:@"放假了放假了放假了放假了"];
    [label setTextAlignment:NSTextAlignmentLeft];
    [label setNumberOfLines:0];
    [label setLineBreakMode:NSLineBreakByCharWrapping];
    [_headerView addSubview:label];
    
    UILabel *endlabel = [[UILabel alloc] initWithFrame:CGRectMake(0, label.frame.size.height, _headerView.frame.size.width-100, 40)];
    [endlabel setTextColor:[UIColor blackColor]];
    [endlabel setFont:[UIFont boldSystemFontOfSize:12]];
    [endlabel setText:@"结束与35分钟"];
    [endlabel setTextAlignment:NSTextAlignmentLeft];
    [endlabel setNumberOfLines:0];
    [endlabel setLineBreakMode:NSLineBreakByCharWrapping];
    [_headerView addSubview:endlabel];
    [_tableScrollView addSubview:_headerView];
    
    
    
    UIView * topView  =[[UIView alloc]initWithFrame:CGRectMake(0, 0, UISCREENFRAME.size.width, _headerView.frame.origin.y)];
    topView.backgroundColor = [UIColor clearColor];
    [_tableScrollView insertSubview:topView belowSubview:_bigPlayVideoButton];
    panView = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePan:)];
    panView.delegate = self;
    [topView addGestureRecognizer:panView];
    
    
    
    
    _playVideoButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _playVideoButton.backgroundColor = [UIColor whiteColor];
    _playVideoButton.frame = CGRectMake(_headerView.frame.size.width-60, 10, 50, 50);
    [_playVideoButton addTarget:self action:@selector(playVideoButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [_headerView addSubview:_playVideoButton];
    
    
}

- (void)playActivityStartLoading:(BOOL)isStartAnimation
{
    if (isStartAnimation) {
        [_playButtonActivity startAnimating];
    }
    else
    {
        [_playButtonActivity stopAnimating];
    }
    //    _bigPlayVideoButton.hidden = isStartAnimation;
    _bigPlayVideoButton.hidden = isStartAnimation;
}

#pragma mark -是否穿透
- (BOOL)isBiteViewwithPoint:(CGPoint)point Event:(UIEvent*)event CurrentView:(UIView*)currentView
{
    CGPoint closebuttonPoint = [_closeButton convertPoint:point fromView:currentView];
    if ([_closeButton pointInside:closebuttonPoint withEvent:event]) {
        return YES;
    }
    return NO;
    
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark-tableviewDelegate

- (UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section==0) {
        UIView * mapView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 150)];
        mapView.backgroundColor = [UIColor redColor];
        return mapView;
    }
    else if (section==1)
    {
        UIView * mapView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 150)];
        mapView.backgroundColor = [UIColor whiteColor];
        
        UIImageView * userImageView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 50, 50)];
        userImageView.backgroundColor = [UIColor redColor];
        [mapView addSubview:userImageView];
        
        UILabel * titleNameLabel = [[UILabel alloc]initWithFrame:CGRectMake(65, 12, tableView.frame.size.width-200, 30)];
        titleNameLabel.text = @"NIkos Aliagas";
        titleNameLabel.backgroundColor = [UIColor greenColor];
        [mapView addSubview:titleNameLabel];
        
        UILabel * desNameLabel = [[UILabel alloc]initWithFrame:CGRectMake(65, titleNameLabel.frame.size.height+12, tableView.frame.size.width-200, 20)];
        desNameLabel.text = @"NIkos Aliagas";
        [mapView addSubview:desNameLabel];
        [desNameLabel sizeToFit];
        
        UIImageView * desNameImage = [[UIImageView alloc]initWithFrame:CGRectMake(desNameLabel.frame.size.width+desNameLabel.frame.origin.x,CGRectGetMidY(desNameLabel.frame)-2, 10, 10)];
        desNameImage.backgroundColor = [UIColor redColor];
        [mapView addSubview:desNameImage];
        
        
        UIButton * shareButton = [UIButton buttonWithType:UIButtonTypeCustom];
        shareButton.backgroundColor = [UIColor redColor];
        shareButton.frame = CGRectMake((tableView.frame.size.width-200)/3, 80, 100, 40);
        [mapView addSubview:shareButton];
        
        
        UIButton * hideChatButton = [UIButton buttonWithType:UIButtonTypeCustom];
        hideChatButton.backgroundColor = [UIColor redColor];
        hideChatButton.frame = CGRectMake((tableView.frame.size.width-200)/3*2+100, 80, 100, 40);
        [mapView addSubview:hideChatButton];
        
        return mapView;
    }
    else
    {
        UIView * peopleView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 50)];
        peopleView.backgroundColor = [UIColor whiteColor];
        
        UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(8, 8, tableView.frame.size.width, 42)];
        label.text = @"1777个重播观众";
        [peopleView addSubview:label];
        
        return peopleView;
    }
    
    return nil;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section==0) {
        return 150;
    }
    else if (section==1)
    {
        return 150;
    }
    return 50;
}
- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section==0) {
        return 0;
    }
    else if (section==1)
    {
        return 0;
    }
    return [dataArray count];
    
}

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    //    return 44;
    return  [MyTableViewCell tableViewHeightWithWidth:tableView.frame.size.width];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    //    UITableViewCell *cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"cell2"];
    //    if (!cell) {
    //        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell2"];
    //    }
    static NSString * identifier = @"MyTableViewCell";
    MyTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"MyTableViewCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
        cell.backgroundColor = [UIColor clearColor];
        cell.selectionStyle = UITableViewCellSelectionStyleDefault;
    }
    
    
    //    cell.textLabel.text = [dataArray objectAtIndex:indexPath.row] ;
    
    return cell;
}

#pragma mark - UIScrollView delegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    
    CGFloat offset = _tableScrollView.contentOffset.y;
    
    if ([scrollView isEqual:_tableScrollView]) {
        int Value = _tableScrollView.contentOffset.y;
        
        float alpha = (Value% 150) / 100.f;
        NSLog(@"----%f",alpha);
        
        //        offset*0.5;
        if (offset>=0) {
            
            [UIView animateWithDuration:0.0001 animations:^{
                CGAffineTransform rotation = CGAffineTransformMakeTranslation(0,  offset*0.5);
                [_playVideoButtonView setTransform:rotation];
                
            }];
            
            
            if (_tableScrollView.contentOffset.y<110) {
                _playVideoButtonView.layer.opacity = 1-alpha;
                
            }
        }
    }
    
    
    NSLog(@"tableScrollView%f==_tableView%f",_tableScrollView.contentOffset.y,_tableScrollView.contentSize.height);
    //向上滑动
    if (_tableScrollView.contentOffset.y >= lastContentOffsetY) {
        if (_tableScrollView.contentOffset.y >= TableViewScrollViewToTopOffSetY) {
            [_tableScrollView setContentOffset:CGPointMake(0, TableViewScrollViewToTopOffSetY)];
            _playVideoButtonView.layer.opacity = 0;
        } else {
            [_tableView setContentOffset:CGPointMake(0, 0)];
        }
    } else {
        //向下滑动
        if (_tableView.contentOffset.y != 0) {
            [_tableScrollView setContentOffset:CGPointMake(0, TableViewScrollViewToTopOffSetY)];
        }
    }
}

- (void) scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    NSLog(@"start%f",lastContentOffsetY);
    /**
     *  滚动开始位置
     */
    lastContentOffsetY = _tableScrollView.contentOffset.y;
};

#pragma mark - headView delegate
- (id) judgeClickViewisIncludeCurrentView: (CGPoint) point withEvent: (UIEvent *)event currentClass:(UIView*)currentClass
{
    
    
    CGPoint buttonPoint = [_playVideoButton convertPoint:point fromView:currentClass];
    CGPoint headerViewPoint = [_headerView convertPoint:point fromView:currentClass];
    if ([_playVideoButton pointInside:buttonPoint withEvent:event]) {
        return _playVideoButton;
    }
    else if ([_headerView pointInside:headerViewPoint withEvent:event]) {
        return _tableView;
    }
    else
    {
        
        return nil;
    }
    
    
}
- (id) customViewHistTest:(CGPoint)point withEvent:(UIEvent *)event withView:(UIView *)view {
    
    
    if ([_headerView pointInside:point withEvent:event]) {
        return _tableView;
    }
    
    return nil;
}

#pragma makk - ScrollView Delegate
- (id) scrollviewJudgeClickViewisIncludeCurrentView: (CGPoint) point withEvent: (UIEvent *)event currentView:(UIView*)currentView
{
    //    CGPoint buttonPoint = [_tableView convertPoint:point fromView:currentView];
    //    if ([_tableView pointInside:buttonPoint withEvent:event]) {
    //
    //        return nil;
    //    }
    //    CGPoint headerViewPoint = [_headerView convertPoint:point fromView:currentView];
    //    if ([_headerView pointInside:headerViewPoint withEvent:event]) {
    //
    //        return nil;
    //
    //    }
    return nil;
}




#pragma mark-左侧view的手势
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    if ([gestureRecognizer isKindOfClass:[UIPanGestureRecognizer class]]) {
        CGPoint point =  [(UIPanGestureRecognizer*)gestureRecognizer translationInView:self.view.superview ];
        if (point.x>0||point.x<0) {
            return NO;
        }
    }
    return YES;
}
#pragma mark 是否支持多手势
- (BOOL) customGestureRecognizer:(UIGestureRecognizer *)gestureRecognizer
shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    // return YES 是引起 scrollView 和 tableView 同时起效的必要条件
    if (otherGestureRecognizer == _pageScrollView.panGestureRecognizer ||
        gestureRecognizer == _pageScrollView.panGestureRecognizer||gestureRecognizer == panView||otherGestureRecognizer==panView) {
        return NO;
    }
    
    
    return YES;
}

-(void)handlePan:(UIPanGestureRecognizer*) panParam
{
    
    if (panParam.state == UIGestureRecognizerStateBegan) {
        _beginPoint = [panParam locationInView:self.view.superview];
    }
    _currentPoint = [panParam locationInView:self.view.superview];
    _distanceY = _currentPoint.y - _beginPoint.y;
    
    self.view.y = _distanceY;
    
    
    NSLog(@"11111   %f",_distanceY);
    _topReminderLabel.layer.opacity = _distanceY*0.01;
    
    if (panParam.state == UIGestureRecognizerStateEnded) {
        
        _endPoint = [panParam locationInView:self.view.superview];
        // 4.判断上下滑动，作相应调整
        NSLog(@"%f",_topReminderLabel.layer.opacity);
        if (_topReminderLabel.layer.opacity >=1 ) {
            // 下滑
            [UIView animateWithDuration:0.3f animations:^{
                self.view.y = self.view.height;
            } completion:^(BOOL finished) {
                [self.view removeFromSuperview];
            }];
        }
        else {
            // 上滑
            [UIView animateWithDuration:0.3f animations:^{
                self.view.y = 0.f;
                _topReminderLabel.layer.opacity = 0;
            }];
        }
        
    }
    
}
#pragma mark -buttonAction

- (void)closeButtonAction
{
    [UIView animateWithDuration:0.3f animations:^{
        self.view.y = self.view.height;
    } completion:^(BOOL finished) {
        [self.view removeFromSuperview];
    }];
}

- (void)playVideoButtonAction
{
    [_pageScrollView setContentOffset:CGPointMake(UISCREENFRAME.size.width,0) animated:YES];
}
- (void)gotoPlayVideoAction
{
    
}
@end
