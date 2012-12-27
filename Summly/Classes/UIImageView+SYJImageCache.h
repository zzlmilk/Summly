//
//  UIImageView+SYJImageCache.h
//  SyjRedess
//
//  Created by rex on 12-9-6.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImageView (SYJImageCache)

-(void)setImageWithURL:(NSURL*)url;

-(void)setImageWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholderImage;

-(void)setImageWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholderImage WithBlock:(void (^)(UIImage *image))block;


@end
