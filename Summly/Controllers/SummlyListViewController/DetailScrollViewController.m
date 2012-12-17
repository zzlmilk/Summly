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

@interface DetailScrollViewController ()
{
    
}
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
    
    
    swipUpGesture  = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(back)];
    swipUpGesture.direction = UISwipeGestureRecognizerDirectionUp;
    [self.view addGestureRecognizer:swipUpGesture];
    
    //[self.navigationController setNavigationBarHidden:YES animated:NO];
    
    scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    scrollView.showsHorizontalScrollIndicator = YES;
    scrollView.pagingEnabled=YES;
    scrollView.scrollIndicatorInsets = UIEdgeInsetsMake(0, 0, self.view.frame.size.height-10, 0); //这里写的好哦
    [self.view addSubview:scrollView];
    
    [self createDetailView:self.summlyArr];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    if (self.navigationController.navigationBarHidden == YES) {
        [self.navigationController setNavigationBarHidden:NO animated:NO];
    }    
}

//到达某篇文章
- (void)setScrollOffset:(NSInteger)index{
    [scrollView setContentOffset:CGPointMake(self.view.frame.size.width*index, 0)];
}

- (void)popControllerAnimate{
    CATransition *transition = [CATransition animation];
    transition.duration = 0.3f;
    transition.type = kCATransitionPush;
    transition.subtype = kCATransitionFromTop;
    transition.delegate = self;
    [transition setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionDefault]];
    [self.navigationController.view.layer addAnimation:transition forKey:nil];
    
}
-(void)back {
    //pop动画
    [self popControllerAnimate];
    [self.navigationController popViewControllerAnimated:NO];
}

- (void)createDetailView:(NSArray *)summlys{
    
    for (int i=0; i<summlys.count; i++) {
        SummlyDetailView *detailView = [[SummlyDetailView alloc] initWithFrame:CGRectMake(self.view.frame.size.width*i, 0, self.view.frame.size.width, self.view.frame.size.height) summly:[summlys objectAtIndex:i]];
        [scrollView addSubview:detailView];
    }

    scrollView.contentSize = CGSizeMake(self.view.frame.size.width*summlys.count, self.view.frame.size.height);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
