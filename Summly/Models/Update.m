//
//  Update.m
//  Summly
//
//  Created by Mars on 13-1-1.
//  Copyright (c) 2013年 zzlmilk. All rights reserved.
//

#import "Update.h"
#import "SummlyAPIClient.h"
@implementation Update

-(id)initWithAttributes:(NSDictionary *)attributes{
    self= [super init];
    if (self) {
        
    }
    return self;
}


+(void)getDefaultVersionParameters:(NSDictionary *)parameters WithBlock:(void (^)(NSMutableArray *))block{
    
    
    [[SummlyAPIClient sharedClient] getPath:@"version/currentVersion" parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSArray *responseArr = (NSArray*)responseObject;
        
        NSMutableArray *summlyArr = [[NSMutableArray alloc] init];
        NSDictionary *arr = (NSDictionary *)[responseArr objectAtIndex:0];

        summlyArr = (NSMutableArray *)[arr objectForKey:@"version"];
        
        if (block) {
            block(summlyArr);
        }
        if (debug) {
            NSLog(@"%@",responseObject);
            
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error);
    }];
    
}
@end
