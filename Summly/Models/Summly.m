//
//  Summly.m
//  Summly
//
//  Created by zzlmilk on 12-12-10.
//  Copyright (c) 2012年 zzlmilk. All rights reserved.
//

#import "Summly.h"

@implementation Summly

-(id)initWithAttributes:(NSDictionary *)attributes{
    self = [super init];
    if (self) {
        
        self.title = @"title a";
        self.describe = @"describe a";
    }
    return self;
}
@end
