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


+(void)getDefaultCoverParameters:(NSDictionary *)parameters WithBlock:(void (^)(Summly *))block{
    
    
    [[SummlyAPIClient sharedClient] getPath:@"cover/index" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
//        NSMutableArray *summlyArr = [[NSMutableArray alloc] init];
        NSDictionary *arr = [responseObject objectForKey:@"cover"];
        
        Summly *summly = [[Summly alloc] initWithAttributes:[arr objectForKey:@"summly"]];
        
//        summlyArr = (NSMutableArray *)[arr objectForKey:@"summly"];
        
        if (block) {
            block(summly);
        }
        if (debug) {
            NSLog(@"%@",responseObject);

        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error);
    }];

}
@end
