//
//  FrontSummlyView.m
//  Summly
//
//  Created by zzlmilk on 12-12-11.
//  Copyright (c) 2012年 zzlmilk. All rights reserved.
//

#import "FrontSummlyView.h"
#import "Cover.h"
#define left 20

@implementation FrontSummlyView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        int y = self.frame.size.height-225;
        
        self.coverArr=[[NSDictionary alloc] init];
       [Cover getDefaultCoverParameters:nil WithBlock:^(NSMutableArray *summlys) {
            self.coverArr=(NSDictionary *)summlys;
           
           //标题内容
           UITextView *titleLabel=[[UITextView
                                    alloc] initWithFrame:CGRectMake(left-10, y+35, 230, 100)];
           titleLabel.scrollEnabled = YES;
           titleLabel.editable = NO;//禁止编辑
           //titleLabel.text = @"Mailbox：Sparrow 和 Clear 附身的 iPhone 邮件客户端";
           titleLabel.text = [self.coverArr objectForKey:@"title"];
           titleLabel.autoresizingMask = UIViewAutoresizingFlexibleHeight;
           titleLabel.backgroundColor = nil;
           titleLabel.textColor = [UIColor whiteColor];
           titleLabel.font = [UIFont fontWithName:@"ArialRoundedMTBold" size:22];
           [self addSubview: titleLabel];
           
           
           
           
           //分隔按钮
           UIImageView  *trendingImageView = [[UIImageView alloc] initWithFrame:CGRectMake(20,y + 125,120,20)];
           trendingImageView.image = [UIImage imageNamed:@"trending-label@2x.png"];//加载入图片
           [self addSubview:trendingImageView];
           
           
           UILabel *consourceLabel = [[UILabel alloc]initWithFrame:CGRectMake(left, y +135, 120, 17)];
           consourceLabel.backgroundColor = [UIColor clearColor];
           consourceLabel.text = @"近日趋势";
           consourceLabel.font = [UIFont fontWithName:@"Thonburi" size:15];
           consourceLabel.textColor = [UIColor whiteColor];
           [self addSubview:consourceLabel];
           
           
           UILabel *mediaLabel = [[UILabel alloc]initWithFrame:CGRectMake(left, y + 155, 140, 13)];
           mediaLabel.backgroundColor = [UIColor clearColor];
           mediaLabel.text = @"http://www.ifanr.com";
           mediaLabel.font = [UIFont systemFontOfSize:11];
           mediaLabel.textColor = [UIColor whiteColor];
           [self addSubview:mediaLabel];
           
           
           UILabel *typeLabel = [[UILabel alloc]initWithFrame:CGRectMake(left, y + 170, 120, 13)];
           typeLabel.backgroundColor = [UIColor clearColor];
           typeLabel.text = @"Technology";
           typeLabel.font = [UIFont systemFontOfSize:11];
           typeLabel.textColor = [UIColor whiteColor];
           [self addSubview:typeLabel];
           

           
        }];
        
        
        //设定当前日期
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init] ;
        [dateFormatter setDateFormat:@"yyyy/MM/dd"];
        NSDate *date = [NSDate date];
        NSString * s = [dateFormatter stringFromDate:date];
        NSArray *array = [s componentsSeparatedByString:@"/"];
        NSString *day = [NSString stringWithFormat:@"%@",[array objectAtIndex:2]];
        
        UILabel *timeLabel = [[UILabel alloc]initWithFrame:CGRectMake(left, 0, 140, 66)];
        timeLabel.backgroundColor = [UIColor clearColor];
        timeLabel.text = day;
        timeLabel.font = [UIFont fontWithName:@"Trebuchet-BoldItalic" size:60];
        
        
        timeLabel.textColor = [UIColor whiteColor];
        [self addSubview:timeLabel];
        
        
        UILabel *riLabel = [[UILabel alloc]initWithFrame:CGRectMake(left+70, 25, 170, 32)];
        riLabel.backgroundColor = [UIColor clearColor];
        riLabel.text = @"日";
        riLabel.font = [UIFont fontWithName:@"ArialRoundedMTBold" size:30];
        riLabel.textColor = [UIColor whiteColor];
        [self addSubview:riLabel];
        
        
        
        NSCalendar *calendar = [NSCalendar currentCalendar];
        NSDateComponents *comps;
        comps =[calendar components:(NSWeekCalendarUnit | NSWeekdayCalendarUnit |NSWeekdayOrdinalCalendarUnit)
                
                           fromDate:date];
        
        NSInteger weekday = [comps weekday]; // 星期几（注意，周日是“1”，周一是“2”。。。。）
        NSArray *weekdic = [[NSArray alloc] initWithObjects:@"星期一",@"星期二",@"星期三",@"星期四",@"星期五",@"星期六",@"星期天",nil];
        
        UILabel *unreadLabel = [[UILabel alloc]initWithFrame:CGRectMake(left, 60, 200, 35)];
        unreadLabel.backgroundColor = [UIColor clearColor];
        unreadLabel.text = [weekdic objectAtIndex:weekday-1];
        unreadLabel.font = [UIFont fontWithName:@"Thonburi" size:35];
        unreadLabel.textColor = [UIColor whiteColor];
        [self addSubview:unreadLabel];
        
        
        UILabel *doudouLabel = [[UILabel alloc]initWithFrame:CGRectMake(left, 97, 140, 14)];
        doudouLabel.backgroundColor = [UIColor clearColor];
        doudouLabel.text = @"DOU DOU Technologies";
        doudouLabel.font = [UIFont fontWithName:@"Thonburi-Bold" size:11];
        doudouLabel.textColor = [UIColor whiteColor];
        [self addSubview:doudouLabel];
        
        UILabel *summaryLabel = [[UILabel alloc]initWithFrame:CGRectMake(left, 114, 170, 13)];
        summaryLabel.backgroundColor = [UIColor clearColor];
        summaryLabel.text = @"豆豆科技新闻";
        summaryLabel.font = [UIFont fontWithName:@"Thonburi-Bold" size:13];
        summaryLabel.textColor = [UIColor whiteColor];
        [self addSubview:summaryLabel];
        
        
                
        //回退按钮
        //        UIImageView  *backImageView = [[UIImageView alloc] initWithFrame:CGRectMake(270,10,34,34)];
        //        backImageView.image = [UIImage imageNamed:@"cover-arrow@2x.png"];//加载入图片
        //        [self addSubview:backImageView];
        
        UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
        backButton = [[UIButton alloc]initWithFrame:CGRectMake(270,25,34,34)];
        [backButton setBackgroundImage:[UIImage imageNamed:@"cover-arrow@2x.png"] forState:UIControlStateNormal];
        [backButton addTarget:self action:@selector(backbuttonCheck) forControlEvents:UIControlEventTouchDown];
        [self addSubview:backButton];
    }
    
    return self;
}

-(void)backbuttonCheck
{
    [self.delegate backbuttonDidSelect];
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
