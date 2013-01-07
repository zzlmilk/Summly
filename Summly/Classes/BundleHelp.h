//
//  BundleHelp.h
//  Summly
//
//  Created by zoe on 12-12-24.
//  Copyright (c) 2012年 zzlmilk. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BundleHelp : NSObject


+(NSDictionary *)getDictionaryFromPlist:(NSString *)path;
+(NSString *)getBundlePath:(NSString *)path;
+(void)removeBundlePath:(NSString *)path;
+(void)moveOldPathToNewPath;
//+(NSArray *)getArrayFromPlist;
+(void)writeToFile:(id)dic toPath:(NSString *)_path;
+(BOOL)fileManagerfileExistsAtPath:(NSString *)_path;

@end
