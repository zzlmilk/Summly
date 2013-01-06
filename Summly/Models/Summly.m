//
//  Summly.m
//  Summly
//
//  Created by zzlmilk on 12-12-10.
//  Copyright (c) 2012年 zzlmilk. All rights reserved.
//

#import "Summly.h"
#import "SummlyAPIClient.h"
#import "DBConnection.h"


@implementation Summly
@synthesize title,describe,scource,imageUrl,interval,sourceUrl;

-(id)initWithAttributes:(NSDictionary *)attributes{
    self = [super init];
    if (self) {

        self.topicId = [[attributes objectForKey:@"topic_id"] intValue];
        self.title = [attributes objectForKey:@"title"];
        self.describe =  [self removeSpace:[attributes objectForKey:@"content"]];
        if (self.scource.length==0) {
            self.scource = @"雅虎通讯";
        }else{
            self.scource = [attributes objectForKey:@"source"];//来源
        }
        self.sourceUrl = [attributes objectForKey:@"url"];
        self.imageUrl = [attributes objectForKey:@"imageUrl"];
        
        self.time = [attributes objectForKey:@"time"];
        
        _summlyTime =  [self stringDateToNSDate:self.time];

        //年-月-日
        self.time = [self stringReplace];
        
        self.interval = [self timeIntervalFromNow:_summlyTime];
        
    }
    
    return self;
}

//年-月-日
- (NSString *)stringReplace{
    NSString *timeNow;

    NSRange range = NSMakeRange(4, 1);
    NSRange range1 = NSMakeRange(7, 1);
    
    timeNow = [self.time stringByReplacingOccurrencesOfString:@"-" withString:@"年" options:NSCaseInsensitiveSearch range:range];
    timeNow = [timeNow stringByReplacingOccurrencesOfString:@"-" withString:@"月" options:NSBackwardsSearch range:range1];

    timeNow = [timeNow stringByAppendingFormat:@"日"];
    
    return timeNow;
}

- (NSString *)removeSpace:(NSString *)text{
    
    NSString *temp = [text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    return temp;
}
//时间差
- (NSString *)timeIntervalFromNow:(NSDate *)_summlyTime{
    NSString *intervalStr;
    double timeInterval = 0.0f;
    timeInterval = [[NSDate date] timeIntervalSinceDate:self.summlyTime];
    NSInteger _interval = (int)timeInterval/3600;
    
    if (_interval >=24) {
        _interval = (int)_interval/24;
        intervalStr = [NSString stringWithFormat:@"%d 天前",_interval];
        return intervalStr;
    }
    else if(_interval <24 && _interval>1){
        intervalStr = [NSString stringWithFormat:@"%d 小时前",_interval];
        
        return intervalStr;
    }
    return nil;
}

//stringFromDate
-(NSDate *)stringDateToNSDate:(NSString *)string {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    NSTimeZone *timeZone = [NSTimeZone localTimeZone];
    [formatter setTimeZone:timeZone];
    [formatter setDateFormat: @"yyyy-MM-dd"];
    NSDate *date = [formatter dateFromString:string];

    return date;
}

+(void)getSummlysParameters:(NSDictionary *)parameters WithBlock:(void (^)(NSMutableArray *))block{
    
    NSArray *summlyArr = [Summly summlysWithParameters:parameters];
    if (summlyArr.count>0) {
        block( summlyArr );

    }
    [[SummlyAPIClient sharedClient] getPath:@"summly/index" parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSMutableArray *summlyArr = [[NSMutableArray alloc] init];
        NSArray *responseArr = (NSArray*)responseObject;
                
        for (int i=0;i<responseArr.count;i++) {
            Summly *summly = [[Summly alloc] initWithAttributes:[[responseArr objectAtIndex:i] objectForKey:@"summly"]];
            [summlyArr addObject:summly];
            [summly insertDB];
        }
        if (block) {
            block(summlyArr);
        }
        NSLog(@"%@",responseObject);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"%@",error);
        block([Summly summlysWithParameters:parameters]);
    }];
    
}


#pragma mark --- DB

+(Summly *)initWithStatement:(Statement *)stmt{
    Summly *s   = [[Summly alloc] init] ;
    
    s.topicId = [stmt getInt32:0];
    s.title = [stmt getString:2];
    s.describe = [stmt getString:3];
    s.scource = [stmt getString:4];
    s.imageUrl = [stmt getString:5];
    s.time = [stmt getString:5];

    return s;
    
}


+(NSMutableArray *)summlysWithParameters:(NSDictionary *)parametrs{
    
    NSMutableArray *summlys = [[NSMutableArray alloc]initWithCapacity:15];
    
    static Statement *stmt = nil;
    if (stmt == nil) {
        stmt = [DBConnection statementWithQuery:"SELECT * FROM summly_table LIMIT 6 "];
    }
    
    while ([stmt step] == SQLITE_ROW) {
        Summly *p = [Summly initWithStatement:stmt] ;
        [summlys addObject:p];
    }
    [stmt reset];
    return summlys;
    
}

-(void)insertDB{
    static Statement *stmt = nil;
    if (stmt == nil) {
        stmt = [DBConnection statementWithQuery:"INSERT INTO summly_table (topic_id,title,content,source,image_url,time) VALUES(?,?,?,?,?,?)"];
    }
    [stmt bindInt32:self.topicId forIndex:0];
    [stmt bindString:self.title forIndex:1];
    [stmt bindString:self.describe forIndex:2];
    [stmt bindString:self.scource forIndex:3];
    [stmt bindString:self.imageUrl forIndex:4];
    [stmt bindString:self.time forIndex:5];

    int step = [stmt step];
    if (step != SQLITE_DONE) {
		NSLog(@"insert error errorcode =%d ",step);
    }
    [stmt reset];
    
}


@end
