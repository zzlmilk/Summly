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

        self.title = @"title a";
        self.describe = @"describe a";        
    }
    
    return self;
}

+(void)getSummlysParameters:(NSDictionary *)parameters WithBlock:(void (^)(NSMutableArray *))block{
    
    [[SummlyAPIClient sharedClient] getPath:@"summly/index" parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
                
        NSLog(@"%@",responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"%@",error);
    }];
    
}
@end
