//
//  Summly.h
//  Summly
//
//  Created by zzlmilk on 12-12-10.
//  Copyright (c) 2012年 zzlmilk. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Summly : NSObject

@property(nonatomic,strong)NSString *title;
@property(nonatomic,strong)NSString *describe;


- (id)initWithAttributes:(NSDictionary *)attributes;

@end
