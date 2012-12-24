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
    
  //  NSFileManager *fileManager = [NSFileManager defaultManager];
    
    NSArray*paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *path = [paths objectAtIndex:0];
    NSString *filename = [path stringByAppendingPathComponent:_path];
    
//    NSString *oldPath = [[NSBundle mainBundle] pathForResource:_path ofType:nil];
//    
//    NSString *str;
//    if (oldPath) {
//       BOOL moveSuccess = [fileManager moveItemAtPath:oldPath toPath:filename error:NULL];
//        NSLog(@"%c",moveSuccess);
//        str = filename;
//    }
//    else    
//        str = oldPath;
    NSString *str = filename;
    return str;
}

+(NSDictionary *)getDictionaryFromPlist:(NSString *)_path{
    
   // NSFileManager *fileManager = [NSFileManager defaultManager];
    
    NSArray*paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *path = [paths objectAtIndex:0];
    NSString *filename = [path stringByAppendingPathComponent:_path];
    
   // NSString *oldPath = [[NSBundle mainBundle] pathForResource:_path ofType:nil];
    
    NSString *str = filename;
//    if (oldPath) {
//        BOOL moveSuccess = [fileManager moveItemAtPath:oldPath toPath:filename error:NULL];
//        NSLog(@"chushi ---%d",moveSuccess);
//        str = filename;
//    }
//    else
//        str = oldPath;
    
    NSDictionary* dic = [NSDictionary dictionaryWithContentsOfFile:str];  //读取数据
    
    return dic;
}




@end
