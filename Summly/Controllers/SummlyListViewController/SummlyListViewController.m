//
//  SummlyListViewController.m
//  Summly
//
//  Created by zzlmilk on 12-12-13.
//  Copyright (c) 2012年 zzlmilk. All rights reserved.
//

#import "SummlyListViewController.h"
#import "Summly.h"

@interface SummlyListViewController ()

@end

@implementation SummlyListViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        [Summly getSummlysParameters:[NSDictionary dictionaryWithObjectsAndKeys:@"5",@"topic_id", nil] WithBlock:^(NSMutableArray *summlys) {
                
        }];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = self.topic.title;
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
