//
//  ArticleView.m
//  Summly
//
//  Created by zoe on 12-12-27.
//  Copyright (c) 2012年 zzlmilk. All rights reserved.
//

#define MarginDic 15

#import "ArticleView.h"

@implementation ArticleView

- (id)initWithFrame:(CGRect)frame summly:(Summly *)_summly
{
    self = [super initWithFrame:frame];
    if (self) {
        //文章
        acticleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        [acticleView setBackgroundColor:[UIColor whiteColor]];
        
        UIImageView *iconImageView = [[UIImageView alloc] initWithFrame:CGRectMake(MarginDic, 18, 22, 22)];
        [iconImageView setImage:[UIImage imageNamed:@"publisherIcon.png"]];
        iconImageView.userInteractionEnabled=YES;
        [acticleView addSubview:iconImageView];
        
        UILabel *pulisherLabel = [[UILabel alloc] initWithFrame:CGRectMake(iconImageView.frame.size.width+iconImageView.frame.origin.x+MarginDic, 20, 100, 16)];
        pulisherLabel.userInteractionEnabled=YES;
        [pulisherLabel setFont:[UIFont boldSystemFontOfSize:12]];
        if (_summly.scource.length==0) {
            pulisherLabel.text = @"雅虎通讯";
        }
        else{
            pulisherLabel.text = _summly.scource;
        }
        [pulisherLabel setBackgroundColor:[UIColor clearColor]];
        [pulisherLabel sizeToFit];
        [acticleView addSubview:pulisherLabel];
        
        UILabel *timeIntervalLabel = [[UILabel alloc] initWithFrame:CGRectMake(pulisherLabel.frame.size.width+pulisherLabel.frame.origin.x+MarginDic, pulisherLabel.frame.origin.y, 100, 16)];
        timeIntervalLabel.userInteractionEnabled=YES;
        [timeIntervalLabel setFont:[UIFont systemFontOfSize:12]];
        [timeIntervalLabel setTextColor:[UIColor colorWithRed:153/255.0f green:153/255.0f blue:153/255.0f alpha:1.0f]];
        timeIntervalLabel.text=_summly.interval;
        [timeIntervalLabel sizeToFit];
        [timeIntervalLabel setBackgroundColor:[UIColor clearColor]];
        [acticleView addSubview:timeIntervalLabel];
        
        UILabel *articleLabel = [[UILabel alloc] initWithFrame:CGRectMake(MarginDic, iconImageView.frame.size.height+iconImageView.frame.origin.y+MarginDic, frame.size.width-MarginDic*2, acticleView.frame.size.height-(iconImageView.frame.size.height+iconImageView.frame.origin.y+MarginDic)-25)];
        articleLabel.userInteractionEnabled=YES;
        [articleLabel setFont:[UIFont systemFontOfSize:15]];
        articleLabel.text = _summly.describe;
        articleLabel.numberOfLines = 0;
        [articleLabel setBackgroundColor:[UIColor clearColor]];
        [articleLabel sizeToFit];
        [acticleView addSubview:articleLabel];
        
        [self addSubview:acticleView];

    
    
    }
    return self;
}


@end
