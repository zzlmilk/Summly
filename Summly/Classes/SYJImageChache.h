//
//  SYJImageChache.h
//  SyjRedess
// 参考 AFNetworing+UIImageView 
//  Created by rex on 12-9-6.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SYJImageChache : NSCache

+(SYJImageChache *) shareCache;
-(UIImage *) cacheImageForURL:(NSURL*)url;

-(void) imageForUrl:(NSURL*)url completionBlock:(void(^)(UIImage *image))completion;

-(UIImage *)imageFromDiskForURL:(NSURL *)url;

-(void) setImage:(UIImage *)i forURL:(NSURL*)url;
-(void) removeImageForURL:(NSString*)url;

-(void) writeData:(NSData *)data toPath:(NSString *)path;
-(void) performDiskWriteOperation:(NSInvocation *)invocation;


- (void)storeImage:(UIImage*)image forKey:(NSURL*)key;
- (void)storeData:(NSData*)data forKey:(NSURL*)key;


@end


@protocol SYJImageChacheDelegate <NSObject>
@optional

-(void) cache:(SYJImageChache*)imageCache didDownloadImage:(UIImage*)image forURL:(NSURL*)url;

@end
