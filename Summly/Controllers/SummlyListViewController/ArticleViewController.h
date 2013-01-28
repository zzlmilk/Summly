//
//  ArticleViewController.h
//  Summly
//
//  Created by zoe on 12-12-18.
//  Copyright (c) 2012年 zzlmilk. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Summly.h"
#import "BaseViewController.h"

@protocol ArticleViewControllerDelegate <NSObject>

- (void)showDetailViewAnimate;

@end

@interface ArticleViewController : BaseViewController

@property(nonatomic,weak) Summly *summly;
@property(nonatomic) NSInteger index;
@property(nonatomic,weak) id<ArticleViewControllerDelegate> delegate;
@end
