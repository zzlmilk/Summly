//
//  ArticleViewController.m
//  Summly
//
//  Created by zoe on 12-12-18.
//  Copyright (c) 2012年 zzlmilk. All rights reserved.
//

#import "ArticleViewController.h"
#import "SummlyDetailView.h"
#import <QuartzCore/QuartzCore.h>
#import "WebViewController.h"

#define Margin 15

@interface ArticleViewController ()

@end

@implementation ArticleViewController

- (id)init
{
    self = [super init];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //上滑返回
    UISwipeGestureRecognizer *swipUpGestureUp = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(handleSwipUpTap:)];
    swipUpGestureUp.direction = UISwipeGestureRecognizerDirectionDown;
    [self.view addGestureRecognizer:swipUpGestureUp];

    UITapGestureRecognizer *doubleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleDoubleTap:)];
    [doubleTap setNumberOfTapsRequired:2];
    [self.view addGestureRecognizer:doubleTap];

    UIScrollView *scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    [scrollView setBackgroundColor:[UIColor whiteColor]];
    scrollView.showsVerticalScrollIndicator = YES;
    scrollView.pagingEnabled=YES;
    [self.view addSubview:scrollView];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(Margin, Margin, self.view.frame.size.width-Margin*2, 100)];
    [titleLabel setFont:[UIFont boldSystemFontOfSize:20]];
    titleLabel.numberOfLines=0;
    titleLabel.text = self.summly.title;
    [titleLabel sizeThatFits:CGSizeMake(self.view.frame.size.width-Margin*2, 160)];
    [self.view addSubview:titleLabel];

    UILabel *pulisherLabel = [[UILabel alloc] initWithFrame:CGRectMake(titleLabel.frame.origin.x,titleLabel.frame.size.height+titleLabel.frame.origin.y, 100, 16)];
    [pulisherLabel setFont:[UIFont boldSystemFontOfSize:12]];
    if (self.summly.scource.length==0) {
        pulisherLabel.text = @"雅虎通讯";
    }
    else{
        pulisherLabel.text = self.summly.scource;
    }
    [pulisherLabel setBackgroundColor:[UIColor clearColor]];
    [pulisherLabel setTextColor:[UIColor colorWithRed:153/255.0f green:153/255.0f blue:153/255.0f alpha:1.0f]];
    [pulisherLabel sizeToFit];
    [self.view addSubview:pulisherLabel];

    
    UILabel *textLabel = [[UILabel alloc] initWithFrame:CGRectMake(Margin,pulisherLabel.frame.size.height+pulisherLabel.frame.origin.y+Margin , self.view.frame.size.width-Margin*2, 400)];
    [textLabel setBackgroundColor:[UIColor clearColor]];
    [textLabel setFont:[UIFont systemFontOfSize:13]];
    textLabel.numberOfLines=0;
    textLabel.text = self.summly.describe;
    [textLabel sizeToFit];
    [self.view addSubview:textLabel];

    UIButton *webViewBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [webViewBtn setBackgroundImage:[UIImage imageNamed:@"webviewBtn.png"] forState:UIControlStateNormal];
    [webViewBtn setFrame:CGRectMake(self.view.frame.size.width-18-10, pulisherLabel.frame.origin.y, 18, 18)];
    [webViewBtn addTarget:self action:@selector(webViewBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:webViewBtn];
    
    UIButton *dismissBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [dismissBtn setFrame:CGRectMake(self.view.frame.size.width-55, 0, 55, 52)];
    [dismissBtn setBackgroundImage:[UIImage imageNamed:@"summly_close_x.png"] forState:UIControlStateNormal];
    [dismissBtn addTarget:self action:@selector(dismissBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:dismissBtn];
    
    if (textLabel.frame.size.height+textLabel.frame.origin.y+Margin<self.view.frame.size.height) {
        scrollView.contentSize = CGSizeMake(self.view.frame.size.width, self.view.frame.size.height);
    }
    else
        scrollView.contentSize = CGSizeMake(self.view.frame.size.width, textLabel.frame.size.height+textLabel.frame.origin.y+Margin);
}

- (void)pushControllerAnimate{
    CATransition *transition = [CATransition animation];
    transition.duration = 0.5f;
    transition.type = kCATransitionPush;
    transition.subtype = kCATransitionFromBottom;
    [transition setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionDefault]];
    [self.navigationController.view.layer addAnimation:transition forKey:nil];
}

//下滑跳转web
- (void)webViewBtnClick:(id)sender{
    [self pushControllerAnimate];
    WebViewController *webViewController = [[WebViewController alloc] init];
    webViewController.summly=self.summly;
    [self.navigationController pushViewController:webViewController animated:NO];

}

- (void)dismissBtnClick:(id)sender{

    [self popToDetailScrollVC];
}

//下滑跳转web
- (void)handleSwipUpTap:(UIGestureRecognizer *)gestureRecognizer {

    [self webViewBtnClick:nil];
}
//返回
-(void)handleDoubleTap:(UIGestureRecognizer *)gestureRecognizer{

    [self popToDetailScrollVC];
}

//返回上层，委托调动画
- (void)popToDetailScrollVC{

    if ([self.delegate respondsToSelector:@selector(showDetailViewAnimate)]) {
        [self.delegate performSelector:@selector(showDetailViewAnimate)];
    }
    //[self popControllerAnimate];
    [self.navigationController popViewControllerAnimated:NO];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
