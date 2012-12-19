//
//  WebViewController.h
//  Summly
//
//  Created by lostkid on 12-12-19.
//  Copyright (c) 2012年 zzlmilk. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Summly.h"
#import "BaseViewController.h"
#import "SVProgressHUD.h"

@interface WebViewController : BaseViewController<UIWebViewDelegate>
{
    UILabel *loadLabel;
    UIActivityIndicatorView *activity;
}
@property(nonatomic,strong) Summly *summly;
@end
