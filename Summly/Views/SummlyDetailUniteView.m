//
//  SummlyDetailUniteView.m
//  Summly
//
//  Created by zoe on 13-1-8.
//  Copyright (c) 2013年 zzlmilk. All rights reserved.
//

#import "SummlyDetailUniteView.h"

@implementation SummlyDetailUniteView

- (id)initWithFrame:(CGRect)frame summlys:(NSArray *)summlys
{
    self = [super initWithFrame:frame];
    if (self) {
        
        _upScrollView = [[UpScrollView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, 183.5) summlys:summlys];
        [self addSubview:_upScrollView];
        
        _titleView = [[TitleView alloc] initWithFrame:CGRectMake(10, 183.5-110, frame.size.width, 100) summlys:summlys];
        [self addSubview:_titleView];
        
//        _articleView = [[ArticleView alloc] initWithFrame:CGRectMake(0, _upScrollView.frame.size.height, frame.size.width, frame.size.height-183.5) summlys:summlys];
//        [self addSubview:_articleView];
        
    }
    return self;
}


@end
