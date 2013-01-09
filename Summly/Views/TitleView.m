//
//  TitleView.m
//  Summly
//
//  Created by zoe on 13-1-8.
//  Copyright (c) 2013年 zzlmilk. All rights reserved.
//

#define MarginDic 10

#import "TitleView.h"
#import "Summly.h"

@implementation TitleView

- (id)initWithFrame:(CGRect)frame summlys:(NSArray *)summlys
{
    self = [super initWithFrame:frame];
    if (self) {
        
        for (int i=0; i<summlys.count; i++) {
            
            [self createTitleView:i summly:[summlys objectAtIndex:i]];
            
        }
   
    }
    return self;
}


- (void)createTitleView:(NSInteger)index summly:(Summly*)_summly{

    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(MarginDic+self.frame.size.width*index, 183.5-110, self.frame.size.width-20, 100)];
    titleLabel.userInteractionEnabled=YES;
    [titleLabel setBackgroundColor:[UIColor yellowColor]];
    [titleLabel setNumberOfLines:0];
    //        [titleLabel setFont:[UIFont systemFontOfSize:20]];
    [titleLabel setFont:[UIFont fontWithName:@"Hei SC" size:20]];
    [titleLabel setTextColor:[UIColor whiteColor]];
    //        titleLabel.shadowColor = [UIColor blackColor];
    //        titleLabel.shadowOffset = CGSizeMake(0, 0.8);
    titleLabel.text = _summly.title;
    [self addSubview:titleLabel];
    
    
}




@end
