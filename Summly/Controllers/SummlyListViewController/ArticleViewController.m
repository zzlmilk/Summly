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

#import "TextLayoutLabel.h"
#define Margin 15
#define MarginDic 10
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
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(Margin, 38, self.view.frame.size.width-Margin*2, 100)];
    [titleLabel setFont:[UIFont fontWithName:@"Heiti SC" size:22]];
    titleLabel.numberOfLines=0;
    titleLabel.text = self.summly.title;
    [titleLabel sizeThatFits:CGSizeMake(self.view.frame.size.width-Margin*2, 160)];
    [titleLabel setTextColor:[UIColor colorWithRed:51/255.0f green:51/255.0f blue:51/255.0f alpha:1.0f]];
    [titleLabel sizeToFit];
    [scrollView addSubview:titleLabel];
    
    UIImageView *iconImageView = [[UIImageView alloc] initWithFrame:CGRectMake(titleLabel.frame.origin.x,titleLabel.frame.size.height+titleLabel.frame.origin.y, 57/2, 57/2)];
    [iconImageView setImage:[UIImage imageNamed:@"publisherIcon.png"]];
    iconImageView.userInteractionEnabled=YES;
    [scrollView addSubview:iconImageView];
    
    UILabel *pulisherLabel = [[UILabel alloc] initWithFrame:CGRectMake(iconImageView.frame.size.width+iconImageView.frame.origin.x+MarginDic, titleLabel.frame.size.height+titleLabel.frame.origin.y+MarginDic, 100, 16)];
    pulisherLabel.userInteractionEnabled=YES;
    //        [pulisherLabel setFont:[UIFont boldSystemFontOfSize:11]];
    [pulisherLabel setFont:[UIFont fontWithName:@"Heiti SC" size:11]];
    if (self.summly.scource.length==0) {
        pulisherLabel.text = @"雅虎通讯";
    }
    else{
        pulisherLabel.text = self.summly.scource;
    }
    [pulisherLabel setTextColor:[UIColor colorWithRed:128/255.0f green:128/255.0f blue:128/255.0f alpha:1.0f]];
    [pulisherLabel setBackgroundColor:[UIColor clearColor]];
    [pulisherLabel sizeToFit];
    [scrollView addSubview:pulisherLabel];
    
    UILabel *timeIntervalLabel = [[UILabel alloc] initWithFrame:CGRectMake(pulisherLabel.frame.size.width+pulisherLabel.frame.origin.x+MarginDic, pulisherLabel.frame.origin.y-1, 100, 16)];
    timeIntervalLabel.userInteractionEnabled=YES;
    [timeIntervalLabel setFont:[UIFont systemFontOfSize:11]];
    [timeIntervalLabel setTextColor:[UIColor colorWithRed:0/255.0f green:0/255.0f blue:70/255.0f alpha:1.0f]];
    timeIntervalLabel.text=self.summly.time;
    [timeIntervalLabel sizeToFit];
    [timeIntervalLabel setBackgroundColor:[UIColor clearColor]];
    [scrollView addSubview:timeIntervalLabel];

    UIImageView *lineImage = [[UIImageView alloc]initWithFrame:CGRectMake(10, timeIntervalLabel.frame.size.height+timeIntervalLabel.frame.origin.y+Margin, 300,1)];
    lineImage.image= [UIImage imageNamed:@"fengexian.png"];
    [scrollView addSubview:lineImage];
    
    NSCharacterSet *characterSet = [NSCharacterSet whitespaceAndNewlineCharacterSet];
    NSString *commentStr = [self.summly.describe stringByTrimmingCharactersInSet:characterSet];
    
    CGSize size = [commentStr sizeWithFont:[UIFont fontWithName:@"Heiti SC" size:15] constrainedToSize:CGSizeMake(self.view.frame.size.width-Margin*2, 99999)];
    float textHeight = (int)size.height/17*4 +size.height;
//    NSLog(@"textLabelHeight %f",size.height);
    TextLayoutLabel *textLabel = [[TextLayoutLabel alloc] initWithFrame:CGRectMake(Margin,lineImage.frame.size.height+lineImage.frame.origin.y+Margin*2 , self.view.frame.size.width-Margin*2, textHeight)];
    [textLabel setBackgroundColor:[UIColor clearColor]];
    textLabel.numberOfLines=0;
    textLabel.text = self.summly.describe;
    [textLabel setFont:[UIFont fontWithName:@"Heiti SC" size:15]];
    [textLabel setTextColor:[UIColor colorWithRed:77/255.0f green:77/255.0f blue:77/255.0f alpha:1.0f]];
//    [textLabel sizeToFit];
    [scrollView addSubview:textLabel];
    
    UIButton *dismissBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [dismissBtn setFrame:CGRectMake(self.view.frame.size.width-38, 0, 38, 40)];
    [dismissBtn setBackgroundImage:[UIImage imageNamed:@"summly_close_x.png"] forState:UIControlStateNormal];
    [dismissBtn addTarget:self action:@selector(dismissBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [scrollView addSubview:dismissBtn];

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
//    [self pushControllerAnimate];
//    WebViewController *webViewController = [[WebViewController alloc] init];
//    webViewController.summly=self.summly;
//    [self.navigationController pushViewController:webViewController animated:NO];
    [self popToDetailScrollVC];

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
