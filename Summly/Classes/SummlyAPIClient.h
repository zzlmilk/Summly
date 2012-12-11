//
//  SummlyAPIClient.h
//  Summly
//
//  Created by zzlmilk on 12-12-7.
//  Copyright (c) 2012年 zzlmilk. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFHTTPClient.h"

@interface SummlyAPIClient : AFHTTPClient
+(SummlyAPIClient *) sharedClient;
@end
