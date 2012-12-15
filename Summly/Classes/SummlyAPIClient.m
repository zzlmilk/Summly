//
//  SummlyAPIClient.m
//  Summly
//
//  Created by zzlmilk on 12-12-7.
//  Copyright (c) 2012年 zzlmilk. All rights reserved.
//

#import "SummlyAPIClient.h"

#import "AFJSONRequestOperation.h"

//static NSString * const kAFSummlyAPIBaseURLString = @"https://api.weibo.com/2/";
static NSString * const kAFSummlyAPIBaseURLString = @"http://localhost:3000/";
@implementation SummlyAPIClient
+(SummlyAPIClient *)sharedClient{
    static SummlyAPIClient *_sharedClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedClient = [[SummlyAPIClient alloc] initWithBaseURL:[NSURL URLWithString:kAFSummlyAPIBaseURLString]];
    });
    
    return _sharedClient;
}



- (id)initWithBaseURL:(NSURL *)url {
    self = [super initWithBaseURL:url];
    if (!self) {
        return nil;
    }
    [self registerHTTPOperationClass:[AFJSONRequestOperation class]];    
    // Accept HTTP Header; see http://www.w3.org/Protocols/rfc2616/rfc2616-sec14.html#sec14.1
	[self setDefaultHeader:@"Accept" value:@"application/json"];
    
    return self;
}


@end
