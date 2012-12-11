//
//  REXUIGestureRecognizerViewController.m
//  SinaPhotoWall
//
//  Created by zzlmilk on 12-12-2.
//  Copyright (c) 2012年 zzlmilk. All rights reserved.
//

#import "REXUIGestureRecognizerViewController.h"

@interface REXUIGestureRecognizerViewController ()

@end

@implementation REXUIGestureRecognizerViewController

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
    
    
    swipeRecognizer = [[UISwipeGestureRecognizer alloc]initWithTarget:self
                                                               action:@selector(handleSwipeFrom:)];
    
    swipeRecognizer.direction = UISwipeGestureRecognizerDirectionLeft;
    [self.view addGestureRecognizer:swipeRecognizer];
    
    
	// Do any additional setup after loading the view.
}


-(void)handleSwipeFrom:(UISwipeGestureRecognizer *)recognizer{
//    CGPoint location = [recognizer locationInView:self.view];       
    if (recognizer.direction == UISwipeGestureRecognizerDirectionLeft) {
            NSLog(@"letf");
    }
    
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    swipeRecognizer =nil;
    pinRecongnizer  =nil;
    rotaionRecongnizer= nil;
    tapRecongnizer = nil;
}

@end
