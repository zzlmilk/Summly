//
//  Summly.m
//  Summly
//
//  Created by zzlmilk on 12-12-10.
//  Copyright (c) 2012年 zzlmilk. All rights reserved.
//

#import "Summly.h"
#import "SummlyAPIClient.h"
@implementation Summly

-(id)initWithAttributes:(NSDictionary *)attributes{
    self = [super init];
    if (self) {

        self.title = [attributes objectForKey:@"title"];
        self.describe = [attributes objectForKey:@"content"];
        self.scource = [attributes objectForKey:@"source"];//来源
        self.sourceUrl = [attributes objectForKey:@"url"];
        self.summlyTime = [attributes objectForKey:@"time"];
        self.imageUrl = [attributes objectForKey:@"imageUrl"];
    }
    
    return self;
}

+(void)getSummlysParameters:(NSDictionary *)parameters WithBlock:(void (^)(NSMutableArray *))block{
    
    [[SummlyAPIClient sharedClient] getPath:@"summly/index" parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSMutableArray *summlyArr = [[NSMutableArray alloc] init];
        NSArray *responseArr = (NSArray*)responseObject;
        
        for (int i=0;i<responseArr.count;i++) {
            Summly *summly = [[Summly alloc] initWithAttributes:[responseArr objectAtIndex:i]];
            [summlyArr addObject:summly];
            
        }
        if (block) {
            block(summlyArr);
        }
       // NSLog(@"%@",responseObject);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"%@",error);
    }];
    
}
@end
