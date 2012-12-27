//
//  UIImageView+SYJImageCache.m
//  SyjRedess
//
//  Created by rex on 12-9-6.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "UIImageView+SYJImageCache.h"
#import "SYJImageChache.h"
#import <objc/runtime.h>


static char kSYJImageURLObjectKey;

@interface UIImageView(_SYJImageCache)

@property (nonatomic,readwrite,retain,setter = syj_setImageURL:)NSURL *syj_imageURL;

@end

@implementation UIImageView(_SYJImageCache)

@dynamic syj_imageURL;

@end

@implementation UIImageView (SYJImageCache)

#pragma mark  - Private Setters

-(NSURL *)syj_imageURL{
    return (NSURL *)objc_getAssociatedObject(self, &kSYJImageURLObjectKey);
}

-(void)syj_setImageURL:(NSURL *)imageURL{
    objc_setAssociatedObject(self, &kSYJImageURLObjectKey, imageURL, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

#pragma mark -Public Methods

-(void) setImageWithURL:(NSURL *)url{
    [self setImageWithURL:url placeholderImage:nil];
}

-(void)setImageWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholderImage{
    self.syj_imageURL = url;    
    UIImage *i = [[SYJImageChache shareCache] cacheImageForURL:url];    
    if (i) {
        self.image =i;
        self.syj_imageURL= nil;        
    }
    else {
        self.image = placeholderImage;
        
      __block UIImageView *safeSelf = self;
        
        
        [[SYJImageChache shareCache] imageForUrl:url completionBlock:^(UIImage *image) {
            if ([url isEqual:safeSelf.syj_imageURL]) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        safeSelf.image = image;
                        safeSelf.syj_imageURL = nil;
                    });
            }
        }];
    }
}


-(void)setImageWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholderImage WithBlock:(void (^)(UIImage *image))block{
    self.syj_imageURL = url;
    UIImage *i = [[SYJImageChache shareCache] cacheImageForURL:url];
    if (i) {
        self.image =i;
        self.syj_imageURL= nil;
    }
    else {
        self.image = placeholderImage;
        
        __block UIImageView *safeSelf = self;
        
        
        [[SYJImageChache shareCache] imageForUrl:url completionBlock:^(UIImage *image) {
            if ([url isEqual:safeSelf.syj_imageURL]) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    safeSelf.image = image;
                    safeSelf.syj_imageURL = nil;
                    if (block) {
                        block(image);
                    }

                });
            }
        }];
    }
}



@end
