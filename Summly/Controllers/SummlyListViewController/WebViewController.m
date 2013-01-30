//
//  WebViewController.m
//  Summly
//
//  Created by lostkid on 12-12-19.
//  Copyright (c) 2012年 zzlmilk. All rights reserved.
//

#import "WebViewController.h"
#import <QuartzCore/QuartzCore.h>

@interface WebViewController ()

@end

@implementation WebViewController

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
    
    self.navigationController.navigationBar.hidden=YES;
//    http://www.leiphone.com/tag/app
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:self.summly.sourceUrl]];
    
//    NSLog(@"%@",self.summly.sourceUrl);
    UIImageView *navigationBar = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"webview-navigation-backround"]];
    navigationBar.userInteractionEnabled=YES;
    [navigationBar setFrame:CGRectMake(0, 0, 320, 45)];
    [self.view addSubview:navigationBar];
    
    loadLabel = [[UILabel alloc] initWithFrame:CGRectMake(50,10, 220, 26)];
    loadLabel.text=@"加载中...";
    [loadLabel setBackgroundColor:[UIColor clearColor]];
    [loadLabel setTextAlignment:UITextAlignmentCenter];
    [navigationBar addSubview:loadLabel];
    
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [backBtn setFrame:CGRectMake(loadLabel.frame.size.width+loadLabel.frame.origin.x+10, 7.5, 30, 30)];
    [backBtn setBackgroundImage:[UIImage imageNamed:@"dimiss"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [navigationBar addSubview:backBtn];
    
    
    UIWebView *webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, navigationBar.frame.size.height, self.view.frame.size.width, self.view.frame.size.height-45)];
    [webView setBackgroundColor:[UIColor whiteColor]];
    [webView loadRequest:request];
    webView.delegate=self;
    webView.scalesPageToFit=YES;
    webView.userInteractionEnabled=YES;
    [self.view addSubview:webView];
    
//    UIImageView *tabbar = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"web-toolbar"]];
//    tabbar.userInteractionEnabled=YES;
//    [tabbar setFrame:CGRectMake(0, self.view.frame.size.height-45, 320, 45)];
//    [self.view addSubview:tabbar];
//    
//
//    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    [leftBtn setFrame:CGRectMake(106, 11, 37/2, 23)];
//    [leftBtn setBackgroundImage:[UIImage imageNamed:@"web-navigate-back"] forState:UIControlStateNormal];
//    [leftBtn addTarget:self action:@selector(lastOffset) forControlEvents:UIControlEventTouchUpInside];
//    [tabbar addSubview:leftBtn];
//    
//    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    [rightBtn setFrame:CGRectMake(leftBtn.frame.size.width+leftBtn.frame.origin.x+60, 11, 37/2, 23)];
//    [rightBtn setBackgroundImage:[UIImage imageNamed:@"web-navigate-forwards"] forState:UIControlStateNormal];
//    [rightBtn addTarget:self action:@selector(forwardOffset) forControlEvents:UIControlEventTouchUpInside];
//    [tabbar addSubview:rightBtn];
    
//    activity=[[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(20,12, 20, 20)];
//    activity.hidesWhenStopped=YES;
//    activity.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhite;
//    [tabbar addSubview:activity];

//    UIButton *exportBtn = [UIButton buttonWithType:UIButtonTypeInfoDark];
//    [exportBtn setFrame:CGRectMake(leftBtn.frame.size.width+leftBtn.frame.origin.x+60, 11, 37/2, 23)];
//    [exportBtn setBackgroundImage:[UIImage imageNamed:@"web-navigate-forwards"] forState:UIControlStateNormal];
//    [exportBtn addTarget:self action:@selector(export:) forControlEvents:UIControlEventTouchUpInside];
//    [tabbar addSubview:exportBtn];

}

- (void)popControllerAnimate{
    CATransition *transition = [CATransition animation];
    transition.duration = 0.5f;
    transition.type = kCATransitionPush;
    transition.subtype = kCATransitionFromTop;
    [transition setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionDefault]];
    [self.navigationController.view.layer addAnimation:transition forKey:nil];
}

- (void)back{
    
    [self popControllerAnimate];
    [self.navigationController popViewControllerAnimated:NO];

}

//-(void)lastOffset{
//    NSLog(@"左");
//}
//
//- (void)forwardOffset{
//    NSLog(@"右");
//}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
//    [activity startAnimating];
//    [SVProgressHUD show];
    return YES;
}

- (void)webViewDidFinishLoad:(UIWebView *)webView{
//    [activity stopAnimating];
//    [SVProgressHUD dismiss];
    loadLabel.text=self.summly.title;
}


- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
