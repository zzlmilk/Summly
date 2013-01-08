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

- (id)initWithFrame:(CGRect)frame summlys:(NSArray *)_summlys
{
    self = [super initWithFrame:frame];
    if (self) {
           
        for (int i=0; i<_summlys.count; i++) {
            
            [self creatActicleViews:i summly:[_summlys objectAtIndex:i]];
            
        }
    }
    return self;
}

- (void)creatActicleViews:(NSInteger)index summly:(Summly*)_summly{
    
    //文章
    UIView *acticleView = [[UIView alloc] initWithFrame:CGRectMake(self.frame.size.width*index, 0, self.frame.size.width, self.frame.size.height)];
    [acticleView setBackgroundColor:[UIColor whiteColor]];
    
    UIImageView *iconImageView = [[UIImageView alloc] initWithFrame:CGRectMake(MarginDic, 18,  30, 12)];
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
    
    UILabel *articleLabel = [[UILabel alloc] initWithFrame:CGRectMake(MarginDic, iconImageView.frame.size.height+iconImageView.frame.origin.y+MarginDic, self.frame.size.width-MarginDic*2, acticleView.frame.size.height-(iconImageView.frame.size.height+iconImageView.frame.origin.y+MarginDic)-25)];
    articleLabel.userInteractionEnabled=YES;
    [articleLabel setFont:[UIFont systemFontOfSize:15]];
    articleLabel.text = _summly.describe;
    articleLabel.numberOfLines = 0;
    [articleLabel setBackgroundColor:[UIColor clearColor]];
    [articleLabel sizeToFit];
    [acticleView addSubview:articleLabel];
    
    [self addSubview:acticleView];
    



}

@end
