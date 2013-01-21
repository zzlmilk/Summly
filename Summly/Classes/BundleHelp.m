//
//  BundleHelp.m
//  Summly
//
//  Created by zoe on 12-12-24.
//  Copyright (c) 2012年 zzlmilk. All rights reserved.
//

#import "BundleHelp.h"
#import "DBConnection.h"

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
    NSLog(@"filename---%@",filename);
//    NSLog(@"dic---%@",dic);

    return dic;
}

+(void)removeBundlePath:(NSString *)path{
    
    


}

+(void)moveOldPathToNewPath{

    NSError *error;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *documentPath = [[self class] getBundlePath:MAIN_DATABASE_NAME];

    NSString  *oldDBPath = [[NSBundle mainBundle] pathForResource:@"summlydatabase" ofType:@"sql"];
    
    BOOL success = [fileManager moveItemAtPath:oldDBPath toPath:documentPath error:&error];

    NSLog(@"error%@,%d",error,success);
}

+(void)writeToFile:(id)dic toPath:(NSString *)_path{
//    NSString *error;
    NSString *document = [[self class] getBundlePath:_path];

//    NSData *dicData = [NSPropertyListSerialization dataFromPropertyList:dic format:NSPropertyListXMLFormat_v1_0 errorDescription:&error];
    BOOL writeSuccess = [dic writeToFile:document atomically:YES ];

    NSLog(@"writeSuccess%d",writeSuccess);
}

+(BOOL)fileManagerfileExistsAtPath:(NSString *)_path{

    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    NSString *document = [[self class] getBundlePath:_path];
    
    if ([fileManager fileExistsAtPath:document]) {
        return YES;
    }

    return NO;
}

@end
