//
//  MainViewController.m
//  Summly
//
//  Created by zzlmilk on 12-12-9.
//  Copyright (c) 2012年 zzlmilk. All rights reserved.
//

#import "MainViewController.h"

#import "SummlyScrollView.h"
#import "FrontSummlyView.h"
#import "Topic.h"
#import "TopicViewController.h"
#import "SummlyListViewController.h"

#import <QuartzCore/QuartzCore.h>


@interface MainViewController ()<ItemSummlyActionDelegate,FrontSummlyViewDelegate>
{
    FrontSummlyView* frontView;
    SummlyScrollView* summlyScrollView;
}
@end

@implementation MainViewController
@synthesize topicsArr;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        //int value = (arc4random() % x) + 1;
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor =[UIColor clearColor];

                                
	// Do any additional setup after loading the view.
       
    
    
    frontView = [[FrontSummlyView  alloc]initWithFrame:self.view.bounds];
    frontView.delegate= self;
    
    summlyScrollView = [[SummlyScrollView alloc]initWithFrame:CGRectMake(self.view.bounds.size.width, 0, self.self.view.bounds.size.width, self.view.bounds.size.height) delegate:self];
    
    mainSummlyView = [[MainSummlyView alloc]initWithFrame:self.view.bounds summlyScrollView:summlyScrollView AndFrontSummlyView:frontView];
    
    [self.view addSubview:mainSummlyView];
    
    [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationCurveLinear |UIViewAnimationOptionBeginFromCurrentState animations:^{
        mainSummlyView.center =CGPointMake(mainSummlyView.center.x-100, mainSummlyView.center.y);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.3 animations:^{
            mainSummlyView.center =CGPointMake(mainSummlyView.center.x+100, mainSummlyView.center.y);
        }];
    }];

    
    
    [Topic getDefaultTopicsParameters:nil WithBlock:^(NSMutableArray *topics) {
        if (topics) {
            topicsArr = topics;
            [summlyScrollView generateItems:topics];
            
            
        }
    }];
    
}


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
     [self.navigationController setNavigationBarHidden:YES];        
}

-(void)viewDidDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}


#pragma mark ----FrontSummlyViewDelegate
-(void)backbuttonDidSelect{
    [mainSummlyView setContentOffset:CGPointMake(320, 0) animated:YES];
}

#pragma mark ---- ItemSummlyActionDelegate
-(void)ItemSummlydidTap:(ItemSummly *)itemSummly{
    if (itemSummly.itemSummlyType == home) {
        [mainSummlyView setContentOffset:CGPointMake(0, 0) animated:YES];
    }
    else if(itemSummly.itemSummlyType ==add){
        TopicViewController *topViewController = [[TopicViewController alloc]init];
        topViewController.topicsArr=topicsArr;
        [self.navigationController pushViewController:topViewController animated:YES];        
        /*
        Topic *t = [[Topic alloc]init];
        t.title =@"test";        
        [summlyScrollView generateOneItem:t];
         */
    }
    
    
    
    else{
        
        SummlyListViewController *summlyListViewController = [[SummlyListViewController alloc]init];
        summlyListViewController.topic = itemSummly.topic;
        [self.navigationController pushViewController:summlyListViewController animated:YES];
    }
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
