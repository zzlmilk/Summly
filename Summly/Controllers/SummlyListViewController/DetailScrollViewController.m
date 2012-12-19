//
//  DetailScrollViewController.m
//  Summly
//
//  Created by zoe on 12-12-17.
//  Copyright (c) 2012年 zzlmilk. All rights reserved.
//

#import "DetailScrollViewController.h"
#import "SummlyDetailView.h"
#import <QuartzCore/QuartzCore.h>
#import "WebViewController.h"

@interface DetailScrollViewController ()
{
    
}
@property (nonatomic, strong) FAFancyMenuView *menu;
@end

@implementation DetailScrollViewController

static DetailScrollViewController *detailInstance=nil;

+(id)sharedInstance{    
    return detailInstance;
}


- (id)init{
    self = [super init];
    if (self) {
        detailInstance = self;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.index=[self calculateIndexFromScrollViewOffSet];
    self.view.backgroundColor = [UIColor whiteColor];
    //上滑返回
    UISwipeGestureRecognizer *swipUpGestureUp = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(back)];
    swipUpGestureUp.direction = UISwipeGestureRecognizerDirectionUp;
    [self.view addGestureRecognizer:swipUpGestureUp];
    
    //下滑wbview
    UISwipeGestureRecognizer *swipUpGestureDown = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(pushToWebView)];
    swipUpGestureDown.direction = UISwipeGestureRecognizerDirectionDown;
   [self.view addGestureRecognizer:swipUpGestureDown];

    UITapGestureRecognizer *doubleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleDoubleTap:)];
    [doubleTap setNumberOfTapsRequired:2];
    [self.view addGestureRecognizer:doubleTap];
    
    //[self.navigationController setNavigationBarHidden:YES animated:NO];
    
    scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    [scrollView setBackgroundColor:[UIColor underPageBackgroundColor]];
    scrollView.showsHorizontalScrollIndicator = YES;
    scrollView.pagingEnabled=YES;
    scrollView.scrollIndicatorInsets = UIEdgeInsetsMake(0, 0, self.view.frame.size.height-10, 0); 
    scrollView.delegate=self;
    [self.view addSubview:scrollView];
    
    [self createDetailView:self.summlyArr];
    
    NSArray *images = @[[UIImage imageNamed:@"petal-twitter.png"],[UIImage imageNamed:@"petal-facebook.png"],[UIImage imageNamed:@"petal-email.png"],[UIImage imageNamed:@"petal-save.png"]];
    self.menu = [[FAFancyMenuView alloc] init];
    self.menu.delegate = self;
    self.menu.buttonImages = images;
    [self.view addSubview:self.menu];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    if (self.navigationController.navigationBarHidden == NO) {
        [self.navigationController setNavigationBarHidden:YES animated:NO];
    }
}
//生成详情
- (void)createDetailView:(NSArray *)summlys{
    
    for (int i=0; i<summlys.count; i++) {
        SummlyDetailView *detailView = [[SummlyDetailView alloc] initWithFrame:CGRectMake(self.view.frame.size.width*i, 0, self.view.frame.size.width, self.view.frame.size.height) summly:[summlys objectAtIndex:i]];
        detailView.tag = i+10;
        [scrollView addSubview:detailView];
    }
    
    scrollView.contentSize = CGSizeMake(self.view.frame.size.width*summlys.count, self.view.frame.size.height);
}

//到达某篇文章
- (void)setScrollOffset:(NSInteger)index{
    [scrollView setContentOffset:CGPointMake(self.view.frame.size.width*index, 0)];
}

//pop动画
- (void)popControllerAnimate{
    CATransition *transition = [CATransition animation];
    transition.duration = 0.5f;
    transition.type = kCATransitionPush;
    transition.subtype = kCATransitionFromTop;
    transition.delegate = self;
    [transition setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionDefault]];
    [self.navigationController.view.layer addAnimation:transition forKey:nil];
}

- (void)popControllerFadeAnimate{
    CATransition *transition = [CATransition animation];
    transition.duration = 0.3f;
    transition.type = @"fade";
    transition.subtype = kCATransitionFade;
    [self.navigationController.view.layer addAnimation:transition forKey:nil];
}


//计算第几个详情
- (NSInteger)calculateIndexFromScrollViewOffSet{
    NSInteger index = 0;
    
    index =(int)scrollView.contentOffset.x/320;
    
    return index;
}
#pragma mark--
#pragma mark-- 手势方法
//上滑
-(void)back {
    //pop动画
    [self popControllerAnimate];
    [self.navigationController popViewControllerAnimated:NO];
}

//双击
- (void)handleDoubleTap:(UIGestureRecognizer *)gestureRecognizer {
    [scrollView setBackgroundColor:[UIColor whiteColor]];

    SummlyDetailView *detailView = (SummlyDetailView*)[scrollView viewWithTag:10+self.index];
    [detailView dismissDetailViewAnimate:^{
        ArticleViewController *articleVC = [[ArticleViewController alloc] init];
        articleVC.summly =[self.summlyArr objectAtIndex:self.index];
        articleVC.delegate=self;
        [self popControllerFadeAnimate];
        [self.navigationController pushViewController:articleVC animated:NO];
    }];
}

//动画
- (void)pushControllerAnimate{
    CATransition *transition = [CATransition animation];
    transition.duration = 0.5f;
    transition.type = kCATransitionPush;
    transition.subtype = kCATransitionFromBottom;
    [transition setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionDefault]];
    [self.navigationController.view.layer addAnimation:transition forKey:nil];
}
//下滑
-(void)pushToWebView{

    //push webviewcontroller
    [self pushControllerAnimate];
    WebViewController *webViewController = [[WebViewController alloc] init];
    webViewController.summly=[self.summlyArr objectAtIndex:self.index];
    [self.navigationController pushViewController:webViewController animated:NO];
}

- (void)showDetailViewAnimate{

    SummlyDetailView *detailView = (SummlyDetailView*)[scrollView viewWithTag:10+self.index];
    
    [detailView showDetailViewAnimate];

}



//花瓣按钮回调
- (void)fancyMenu:(FAFancyMenuView *)menu didSelectedButtonAtIndex:(NSUInteger)index{
    NSLog(@"%i",index);
}

#pragma mark--
#pragma mark-- ScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)_scrollView{
    
//    if (!_scrollView.dragging==YES ) {
//        return;
//    }
//    for (int i=1; i<self.summlyArr.count; i++) {
//        SummlyDetailView *detailView =(SummlyDetailView*)[scrollView viewWithTag:11+i];
//      //  detailView.titleLabel.frame = CGRectMake(_scrollView.contentOffset.x/5, 183.5-110,scrollView.frame.size.width ,100 );
//        detailView.imageBackView.frame = CGRectMake((_scrollView.contentOffset.x-i*320)/5,0, scrollView.frame.size.width, 183.5);
//    }
//    NSLog(@"contentOffset---%f--- %f",_scrollView.contentOffset.x,_scrollView.contentOffset.x/5);
    self.index=[self calculateIndexFromScrollViewOffSet];

}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)_scrollView{

//    for (int i=1; i<self.summlyArr.count; i++) {
//        SummlyDetailView *detailView =(SummlyDetailView*)[scrollView viewWithTag:10+i];
//        //  detailView.titleLabel.frame = CGRectMake(_scrollView.contentOffset.x/5, 183.5-110,scrollView.frame.size.width ,100 );
//        detailView.imageBackView.frame = CGRectMake(0,0, scrollView.frame.size.width, 183.5);
//    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}





@end
