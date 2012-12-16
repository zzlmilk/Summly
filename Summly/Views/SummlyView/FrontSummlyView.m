//
//  FrontSummlyView.m
//  Summly
//
//  Created by zzlmilk on 12-12-11.
//  Copyright (c) 2012年 zzlmilk. All rights reserved.
//

#import "FrontSummlyView.h"
#define left 20

@implementation FrontSummlyView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        int y = self.frame.size.height-225;
        
        //设定当前日期
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init] ;
        [dateFormatter setDateFormat:@"yyyy/MM/dd"];
        NSDate *date = [NSDate date];
        NSString * s = [dateFormatter stringFromDate:date];
        NSArray *array = [s componentsSeparatedByString:@"/"];
        NSString *day = [NSString stringWithFormat:@"%@日",[array objectAtIndex:2]];
        
        UILabel *timeLabel = [[UILabel alloc]initWithFrame:CGRectMake(left, 10, 100, 50)];
        timeLabel.backgroundColor = [UIColor clearColor];
        timeLabel.text = day;
        timeLabel.font = [UIFont boldSystemFontOfSize:40];
        timeLabel.textColor = [UIColor whiteColor];
        [self addSubview:timeLabel];

        
        UILabel *unreadLabel = [[UILabel alloc]initWithFrame:CGRectMake(left, 60, 170, 13)];
        unreadLabel.backgroundColor = [UIColor clearColor];
        unreadLabel.text = @"未读 Summlys";
        unreadLabel.font = [UIFont systemFontOfSize:13];
        unreadLabel.textColor = [UIColor whiteColor];
        [self addSubview:unreadLabel];
        
    
        UILabel *summaryLabel = [[UILabel alloc]initWithFrame:CGRectMake(left, 80, 170, 13)];
        summaryLabel.backgroundColor = [UIColor clearColor];
        summaryLabel.text = @"网站或文章概要";
        summaryLabel.font = [UIFont systemFontOfSize:13];
        summaryLabel.textColor = [UIColor whiteColor];
        [self addSubview:summaryLabel];
        
        
        //标题内容
        UITextView *titleLabel=[[UITextView
                         alloc] initWithFrame:CGRectMake(left-10, y, 200, 220)];
        titleLabel.scrollEnabled = YES;
        titleLabel.editable = NO;//禁止编辑
        titleLabel.text = @"Mailbox：Sparrow 和 Clear 附身的 iPhone 邮件客户端";
        titleLabel.autoresizingMask = UIViewAutoresizingFlexibleHeight;
        titleLabel.backgroundColor = nil;
        titleLabel.textColor = [UIColor whiteColor];
        titleLabel.font = [UIFont systemFontOfSize:22];
        [self addSubview: titleLabel];
        
        
        
        
        //分隔按钮
        UIImageView  *trendingImageView = [[UIImageView alloc] initWithFrame:CGRectMake(20,y + 130,100,20)];
        trendingImageView.image = [UIImage imageNamed:@"trending-label@2x.png"];//加载入图片
        [self addSubview:trendingImageView];
        
        
        UILabel *consourceLabel = [[UILabel alloc]initWithFrame:CGRectMake(left, y +140, 120, 13)];
        consourceLabel.backgroundColor = [UIColor clearColor];
        consourceLabel.text = @"内容来源";
        consourceLabel.font = [UIFont systemFontOfSize:12];
        consourceLabel.textColor = [UIColor whiteColor];
        [self addSubview:consourceLabel];
        
        
        UILabel *mediaLabel = [[UILabel alloc]initWithFrame:CGRectMake(left, y + 155, 140, 13)];
        mediaLabel.backgroundColor = [UIColor clearColor];
        mediaLabel.text = @"http://www.ifanr.com";
        mediaLabel.font = [UIFont systemFontOfSize:12];
        mediaLabel.textColor = [UIColor whiteColor];
        [self addSubview:mediaLabel];
        
        
        UILabel *typeLabel = [[UILabel alloc]initWithFrame:CGRectMake(left, y + 170, 120, 13)];
        typeLabel.backgroundColor = [UIColor clearColor];
        typeLabel.text = @"Technology";
        typeLabel.font = [UIFont systemFontOfSize:12];
        typeLabel.textColor = [UIColor whiteColor];
        [self addSubview:typeLabel];
        
        
        //回退按钮
//        UIImageView  *backImageView = [[UIImageView alloc] initWithFrame:CGRectMake(270,10,34,34)];
//        backImageView.image = [UIImage imageNamed:@"cover-arrow@2x.png"];//加载入图片
//        [self addSubview:backImageView];
        
        UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
        backButton = [[UIButton alloc]initWithFrame:CGRectMake(270,10,34,34)];
        [backButton setBackgroundImage:[UIImage imageNamed:@"cover-arrow@2x.png"] forState:UIControlStateNormal];
        [backButton addTarget:self action:@selector(backbuttonCheck) forControlEvents:UIControlEventTouchDown];
        [self addSubview:backButton];
    }
    
    return self;
}

-(void)backbuttonCheck
{
    NSLog(@"返回");
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
