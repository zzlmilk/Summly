//
//  Topic.m
//  Summly
//
//  Created by zzlmilk on 12-12-13.
//  Copyright (c) 2012年 zzlmilk. All rights reserved.
//

#import "Topic.h"
#import "SummlyAPIClient.h"
#import "BundleHelp.h"

@implementation Topic

-(id)initWithAttributes:(NSDictionary *)attributes{
    self= [super init];
    if (self) {

        self.topicId = [[attributes objectForKey:@"id"] integerValue];
        self.title = [attributes objectForKey:@"title"];
        self.subTitle = [attributes objectForKey:@"subTitle"];
        self.source = [attributes objectForKey:@"source"];
        self.status = [[attributes objectForKey:@"status"] intValue];
    }
    return self;
}


+(void)getDefaultTopicsParameters:(NSDictionary *)parameters WithBlock:(void (^)(NSMutableArray *))block{
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *filename = [BundleHelp getBundlePath:Plist];
    
    //路径下document下是否存在 存在读取，不存在写入
    if ([fileManager fileExistsAtPath:filename]) {
        NSDictionary *dic = [BundleHelp getDictionaryFromPlist:Plist];
        
            if ([dic isKindOfClass:[NSDictionary class]]) {
                NSArray *arr  = (NSArray *)[dic objectForKey:@"topics"];
                if (arr.count>0){
                    NSMutableArray *topics = [NSMutableArray arrayWithCapacity:arr.count];
                    for (NSDictionary *attributes in arr){
                        Topic *t = [[Topic alloc]initWithAttributes:[attributes objectForKey:@"topic"]];
                        if (t.status==1) {
                            [topics addObject:t];
                    }
                }
                block(topics);
            }
        }
    }
    
    else{
        [[SummlyAPIClient sharedClient] getPath:@"topic/index" parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
            if (debug) {
//                NSLog(@"%@",responseObject);
            }
            //路径下document下是否存在
            if (![fileManager fileExistsAtPath:filename]) {
                
                 NSString *error;
                
                NSData *dicData = [NSPropertyListSerialization dataFromPropertyList:responseObject format:NSPropertyListXMLFormat_v1_0 errorDescription:&error];
                
                BOOL success = [dicData writeToFile:filename atomically:YES];
                if (!success) {
                    NSLog(@"%@",error);
                }
                
                NSLog(@"filewrite--success%d",success);
            }
        
             NSArray *arr  = (NSArray *)[responseObject objectForKey:@"topics"];
             if (arr.count>0){
                NSMutableArray *topics = [NSMutableArray arrayWithCapacity:arr.count];
                 for (NSDictionary *attributes in arr){
                     Topic *t = [[Topic alloc]initWithAttributes:[attributes objectForKey:@"topic"]];
                     if (t.status==1) {
                         [topics addObject:t];
                     }
                 }
                 
                    block(topics);
             }
        
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            if (debug) {
                NSLog(@"%@",error);
            }
            block(nil);
        }];
    }
}
@end
