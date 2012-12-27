//
//  UpScrollView.m
//  Summly
//
//  Created by zoe on 12-12-27.
//  Copyright (c) 2012年 zzlmilk. All rights reserved.
//

#import "UpScrollView.h"
#import "AFNetworking.h"

@implementation UpScrollView
//@synthesize imageBackView;

- (id)initWithFrame:(CGRect)frame summlys:(NSArray *)summlys
{
    self = [super initWithFrame:frame];
    if (self) {
        self.summlyArrs=summlys;
        
        for (int i=0; i<self.summlyArrs.count; i++) {
            
            [self createImageView:i summly:[self.summlyArrs objectAtIndex:i]];

        }
        
    }
    return self;
}


- (void)createImageView:(NSInteger)index summly:(Summly*)_summly{

    UIImageView *imageBackView = [[UIImageView alloc] initWithFrame:CGRectMake(320*index,0, 320, 183.5)];
    [imageBackView setBackgroundColor:[UIColor yellowColor]];
    NSString *randomImageName = [NSString stringWithFormat:@"grad%d@2x.png", arc4random() % 10+1];
    
//    if (_summly.imageUrl!=nil) {
//        [imageBackView setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",_summly.imageUrl]] placeholderImage:[UIImage imageNamed:randomImageName]];
//    }
  //  else{
        imageBackView.image = [UIImage imageNamed:randomImageName];
//    }
    [imageBackView setContentMode:UIViewContentModeScaleAspectFill];
    imageBackView.clipsToBounds=YES;
    imageBackView.userInteractionEnabled=YES;
    [self addSubview:imageBackView];
    
}

@end
