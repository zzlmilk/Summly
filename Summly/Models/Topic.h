//
//  Topic.h
//  Summly
//
//  Created by zzlmilk on 12-12-13.
//  Copyright (c) 2012年 zzlmilk. All rights reserved.
//



#import <Foundation/Foundation.h>

typedef enum {
    TopicDefault = 0,
    TopicChecked = 1,
    TopicUnChecked =2
} TopicStatus;

@interface Topic : NSObject

@property(nonatomic) NSInteger topicId;
@property(nonatomic,strong)NSString *title;
@property(nonatomic,strong)NSString *subTitle;
@property(nonatomic,strong)NSString *source;
@property(nonatomic)NSInteger status;


-(id)initWithAttributes:(NSDictionary *)attributes;


//获取defalut的topic列表
+(void)getDefaultTopicsParameters:(NSDictionary *)parameters WithBlock:(void (^)(NSMutableArray *topics))block;


@end
