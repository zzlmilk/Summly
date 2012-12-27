//
//  SYJImageChache.m
//  SyjRedess
//
//  Created by rex on 12-9-6.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.

//
#import "SYJImageChache.h"

static NSString *_SYJImageCacheDirectory;

static inline NSString *SYJImageChacheDirectory(){
	if (!_SYJImageCacheDirectory)
	{
		_SYJImageCacheDirectory = [[NSHomeDirectory() stringByAppendingPathComponent:@"Library/Caches/SYJCache"] copy];
	}
	return _SYJImageCacheDirectory;
}

 inline static NSString *keyForURL(NSURL *url){        
 return [NSString stringWithFormat:@"SYJImageCache-%u",[[url absoluteString] hash]];         
}
	

static inline NSString *cachePathForURL(NSURL *key) {
	return [SYJImageChacheDirectory() stringByAppendingPathComponent:keyForURL(key)];
}




 SYJImageChache *_shareCache = nil;
 
 @interface SYJImageChache()
 @property (strong,nonatomic) NSOperationQueue *diskOperationQueue;
 
 -(void) _downloadAndWriteImageForURL:(NSURL *)url completionBlock:(void(^)(UIImage *image))completion;
 
 @end
 
@implementation SYJImageChache
@synthesize diskOperationQueue= _diskOperationQueue;

+ (BOOL)createPathIfNecessary:(NSString*)path {
	BOOL succeeded = YES;
	
	NSFileManager* fm = [NSFileManager defaultManager];
	if (![fm fileExistsAtPath:path]) {
		succeeded = [fm createDirectoryAtPath: path
				  withIntermediateDirectories: YES
								   attributes: nil
										error: nil];
	}
	
	return succeeded;
}

+(SYJImageChache*)shareCache{
	if (!_shareCache)
	{
		_shareCache =[[SYJImageChache alloc] init];
	}
	return _shareCache;
}

-(id) init{
	self = [super init];
	if (!self) return nil;
	
	self.diskOperationQueue = [[NSOperationQueue alloc] init];
        [[NSFileManager defaultManager] createDirectoryAtPath:SYJImageChacheDirectory() 
		withIntermediateDirectories:YES attributes:nil error:NULL];	    

	return self; 
}


- (void) _downloadAndWriteImageForURL:(NSURL *)url completionBlock:(void (^)(UIImage *image))completion {
	//NSInvocation简单使用 http://www.dev3g.com/?p=36
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
       
        NSError *error = nil;
      __unsafe_unretained  NSData *data = [NSData dataWithContentsOfURL:url
                                             options:0
                                               error:&error];
        

        
        
        UIImage *i =  [UIImage imageWithData: data];
                

        
        __unsafe_unretained NSString *cachePath = cachePathForURL(url);
        NSInvocation *writeInvocation = [NSInvocation invocationWithMethodSignature:[self methodSignatureForSelector:@selector(writeData:toPath:)]];
        [writeInvocation setTarget:self];
        [writeInvocation setSelector:@selector(writeData:toPath:)];
        [writeInvocation setArgument:&data atIndex:2];
        [writeInvocation setArgument:&cachePath atIndex:3];        
        
        [self setImage:i forURL:url];
        [self performDiskWriteOperation:writeInvocation];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            if (completion) {
                completion(i);
            } 
        });
    });    
}



-(void) removeAllObjects{
    [super removeAllObjects];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSFileManager *fileManager = [NSFileManager defaultManager];
        NSError *error  = nil;
        NSArray *direcoryContents = [fileManager contentsOfDirectoryAtPath:SYJImageChacheDirectory() error:&error];
        if (error ==nil) {
            for (NSString *path in direcoryContents) {
                NSString *fullPath = [SYJImageChacheDirectory() stringByAppendingPathComponent:path];
                BOOL removeSuccess = [fileManager removeItemAtPath:fullPath error:&error];                
                if (!removeSuccess) {
                    //error
                }
            }
        }
    });
}

-(void) removeObjectForKey:(id)key{
    [super removeObjectForKey:key];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
         NSFileManager *fileManager = [NSFileManager defaultManager];
        NSString *cachePath = cachePathForURL(key);
        NSError *error  = nil;
        
        BOOL removeSuccess = [fileManager removeItemAtPath:cachePath error:&error];
        if (!removeSuccess) {
            //error
        }
    });
}


#pragma mark -
#pragma mark Getter Methods
-(UIImage *) cacheImageForURL:(NSURL *)url{
    if (!url) {
        return nil;
    }
    
    id returner = [super objectForKey:url];
    if (returner) {
        return returner;
    }
    else {
        UIImage *i = [self imageFromDiskForURL:url];
        if (i) {
            [self setImage:i forURL:url];
        }
        return i;
    }
    
    return nil;
}

-(void)imageForUrl:(NSURL *)url completionBlock:(void (^)(UIImage *))completion{
    if(!url) return;
    
    UIImage *i = [self cacheImageForURL:url];
    if (i) {
        if (completion) {
            completion(i);
        }
    }else {
        [self _downloadAndWriteImageForURL:url completionBlock:^(UIImage *image) {
            if (completion) {
                completion(image);
            }
        }];        
    }
}

-(UIImage *)imageFromDiskForURL:(NSURL *)url{
    UIImage *i = [[UIImage alloc]initWithData:[NSData dataWithContentsOfFile:cachePathForURL(url) options:0 error:NULL]];
    return i;
    
}


- (void)storeImage:(UIImage*)image forKey:(NSURL*)key{
    
      [self setImage:image forURL:key];    
    [self storeData:UIImagePNGRepresentation(image) forKey:key];
    

}

- (void)storeData:(NSData*)data forKey:(NSURL*)key {
    
    NSString* filePath = cachePathForURL(key);
    NSFileManager* fm = [NSFileManager defaultManager];
 BOOL sucessful=     [fm createFileAtPath:filePath contents:data attributes:nil];
    if (sucessful) {
      
    }
    

}


#pragma mark -
#pragma mark Setter Methods
-(void) setImage:(UIImage *)i forURL:(NSURL *)url{
    if (i) {
        [super setObject:i forKey:url];
    }
}

-(void)removeImageForURL:(NSString *)url{
    [super removeObjectForKey:url];
}

#pragma mark Disk Writing Operations
-(void) writeData:(NSData *)data toPath:(NSString *)path{
    [data writeToFile:path atomically:YES];    
}

-(void) performDiskWriteOperation:(NSInvocation *)invocation{
    NSInvocationOperation *operation = [[NSInvocationOperation alloc] initWithInvocation:invocation];
    
    [self.diskOperationQueue addOperation:operation];
                            
}





@end
