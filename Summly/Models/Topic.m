//
//  Topic.m
//  Summly
//
//  Created by zzlmilk on 12-12-13.
//  Copyright (c) 2012年 zzlmilk. All rights reserved.
//

#import "Topic.h"
#import "SummlyAPIClient.h"
@implementation Topic

-(id)initWithAttributes:(NSDictionary *)attributes{
    self= [super init];
    if (self) {
        self.title = [attributes objectForKey:@"title"];
        self.subTitle = [attributes objectForKey:@"subTitle"];
        self.source = [attributes objectForKey:@"source"];
        self.status = [[attributes objectForKey:@"status"] intValue];
    }
    return self;
}

+(void)getDefaultTopicsParameters:(NSDictionary *)parameters WithBlock:(void (^)(NSMutableArray *))block{
    [[SummlyAPIClient sharedClient] getPath:@"home/index" parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (debug) {
            //NSLog(@"%@",responseObject);
        }
          
     NSArray *arr  = (NSArray *)[responseObject objectForKey:@"topics"];
     if (arr.count>0){
        NSMutableArray *topics = [NSMutableArray arrayWithCapacity:arr.count];
         for (NSDictionary *attributes in arr){
             Topic *t = [[Topic alloc]initWithAttributes:attributes];
             [topics addObject:t];
         }
         
            block(topics);
     }
     
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (debug) {
            //NSLog(@"%@",error);
        }
        block(nil);
    }];
}
@end
