//
//  DetailScrollViewController.m
//  Summly
//
//  Created by zoe on 12-12-17.
//  Copyright (c) 2012年 zzlmilk. All rights reserved.
//

#import "DetailScrollViewController.h"
#import "SummlyDetailView.h"

@interface DetailScrollViewController ()

@end

@implementation DetailScrollViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    
    scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    scrollView.showsHorizontalScrollIndicator = YES;
    scrollView.pagingEnabled=YES;
    scrollView.scrollIndicatorInsets = UIEdgeInsetsMake(0, 0, self.view.frame.size.height-10, 0);
    [self.view addSubview:scrollView];
    
    
    [self createDetailView:self.summlyArr];
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
