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
#import "BundleHelp.h"
#import <QuartzCore/QuartzCore.h>

#import "DetailScrollViewController.h"

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
    
    frontView = [[FrontSummlyView  alloc]initWithFrame:self.view.bounds];
    frontView.delegate= self;
    
    summlyScrollView = [[SummlyScrollView alloc]initWithFrame:CGRectMake(self.view.bounds.size.width, 0, self.self.view.bounds.size.width, self.view.bounds.size.height) delegate:self];
    
    mainSummlyView = [[MainSummlyView alloc]initWithFrame:self.view.bounds summlyScrollView:summlyScrollView AndFrontSummlyView:frontView];
    
    [self.view addSubview:mainSummlyView];
   
    self.isRestUI =YES;

    [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationCurveEaseOut |UIViewAnimationOptionBeginFromCurrentState animations:^{
        
        summlyScrollView.center =CGPointMake(summlyScrollView.center.x-100, summlyScrollView.center.y);
        frontView.center =CGPointMake(frontView.center.x-100, frontView.center.y);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.5 animations:^{
            summlyScrollView.center =CGPointMake(summlyScrollView.center.x+100, summlyScrollView.center.y);
            frontView.center =CGPointMake(frontView.center.x+100, frontView.center.y);
        }];
    }];

    
}

- (void)getTopicListFrom:(NSString *)plistStr{


}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [summlyScrollView  restUI];

//    if (self.isRestUI) {
        [Topic getDefaultTopicsParameters:nil WithBlock:^(NSMutableArray *topics,NSMutableArray *topicsManage) {
            if (topics) {
                topicsArr = topicsManage;
                [summlyScrollView generateItems:topics];
//                self.isRestUI = NO;
            }
        }];
//    }
//    else{
////        NSString *filename = [BundleHelp getBundlePath:Plist];
//        NSDictionary *dic = [BundleHelp getDictionaryFromPlist:Plist];
//
//        if ([dic isKindOfClass:[NSDictionary class]]) {
//            NSArray *arr  = (NSArray *)[dic objectForKey:@"topics"];
//            if (arr.count>0){
//                NSMutableArray *topics = [NSMutableArray arrayWithCapacity:arr.count];
//                for (NSDictionary *attributes in arr){
//                    Topic *t = [[Topic alloc]initWithAttributes:[attributes objectForKey:@"topic"]];
//                    if (t.status==1) {
//                        [topics addObject:t];
//                    }
//                }
//
//            }
//        }
//        
//        [summlyScrollView generateItems:[NSMutableArray arrayWithArray:topics]];
//
//        self.topicsArr=topics;
//
//    }
     summlyScrollView.contentOffset=CGPointMake(0, 0);
     [self.navigationController setNavigationBarHidden:YES];
}

-(void)viewDidDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
//    [self.navigationController setNavigationBarHidden:NO animated:YES];
}


#pragma mark ----FrontSummlyViewDelegate
-(void)backbuttonDidSelect{
    [mainSummlyView setContentOffset:CGPointMake(320, 0) animated:YES];
}

-(void)pushToDetailVCDelegate{
    NSArray *summlyArr = [NSArray arrayWithObject:frontView.summly];

    DetailScrollViewController *detailScrollVC = [[DetailScrollViewController alloc] init];
    detailScrollVC.summlyArr = summlyArr;
    //controller推入动画
    [self pushControllerAnimate];
//    NSLog(@"main---%@,%d",self.navigationController,self.navigationController.navigationBarHidden);
//    [self.navigationController setNavigationBarHidden:YES animated:YES];
    [self.navigationController pushViewController:detailScrollVC animated:NO];
//    [self presentModalViewController:detailScrollVC animated:NO];
    
}

- (void)pushControllerAnimate{
    CATransition *transition = [CATransition animation];
    transition.duration = 0.5f;
    transition.type = kCATransitionPush;
    transition.subtype = kCATransitionFromBottom;
    transition.delegate = self;
    [transition setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionDefault]];
    [self.navigationController.view.layer addAnimation:transition forKey:nil];
    
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
        if (itemSummly.itemSummlyType==saved) {
            summlyListViewController.isFav = YES;
        }
        else
            summlyListViewController.isFav = NO;
        
        [self.navigationController pushViewController:summlyListViewController animated:YES];
    }
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
