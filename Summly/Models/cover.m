//
//  Cover.m
//  Summly
//
//  Created by zzlmilk on 12-12-15.
//  Copyright (c) 2012年 zzlmilk. All rights reserved.
//

#import "Cover.h"
#import "SummlyAPIClient.h"

@implementation Cover
-(id)initWithAttributes:(NSDictionary *)attributes{
    self= [super init];
    if (self) {

    }
    return self;
}


+(void)getDefaultCoverParameters:(NSDictionary *)parameters WithBlock:(void (^)(NSMutableArray *))block{
    
    
    [[SummlyAPIClient sharedClient] getPath:@"cover/index" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        
        NSMutableArray *summlyArr = [[NSMutableArray alloc] init];
        NSArray *responseArr = (NSArray*)responseObject;
        
        NSLog(@"responseArr:%@",responseArr);
        

        NSDictionary *arr = (NSDictionary *)[responseObject objectForKey:@"cover"];
        
        summlyArr = (NSMutableArray *)[arr objectForKey:@"summly"];
        
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
