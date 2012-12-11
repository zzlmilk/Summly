//
//  MainViewController.m
//  Summly
//
//  Created by zzlmilk on 12-12-9.
//  Copyright (c) 2012年 zzlmilk. All rights reserved.
//

#import "MainViewController.h"
@interface MainViewController ()

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
    
    UIImageView  *scrollImageView = [[UIImageView alloc]initWithFrame:self.view.bounds];
    scrollImageView.image =[UIImage imageNamed:@"1346345396832@2x.jpg"];
    [self.view addSubview:scrollImageView];

	// Do any additional setup after loading the view.
    SummlyScrollView *summluScrollView = [[SummlyScrollView alloc]initWithFrame:self.view.bounds];
   // summluScrollView.dataSource =self;
    [self.view addSubview:summluScrollView];

    
}



#pragma mark--


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
