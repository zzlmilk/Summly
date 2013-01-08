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
        
        self.summlyDic= attributes;
        self.topicId = [[attributes objectForKey:@"topic_id"] intValue];
        self.title = [attributes objectForKey:@"title"];
        self.describe =  [self removeSpace:[attributes objectForKey:@"content"]];
        
        self.idenId = [[attributes objectForKey:@"id"] intValue];
        
        if (![[attributes objectForKey:@"source"]isKindOfClass:[NSString class]] || [[attributes objectForKey:@"source"]isEqualToString:@""])
            self.scource = @"雅虎通讯";
        else
            self.scource = [attributes objectForKey:@"source"];//来源
        
        if (![[attributes objectForKey:@"url"]isKindOfClass:[NSString class]])
            self.sourceUrl = @"";
        else
            self.sourceUrl = [attributes objectForKey:@"url"];
        
        if (![[attributes objectForKey:@"imageUrl"] isKindOfClass:[NSString class]])
            self.imageUrl =@"";
        else
            self.imageUrl = [attributes objectForKey:@"imageUrl"];
        
        if (![[attributes objectForKey:@"time"]isKindOfClass:[NSString class]])
            self.time = @"";
        else{
            self.time = [attributes objectForKey:@"time"];
            _summlyTime =  [self stringDateToNSDate:self.time];
            //年-月-日
            self.time = [self stringReplace];
            self.interval = [self timeIntervalFromNow:_summlyTime];
            
        }
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
    
    NSMutableArray *summlyArr = [Summly summlysWithParameters:[[parameters objectForKey:@"topic_id"] intValue]];
    if (summlyArr.count>0) {
        block(summlyArr);
        
    }else{
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
            
            //            NSLog(@"%@",responseObject);
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"%@",error);
            block([Summly summlysWithParameters:[[parameters objectForKey:@"topic_id"] intValue]]);
        }];
    }
}


#pragma mark --- DB

+(Summly *)initWithStatement:(Statement *)stmt{
    Summly *s   = [[Summly alloc] init] ;
    
    s.topicId = [stmt getInt32:0];
    s.title = [stmt getString:1];
    s.describe = [stmt getString:2];
    s.scource = [stmt getString:3];
    s.imageUrl = [stmt getString:4];
    s.time = [stmt getString:5];
    s.interval =[stmt getString:6];
    s.idenId = [stmt getInt32:7];
    return s;
    
}


+(NSMutableArray *)summlysWithParameters:(NSInteger)topicId{
    
    NSMutableArray *summlys = [[NSMutableArray alloc]initWithCapacity:15];
    
    static Statement *stmt = nil;
    if (stmt == nil) {
        stmt = [DBConnection statementWithQuery:"SELECT * FROM summly_table WHERE topic_id=?"];
        
    }
    
    [stmt bindInt32:topicId forIndex:1];
    
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
        stmt = [DBConnection statementWithQuery:"INSERT INTO summly_table (topic_id,title,content,source,image_url,time,interval,identifieId) VALUES(?,?,?,?,?,?,?,?)"];
    }
    
    [stmt bindInt32:self.topicId forIndex:1];
    [stmt bindString:self.title forIndex:2];
    [stmt bindString:self.describe forIndex:3];
    [stmt bindString:self.scource forIndex:4];
    [stmt bindString:self.imageUrl forIndex:5];
    [stmt bindString:self.time forIndex:6];
    [stmt bindString:interval forIndex:7];
    [stmt bindInt32:self.idenId forIndex:8];

    
    int step = [stmt step];
    if (step != SQLITE_DONE) {
		NSLog(@"insert error errorcode =%d ",step);
    }
    [stmt reset];
    
}


@end
