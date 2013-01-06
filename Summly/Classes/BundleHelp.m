//
//  BundleHelp.m
//  Summly
//
//  Created by zoe on 12-12-24.
//  Copyright (c) 2012年 zzlmilk. All rights reserved.
//

#import "BundleHelp.h"

@implementation BundleHelp

+(NSString *)getBundlePath:(NSString *)_path{
        
    NSArray*paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *path = [paths objectAtIndex:0];
    NSString *filename = [path stringByAppendingPathComponent:_path];

    NSString *str = filename;
    return str;
}

+(NSDictionary *)getDictionaryFromPlist:(NSString *)_path{
        
//    NSArray*paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *filename = [path stringByAppendingPathComponent:_path];
    
    NSDictionary* dic = [NSDictionary dictionaryWithContentsOfFile:filename];  //读取数据
    
    return dic;
}

+(void)removeBundlePath:(NSString *)path{
    
    


}



@end
