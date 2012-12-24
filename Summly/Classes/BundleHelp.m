//
//  BundleHelp.m
//  Summly
//
//  Created by zoe on 12-12-24.
//  Copyright (c) 2012年 zzlmilk. All rights reserved.
//

#import "BundleHelp.h"

@implementation BundleHelp

+(NSString *)getBundlePath:(NSString *)path{

    NSString *str = [[NSBundle mainBundle] pathForResource:path ofType:nil];
    return str;
}

+(NSDictionary *)getDictionaryFromPlist:(NSString *)path{

    NSString *str = [[NSBundle mainBundle] pathForResource:path ofType:nil];
    NSDictionary* dic = [NSDictionary dictionaryWithContentsOfFile:str];  //读取数据
    
    return dic;
}




@end
