//
//  Cover.h
//  Summly
//
//  Created by zzlmilk on 12-12-15.
//  Copyright (c) 2012年 zzlmilk. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Cover : NSObject


-(id)initWithAttributes:(NSDictionary *)attributes;


//获取defalut的topic列表
+(void)getDefaultCoverParameters:(NSDictionary *)parameters WithBlock:(void (^)(NSMutableArray *))block;

@end
