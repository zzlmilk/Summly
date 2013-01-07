//
//  Summly.h
//  Summly
//
//  Created by zzlmilk on 12-12-10.
//  Copyright (c) 2012年 zzlmilk. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Summly : NSObject

@property(nonatomic) NSInteger topicId;
@property(nonatomic,strong)NSString *title;
@property(nonatomic,strong)NSString *describe;
@property(nonatomic,strong)NSString *scource;
@property(nonatomic,strong)NSDate * summlyTime;
@property(nonatomic,strong)NSString *imageUrl;
@property(nonatomic,strong)NSString *sourceUrl;
@property(nonatomic,strong)NSString *interval;
<<<<<<< HEAD
@property(nonatomic,strong)NSMutableString *time;
=======
@property(nonatomic,strong)NSString *time;
>>>>>>> b5c5ee2d1f2ceb92793d7b841c177f9c08566223


- (id)initWithAttributes:(NSDictionary *)attributes;

+(void)getSummlysParameters:(NSDictionary *)parameters WithBlock:(void (^)(NSMutableArray *summlys))block;
-(void)insertDB;
@end
