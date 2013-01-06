//
//  Update.h
//  Summly
//
//  Created by Mars on 13-1-1.
//  Copyright (c) 2013年 zzlmilk. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Update : NSObject

-(id)initWithAttributes:(NSDictionary *)attributes;


//获取defalut的topic列表
+(void)getDefaultVersionParameters:(NSDictionary *)parameters WithBlock:(void (^)(NSMutableArray *))block;

@end