//
//  MainViewController.m
//  Summly
//
//  Created by zzlmilk on 12-12-9.
//  Copyright (c) 2012年 zzlmilk. All rights reserved.
//

#import "MainViewController.h"
#import "Topic.h"
#import "SummlyScrollView.h"
#import "FrontSummlyView.h"

@interface MainViewController ()<ItemSummlyActionDelegate>
{
    FrontSummlyView* frontView;
    SummlyScrollView* summlyScrollView;
}
@end

@implementation MainViewController

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
    
    self.view.backgroundColor =[UIColor clearColor];
    
	// Do any additional setup after loading the view.
        
    UIImageView *bgImageView = [[UIImageView alloc]initWithFrame:self.view.bounds];
    bgImageView.image = [UIImage imageNamed:@"1346344762863@2x.jpg"];
    [self.view addSubview:bgImageView];
    
        
    frontView = [[FrontSummlyView  alloc]initWithFrame:self.view.bounds];
    summlyScrollView = [[SummlyScrollView alloc]initWithFrame:CGRectMake(self.view.bounds.size.width, 0, self.self.view.bounds.size.width, self.view.bounds.size.height) delegate:self];
    mainSummlyView = [[MainSummlyView alloc]initWithFrame:self.view.bounds summlyScrollView:summlyScrollView AndFrontSummlyView:frontView];
    [self.view addSubview:mainSummlyView];
    
    
    [Topic getDefaultTopicsParameters:nil WithBlock:^(NSMutableArray *topics) {
        if (topics) {
            [summlyScrollView generateItems:topics];
        }
    }];
    
}




#pragma mark ---- ItemSummlyActionDelegate
-(void)ItemSummlydidTap:(ItemSummly *)itemSummly{
    if (itemSummly.itemSummlyType == home) {
        [mainSummlyView setContentOffset:CGPointMake(0, 0) animated:YES];
    }
    else if(itemSummly.itemSummlyType ==add){
        NSLog(@"add");
        Topic *t = [[Topic alloc]init];
        t.title =@"test";        
        [summlyScrollView generateOneItem:t];
    }
    else{
        NSLog(@"other item idex = %d",itemSummly.index);
    }
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
