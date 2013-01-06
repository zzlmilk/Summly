//
//  AboutViewController.m
//  Summly
//
//  Created by Mars on 13-1-2.
//  Copyright (c) 2013年 zzlmilk. All rights reserved.
//

#import "AboutViewController.h"

@interface AboutViewController ()

@end

@implementation AboutViewController

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
    self.title =@"关于豆豆科技咨询";
    int y = self.view.frame.size.height;
    
    UIButton *_button = [UIButton buttonWithType:UIButtonTypeCustom];
    [_button setBackgroundImage:[UIImage imageNamed:@"navigation-back-button.png"] forState:UIControlStateNormal];
    [_button setFrame:CGRectMake(0, 0, 50.0f, 30.0f)];
    [_button addTarget:self action:@selector(bactToSet) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem= [[UIBarButtonItem alloc]initWithCustomView:_button];
    
    //logo
    UIImageView  *logoImageView = [[UIImageView alloc] initWithFrame:CGRectMake(40, y - y + 15 ,230,170)];
    logoImageView.image = [UIImage imageNamed:@"logo@2x.png"];//加载入图片
    [self.view addSubview:logoImageView];
    
    UILabel *textLabel = [[UILabel alloc]initWithFrame:CGRectMake(25, y - 260, 350, 13)];
    textLabel.backgroundColor = [UIColor clearColor];
    textLabel.text = @"涵盖通讯、IT、科技、能源、生活等领域的最新、最热的资讯";
    textLabel.font = [UIFont boldSystemFontOfSize:10];
    textLabel.textColor = [UIColor whiteColor];
    [self.view addSubview:textLabel];
    
    UILabel *text2Label = [[UILabel alloc]initWithFrame:CGRectMake(50, y - 240, 300, 13)];
    text2Label.backgroundColor = [UIColor clearColor];
    text2Label.text = @"致力于成为领先的、最具影响力的移动互联网平台";
    text2Label.font = [UIFont boldSystemFontOfSize:10];
    text2Label.textColor = [UIColor whiteColor];
    [self.view addSubview:text2Label];
    

    UIImageView  *eparatedLeftImageView = [[UIImageView alloc] initWithFrame:CGRectMake(15, y - 258,2,30)];
    eparatedLeftImageView.image = [UIImage imageNamed:@"about-eparated@2x.png"];//加载入图片
    [self.view addSubview:eparatedLeftImageView];
    
    UIImageView  *eparatedRightImageView = [[UIImageView alloc] initWithFrame:CGRectMake(303, y - 258,2,30)];
    eparatedRightImageView.image = [UIImage imageNamed:@"about-eparated@2x.png"];//加载入图片
    [self.view addSubview:eparatedRightImageView];
    
    
    
    UIImageView  *phoneImageView = [[UIImageView alloc] initWithFrame:CGRectMake(13, y - 100,10,10)];
    phoneImageView.image = [UIImage imageNamed:@"phone@2x.png"];//加载入图片
    [self.view addSubview:phoneImageView];
    
    UILabel *phoneLabel = [[UILabel alloc]initWithFrame:CGRectMake(33, y - 100, 100, 10)];
    phoneLabel.backgroundColor = [UIColor clearColor];
    phoneLabel.text = @"Hot Line: 4009201168";
    phoneLabel.font = [UIFont systemFontOfSize:10];
    phoneLabel.textColor = [UIColor whiteColor];
    [self.view addSubview:phoneLabel];
    
    
    UIImageView  *emailImageView = [[UIImageView alloc] initWithFrame:CGRectMake(160, y -100,10,10)];
    emailImageView.image = [UIImage imageNamed:@"email@2x.png"];//加载入图片
    [self.view addSubview:emailImageView];
    
    
    UILabel *emailLabel = [[UILabel alloc]initWithFrame:CGRectMake(180, y - 100, 130, 10)];
    emailLabel.backgroundColor = [UIColor clearColor];
    emailLabel.text = @"E-mail:XXXX@emakes.net";
    emailLabel.font = [UIFont systemFontOfSize:10];
    emailLabel.textColor = [UIColor whiteColor];
    [self.view addSubview:emailLabel];
}

- (void)bactToSet
{
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
