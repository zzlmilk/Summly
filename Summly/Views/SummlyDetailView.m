//
//  SummlyDetailView.m
//  Summly
//
//  Created by zoe on 12-12-17.
//  Copyright (c) 2012年 zzlmilk. All rights reserved.
//

#import "SummlyDetailView.h"
#define MarginDic 10

@implementation SummlyDetailView
@synthesize summly;

- (id)initWithFrame:(CGRect)frame summly:(Summly *)_summly
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.summly =_summly;
        //标题
        UIImageView *imageBackView = [[UIImageView alloc] initWithFrame:CGRectMake(0,0, frame.size.width, 183.5)];
        NSString *randomImageName = [NSString stringWithFormat:@"grad%d@2x.png", arc4random() % 10];
        imageBackView.image = [UIImage imageNamed:randomImageName];
        [self addSubview:imageBackView];
        
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(MarginDic, imageBackView.frame.size.height-110, frame.size.width-20, 150)];
        [titleLabel setBackgroundColor:[UIColor clearColor]];
        [titleLabel setNumberOfLines:0];
        [titleLabel setFont:[UIFont systemFontOfSize:20]];
        [titleLabel setTextColor:[UIColor whiteColor]];
        titleLabel.shadowColor = [UIColor blackColor];
        titleLabel.shadowOffset = CGSizeMake(0, 0.8);
        titleLabel.text = self.summly.title;
        [self addSubview:titleLabel];
        
        //文章
        UIView *acticleView = [[UIView alloc] initWithFrame:CGRectMake(0, imageBackView.frame.size.height, frame.size.width, frame.size.height-imageBackView.frame.size.height)];
        [acticleView setBackgroundColor:[UIColor whiteColor]];
        
        UIImageView *iconImageView = [[UIImageView alloc] initWithFrame:CGRectMake(MarginDic, 18, 22, 22)];
        [iconImageView setImage:[UIImage imageNamed:@"publisherIcon.png"]];
        [acticleView addSubview:iconImageView];
        
        UILabel *pulisherLabel = [[UILabel alloc] initWithFrame:CGRectMake(iconImageView.frame.size.width+iconImageView.frame.origin.x+MarginDic, 20, 100, 16)];
        [pulisherLabel setFont:[UIFont boldSystemFontOfSize:12]];
        if (self.summly.scource.length==0) {
            pulisherLabel.text = @"雅虎通讯";
        }
        else{
            pulisherLabel.text = self.summly.scource;
        }
        [pulisherLabel setBackgroundColor:[UIColor clearColor]];
        [pulisherLabel sizeToFit];
        [acticleView addSubview:pulisherLabel];
        
        UILabel *timeIntervalLabel = [[UILabel alloc] initWithFrame:CGRectMake(pulisherLabel.frame.size.width+pulisherLabel.frame.origin.x+MarginDic, pulisherLabel.frame.origin.y, 100, 16)];
        [timeIntervalLabel setFont:[UIFont systemFontOfSize:12]];
        [timeIntervalLabel setTextColor:[UIColor colorWithRed:153/255.0f green:153/255.0f blue:153/255.0f alpha:1.0f]];
        timeIntervalLabel.text=self.summly.interval;
        [timeIntervalLabel sizeToFit];
        [acticleView addSubview:timeIntervalLabel];
        
        UILabel *articleLabel = [[UILabel alloc] initWithFrame:CGRectMake(MarginDic, iconImageView.frame.size.height+iconImageView.frame.origin.y+MarginDic, frame.size.width-MarginDic*2, acticleView.frame.size.height-(iconImageView.frame.size.height+iconImageView.frame.origin.y+MarginDic)-25)];
        [articleLabel setFont:[UIFont systemFontOfSize:15]];
        articleLabel.text = [self removeSpace:self.summly.describe];
        articleLabel.numberOfLines = 0;
        [acticleView addSubview:articleLabel];
     
    
        [self addSubview:acticleView];

    }
    return self;
}

- (NSString *)removeSpace:(NSString *)text{

    NSString *temp = [text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    return temp;
}
@end
