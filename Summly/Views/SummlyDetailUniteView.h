//
//  SummlyDetailUniteView.h
//  Summly
//
//  Created by zoe on 13-1-8.
//  Copyright (c) 2013年 zzlmilk. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "UpScrollView.h"
#import "ArticleView.h"
#import "TitleView.h"

@interface SummlyDetailUniteView : UIScrollView


@property(nonatomic,strong) UpScrollView *upScrollView;
@property(nonatomic,strong) ArticleView *articleView;
@property(nonatomic,strong) TitleView *titleView;

- (id)initWithFrame:(CGRect)frame summlys:(NSArray *)summlys;

@end
